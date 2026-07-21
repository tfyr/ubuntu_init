import sys
from pika import BlockingConnection, ConnectionParameters
from pika.credentials import PlainCredentials
from secret import rabbit_remote_user, rabbit_remote_password, rabbit_remote_host



test_chat_id = -534237299
exchange_errors_chat_id = -4621737762

rabbit_connection = BlockingConnection(ConnectionParameters(host=rabbit_remote_host, credentials=PlainCredentials(rabbit_remote_user, rabbit_remote_password) ))
channel = rabbit_connection.channel()
channel.queue_declare(queue='tg')


def tg_rabbit(chat_id, text):
    channel.basic_publish(exchange='',
                          routing_key='tg',
                          body=f'{{"chat_id": {chat_id}, "msg": "{text}" }}')


if __name__ == "__main__":
    tg_rabbit( # test_chat_id,
              exchange_errors_chat_id,
              f"{sys.argv[1]}: {sys.argv[2]}")
