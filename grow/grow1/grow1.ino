#include <WiFi.h>
#include <PubSubClient.h>
#include "arduino_secrets.h"

WiFiClient espClient;
PubSubClient client(espClient);

const char* mqtt_server = "homeassistant.localdomain";
const char* mqtt_topic  = "m5/cactus/humidity";

unsigned long lastMsg = 0;
#define MSG_BUFFER_SIZE (50)
char msg[MSG_BUFFER_SIZE];

void setupWifi();
void callback(char* topic, byte* payload, unsigned int length);
void reConnect();

void setup() {
    Serial.begin(9600); 
    setupWifi();
    client.setServer(mqtt_server, 1883);  
    client.setCallback(callback);  
}

void loop() {
    int val;
    if (!client.connected()) {
        reConnect();
    }
    client.loop();  
    unsigned long now = millis();
    if (now - lastMsg > 15000) {
        lastMsg = now;
        val = analogRead(G33); 
        snprintf(msg, MSG_BUFFER_SIZE, "%d",val); 
        Serial.println(msg);
        client.publish(mqtt_topic, msg); 
    }

}

void setupWifi() {
    delay(10);
    Serial.printf("Connecting to %s", SSID);
    WiFi.mode(WIFI_STA); 
    WiFi.begin(SSID, SSID_KEY);  

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
        if (client.connect(clientId.c_str(), MQTT_USER, MQTT_PASSWORD)) {
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
