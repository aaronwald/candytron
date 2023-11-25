import json
import websocket
import requests

url = 'http://192.168.1.227'


# Function to handle WebSocket messages
def on_message(ws, message):
    data = json.loads(message)
    if 'event' not in data and data[2] == 'trade':
        ticker = data[3]

        for x in data[1]:
            price = x[0]
            print(ticker, price)
            try:
                response = requests.get(f"{url}/{ticker}_{x[0]}")
                if response.status_code == 200:
                    print(response.json())
            except e:
                print(e)

# Function to connect to the Kraken WebSocket API
def connect_to_websocket():
    # Define the WebSocket URL
    ws_url = 'wss://ws.kraken.com'

    # Define the subscription message for the BTC/USD trading pair
    subscribe_message = {
        "event": "subscribe",
        "pair": ["BTC/USD", "ETH/USD"],
        "subscription": {
            "name": "trade"
        }
    }

    # Create a WebSocket connection
    ws = websocket.WebSocketApp(ws_url, on_message=on_message)

    # Send the subscription message to the WebSocket
    ws.on_open = lambda ws: ws.send(json.dumps(subscribe_message))

    # Start the WebSocket connection
    ws.run_forever()

# Main function to demonstrate the usage
def main():
    try:
        # Connect to the Kraken WebSocket API
        connect_to_websocket()
    except KeyboardInterrupt:
        print("Exiting...")

if __name__ == "__main__":
    main()
