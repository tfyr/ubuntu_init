git clone git@github.com:tfyr/kirsa-pos.git
cd kirsa-pos
printf "localback = True
user_DEBUG = False

user_databases = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'CONN_MAX_AGE': 0,
        'NAME': 'demands27',
        'USER': 'demands27',
        'PASSWORD': 'sXdfsdf33458Wwe1',
        'HOST': 'localhost', 'PORT': '3306',
        'OPTIONS': {
            'charset': 'utf8mb4',
        },
    },
}
"| tee -a settings_local.py

python3 -m venv env
source env/bin/activate
pip3 install uvicorn fastapi[standard] mysqlclient


cat /etc/lsb-release

sudo cp ~/ubuntu_init/kirsa_pos.service /etc/systemd/system/
sudo systemctl enable kirsa_pos
sudo systemctl start kirsa_pos.service

sudo nano /etc/nginx/sites-available/kirsa

upstream kirsa_pos {
    server unix:///home/pos/kirsa-pos/kirsa-pos.sock;
}

    location ~ ^/(kirsa-pos) {
        proxy_pass http://kirsa_pos;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Важные настройки для WebSocket
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        # Таймауты
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

sudo nginx -s reload

