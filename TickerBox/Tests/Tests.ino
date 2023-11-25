#include <ESP8266WiFi.h>
#include <Pixie_Chroma.h> 
#include "arduino_secrets.h"
PixieChroma pix; 

#define DATA_PIN  1 // GPIO to use for Pixie Chroma data line
#define PIXIES_X  5  // Total amount and arrangement
#define PIXIES_Y  1  // of Pixie PCBs = 2 x 1

WiFiServer server(80);

void setupWifi()
{
  Serial.begin(9600, SERIAL_8N1);
  delay(10);
  Serial.println();

  WiFi.begin(SECRET_SSID, SECRET_PASS);

  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println();

  Serial.print("Connected, IP address: ");
  Serial.println(WiFi.localIP());
  server.begin();
}

void setupPixie() {
  pix.set_scroll_type(SMOOTH);
  pix.begin( DATA_PIN, PIXIES_X, PIXIES_Y );
  pix.clear();
  pix.show();
}

void setup() {
  setupWifi();
  setupPixie();
}

void loop() {
 // Check if a client has connected
  WiFiClient client = server.available();
  if (!client) {
    return;
  }
 
  // Wait until the client sends some data
  while(!client.available()){
    delay(1);
  }
 
  // Read the first line of the request
  client.readStringUntil(' ');
  String request = client.readStringUntil(' ');
  Serial.print("request:");
  Serial.println(request);
  client.flush();
  
  if (request && !request.isEmpty() && request.length() > 1) {
    pix.clear();
    pix.set_brightness(32);
    pix.color(CRGB::OrangeRed); 
    pix.scroll_message(&request.c_str()[1], 0); 
    // pix.show(); 
  }

  // Return the response
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: application/json");
  client.println();
  client.println("{\"msg\": \"ok\"}"); 
  client.println();
 
  delay(1);
}
