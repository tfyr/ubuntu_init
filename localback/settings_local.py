localback = True

user_databases = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        # 'CONN_MAX_AGE': 3600,  # disable persistent connections for lock tables
        'CONN_MAX_AGE': 3600,
        'NAME': 'demands27',
        'USER': 'demands27',
        'PASSWORD': 'sXdfsdf33458Wwe1',
        # 'HOST': '127.0.0.1', 'PORT': '3307',
        'HOST': 'localhost', 'PORT': '3306',
        # 'ATOMIC_REQUESTS': True,
        # "ATOMIC_MUTATIONS": True,
        # 'HOST': '127.0.0.1', 'PORT': '3333',  # ssh -L 3333:127.0.0.1:3306 vds -N
        # 'HOST': '10.252.1.2', 'PORT': '3306',  # ssh -L 3333:127.0.0.1:3306 vds -N
        'OPTIONS': {
            'charset': 'utf8mb4',
            # "init_command": "SET default_storage_engine=MYISAM",
            # 'init_command': "SET NAMES 'utf8mb4';SET collation_connection = 'utf8mb4_unicode_ci'",
            # 'init_command': "SET GLOBAL connect_timeout = 120",
            # 'client_flag': 0,
        },
    },
}
