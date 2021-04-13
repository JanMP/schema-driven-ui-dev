import time

from MeteorClient import MeteorClient

client = MeteorClient('ws://127.0.0.1:3000/websocket')

n = 0

def subscribed(subscription):
    print('* SUBSCRIBED {}'.format(subscription))


def unsubscribed(subscription):
    print('* UNSUBSCRIBED {}'.format(subscription))


def added(collection, id, fields):
    global client, n
    n += 1
    print(n, end="\r", flush=True)
    if collection == 'test':
        client.call('setPythonSum', [{'id': id, 'pythonSum': fields['b']+fields['a']}])
        # print('* ADDED {} {}'.format(collection, id))
        # for key, value in fields.items():
        #     print('  - FIELD {} {}'.format(key, value))

def changed(collection, id, fields, cleared):
    print('* CHANGED {} {}'.format(collection, id))
    for key, value in fields.items():
        print('  - FIELD {} {}'.format(key, value))
    for key, value in cleared.items():
        print('  - CLEARED {} {}'.format(key, value))


def connected():
    print('* CONNECTED')

def logged_in(data):
    print('* LOGGED_IN')

def subscription_callback(error):
    if error:
        print(error)

def login_callback(error):
    if error:
        print(error)

client.on('connected', connected)
client.on('logged_in', logged_in)
client.on('subscribed', subscribed)
client.on('unsubscribed', unsubscribed)
client.on('added', added)
client.on('changed', changed)


client.connect()
client.login('pythonSum', 'Secret1234'.encode())
client.subscribe('pythonPublication')


# (sort of) hacky way to keep the client alive
# ctrl + c to kill the script
while True:
    try:
        time.sleep(1)
    except KeyboardInterrupt:
        break

client.unsubscribe('publicLists')