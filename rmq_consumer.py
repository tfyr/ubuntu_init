import json
import requests
from pika import BlockingConnection, ConnectionParameters

from secret import telegram_bot_url1

connection = BlockingConnection(ConnectionParameters('localhost'))

channel = connection.channel()

channel.queue_declare(queue='tg')

def send_mess(chat, text, newurl=None, reply_markup=None, parse_mode=None):
    params = {'chat_id': chat, 'text': text}
    if reply_markup:
        params['reply_markup'] = reply_markup
    if parse_mode:
        params['parse_mode'] = parse_mode
    response = requests.post((url if not newurl else newurl)+ 'sendMessage', data=params)
    return response

def callback_tg(ch, method, properties, body):
    print(f"Сообщение: {body.decode()}")

    data = json.loads(body)
    send_mess(
        chat=data['chat_id'],
        text=data['msg'],
        newurl=telegram_bot_url1,)


channel.basic_consume(queue='tg',
                      on_message_callback=callback_tg,
                      auto_ack=True)
print("Ожидание сообщений")
channel.start_consuming()

