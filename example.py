import time

from MeteorClient import MeteorClient

client = MeteorClient('ws://127.0.0.1:3000/websocket')

sumA = 0
sumB = 0
n = 0

def subscribed(subscription):
    print('* SUBSCRIBED {}'.format(subscription))


def unsubscribed(subscription):
    print('* UNSUBSCRIBED {}'.format(subscription))


def added(collection, id, fields):
    global client
    print('* ADDED {} {}'.format(collection, id))
    print(id, fields['b']+fields['a'])
    client.call('setPythonSum', [{'id': id, 'pythonSum': fields['b']+fields['a']}])
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


def subscription_callback(error):
    if error:
        print(error)

client.on('subscribed', subscribed)
client.on('unsubscribed', unsubscribed)
client.on('added', added)
client.on('connected', connected)
client.on('changed', changed)


client.connect()
client.subscribe('pythonPublication')


# (sort of) hacky way to keep the client alive
# ctrl + c to kill the script
while True:
    try:
        time.sleep(1)
    except KeyboardInterrupt:
        break

client.unsubscribe('publicLists')