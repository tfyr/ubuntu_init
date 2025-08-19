import sys
from pika import BlockingConnection, ConnectionParameters


test_chat_id = -534237299
exchange_errors_chat_id = -4621737762

rabbit_connection = BlockingConnection(ConnectionParameters('localhost'))
channel = rabbit_connection.channel()
channel.queue_declare(queue='tg')


def tg_rabbit(chat_id, text):
    channel.basic_publish(exchange='',
                          routing_key='tg',
                          body=f'{{"chat_id": {chat_id}, "msg": "{text}" }}')


tg_rabbit(
          # test_chat_id,
          exchange_errors_chat_id,  
          f"{sys.argv[1]}: {sys.argv[2]}")
