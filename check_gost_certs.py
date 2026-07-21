import sys
import requests
from datetime import datetime, timezone, timedelta
from tg_to_test_channel import tg_rabbit, test_chat_id, exchange_errors_chat_id

# ANSI escape-коды
RED    = "\033[91m"
YELLOW = "\033[93m"
RESET  = "\033[0m"
GREEN  = "\033[92m"

CHECK_MARK = "\u2705"   # ✅

def parse_custom_datetime(s: str) -> datetime:
    """
    Парсит строку вида '23.10.2025 11:17:00+0500' в aware datetime.
    """
    # Разделяем на дату+время и смещение
    # Пример: '23.10.2025 11:17:00+0500'
    date_part = s[:19]          # '23.10.2025 11:17:00'
    tz_part = s[19:]            # '+0500'

    # Парсим основную часть
    naive_dt = datetime.strptime(date_part, '%d.%m.%Y %H:%M:%S')

    # Парсим смещение: например +0500 → +05:00
    sign = 1 if tz_part[0] == '+' else -1
    hours = int(tz_part[1:3])
    minutes = int(tz_part[3:5])
    offset = timezone(timedelta(hours=sign * hours, minutes=sign * minutes))

    return naive_dt.replace(tzinfo=offset)


def main():
    if len(sys.argv) < 2:
        print("Usage: python check_cert.py <ip>", file=sys.stderr)
        sys.exit(1)

    ip = sys.argv[1]
    url = f"http://{ip}:8080/api/gost/orginfo"

    try:
        resp = requests.get(url, timeout=10)
        resp.raise_for_status()
        data = resp.json()
    except requests.RequestException as e:
        print(f"{YELLOW}Ошибка запроса к {url}: {e}{RESET}", file=sys.stderr)
        sys.exit(1)
    except ValueError as e:
        print(f"{YELLOW}Ошибка парсинга JSON: {e}{RESET}", file=sys.stderr)
        sys.exit(1)

    to_str = data.get("to")
    if not to_str:
        print("{YELLOW}Поле 'to' отсутствует в ответе{RESET}", file=sys.stderr)
        sys.exit(1)

    try:
        expire_dt = parse_custom_datetime(to_str)
    except Exception as e:
        print(f"Ошибка парсинга даты '{to_str}': {e}", file=sys.stderr)
        sys.exit(1)

    now = datetime.now(timezone.utc).astimezone()
    # Приводим expire_dt к локальному времени для корректного вычитания
    expire_local = expire_dt.astimezone()
    delta = expire_local - now

    if delta < timedelta(days=10):
        print(f"{RED}{ip} Сертификат ГОСТ истекает (осталось {delta.days} дн. {delta.seconds // 3600} ч.){RESET}")
        tg_rabbit( # test_chat_id, 
                  exchange_errors_chat_id,
                  f"{ip}, Сертификат ГОСТ истекает, осталось {delta.days} дн. {delta.seconds // 3600} ч.")
        sys.exit(99)
    else:
        print(f"{GREEN}{CHECK_MARK}{RESET} {ip} Сертификат ГОСТ действителен ещё {delta.days} дн.")


if __name__ == "__main__":
    main()
