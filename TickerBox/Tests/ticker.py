import json
import websocket
import requests
import threading
import queue

ticker_url = 'http://192.168.1.227'
ws_url = 'wss://ws.kraken.com'


# Function to handle WebSocket messages
def on_message(ws, message):
    data = json.loads(message)
    if 'event' not in data and data[2] == 'trade':
        ticker = data[3]

        for x in data[1]:
            price = x[0]
            ticker = ticker.replace('/', '')
            # print(ticker, price)
            my_queue.put([ticker, float(price)])

my_queue = queue.Queue()
ws = websocket.WebSocketApp(ws_url, on_message=on_message)


# Function to connect to the Kraken WebSocket API
def connect_to_websocket():
    # Define the WebSocket URL

    # Define the subscription message for the BTC/USD trading pair
    subscribe_message = {
        "event": "subscribe",
        "pair": ["BTC/USD", "ETH/USD", "USDT/USD", "USDT/EUR", "SOL/USD"],
        "subscription": {
            "name": "trade"
        }
    }

    # Create a WebSocket connection

    # Send the subscription message to the WebSocket
    ws.on_open = lambda ws: ws.send(json.dumps(subscribe_message))

    # Start the WebSocket connection
    ws.run_forever()

# Main function to demonstrate the usage
def main():
    try:
        producer_thread = threading.Thread(target=connect_to_websocket)
        producer_thread.start()
        last_price = {}

        while True:
            try:
                [ticker,price] = my_queue.get(timeout=1)

                updates = {}
                updates[ticker] = price

                # conflate any pending updates and send last value only
                while not my_queue.empty():
                    [ticker,price] = my_queue.get(block=False)
                    updates[ticker] = price

                for ticker in updates:
                    price = updates[ticker]

                    direction = "up"
                    msg_body = {"ticker": ticker, "price": price}

                    if ticker in last_price:
                        if price < last_price[ticker]:
                            direction = "down"
                        elif price == last_price[ticker]:
                            direction = "same"

                    last_price[ticker] = price
                    print("Send", direction, ticker, price)

                    response = requests.put(f"{ticker_url}/{direction}/{ticker}", data=json.dumps(msg_body))
                    if response.status_code == 200:
                        print("\t", response.json())
                    else:
                        print(response.status_code, response.text)
            except queue.Empty:
                pass
    except KeyboardInterrupt:
        print("Exiting...")
        ws.close()

if __name__ == "__main__":
    main()
