#git clone git@github.com:tfyr/kirsa-pos.git
git clone https://__token__@github.com/tfyr/kirsa-pos.git
git clone https://__token__@github.com/tfyr/kirsa-kkm.git

cd ~/kirsa-pos
mkdir logs
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
viki_port = '/dev/ttyS91'
viki_baudrate = 115200
viki_options = 1

"| tee -a settings_local.py

python3 -m venv env
source env/bin/activate
pip3 install fastapi[standard] mysqlclient



