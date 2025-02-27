localback = True
local_allowed_hosts = ['XXX',]
local_sklad_id = XXX
current_alco_audit_id = 1

arcus2_driver_path = '/home/pos/ArcusIngenicoDriver/Linux64/libarccom21036'
arcus2_code_page = 'cp1251'

user_databases = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'CONN_MAX_AGE': 3600,
        'NAME': 'demands27',
        'USER': 'demands27',
        'PASSWORD': 'sXdfsdf33458Wwe1',
        'HOST': 'localhost', 'PORT': '3306',
        'OPTIONS': {
            'charset': 'utf8mb4',
        },
    },
}

