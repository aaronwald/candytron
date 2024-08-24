//https://github.com/m5stack/M5Atom/blob/master/examples/Advanced/MQTT/MQTT.ino

#include <WiFi.h>
#include <PubSubClient.h>

WiFiClient espClient;
PubSubClient client(espClient);


// Configure the name and password of the connected wifi and your MQTT Serve
// host.  配置所连接wifi的名称、密码以及你MQTT服务器域名
const char* ssid        = "xx";
const char* password    = "xx";
const char* mqtt_server = "homeassistant.localdomain";
const char* mqtt_topic  = "m5/humidity";

unsigned long lastMsg = 0;
#define MSG_BUFFER_SIZE (50)
char msg[MSG_BUFFER_SIZE];

void setupWifi();
void callback(char* topic, byte* payload, unsigned int length);
void reConnect();

void setup() {
    Serial.begin(9600); // open serial port, set the baud rate as 9600 bps

    setupWifi();
    client.setServer(mqtt_server,
                     1883);  
    client.setCallback(
        callback);  
}

void loop() {
    int val;
    if (!client.connected()) {
        reConnect();
    }
    client.loop();  // This function is called periodically to allow clients to
                    // process incoming messages and maintain connections to the

    unsigned long now =
        millis();  // Obtain the host startup duration.  获取主机开机时长
    if (now - lastMsg > 2000) {
        lastMsg = now;
        val = analogRead(G33); //connect sensor to Analog 0
        snprintf(msg, MSG_BUFFER_SIZE, "hello world #%d",val); 
        Serial.println(msg);
        client.publish(mqtt_topic, msg); 
    }

}

void setupWifi() {
    delay(10);
    Serial.printf("Connecting to %s", ssid);
    WiFi.mode(
        WIFI_STA);  // Set the mode to WiFi station mode.  设置模式为WIFI站模式
    WiFi.begin(ssid, password);  // Start Wifi connection.  开始wifi连接

    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.printf("\nSuccess\n");
}

void callback(char* topic, byte* payload, unsigned int length) {
    Serial.print("Message arrived [");
    Serial.print(topic);
    Serial.print("] ");
    for (int i = 0; i < length; i++) {
        Serial.print((char)payload[i]);
    }
    Serial.println();
}

void reConnect() {
    while (!client.connected()) {
        Serial.print("Attempting MQTT connection...");
        String clientId = "M5Stack-";
        clientId += String(random(0xffff), HEX);
        if (client.connect(clientId.c_str(), "xx", "xx")) {
            Serial.println("connected");
            client.publish(mqtt_topic, "hello world");
            client.subscribe(mqtt_topic);
        } else {
            Serial.print("failed, rc=");
            Serial.print(client.state());
            Serial.println("try again in 5 seconds");
            delay(5000);
        }
    }
}
