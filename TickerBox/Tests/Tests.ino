#include <functional>
#include <ESP8266WiFi.h>
#include <Pixie_Chroma.h>
#include <RichHttpServer.h>
#include "arduino_secrets.h"

using namespace std::placeholders;

PixieChroma pix;

// PixieChrome seems to mess up the serial monitor for debugging and makes it hard to debug the HTTP side
#define PIXIE_ENABLED 1

#define DATA_PIN 1 // GPIO to use for Pixie Chroma data line
#define PIXIES_X 5 // Total amount and arrangement
#define PIXIES_Y 1 // of Pixie PCBs = 2 x 1

// Define shorthand for common types
using RichHttpConfig = RichHttp::Generics::Configs::EspressifBuiltin;
using RequestContext = RichHttpConfig::RequestContextType;
SimpleAuthProvider authProvider;
RichHttpServer<RichHttpConfig> httpServer(80, authProvider);

void handleTick(RequestContext &request, CRGB color, const char *shortcode)
{
  JsonObject body = request.getJsonBody().as<JsonObject>();

  if (body.isNull())
  {
    request.response.setCode(400);
    request.response.json["error"] = F("Invalid JSON.  Must be an object.");
    return;
  }

  if (body.containsKey("price"))
  {
    Serial.println(request.pathVariables.get("ticker"));
    Serial.println(body["price"].as<float>());

    char buffer[100];
    if (shortcode)
    {
      sprintf(buffer, "%s %f %s", request.pathVariables.get("ticker"), body["price"].as<float>(), shortcode);
    }
    else
    {
      sprintf(buffer, "%s %f", request.pathVariables.get("ticker"), body["price"].as<float>());
    }
#ifdef PIXIE_ENABLED
    scrollMessage(buffer, color);
#endif
  }

  request.response.json["message"] = "{\"msg\": \"ok\"}";
}

void handleUpTick(RequestContext &request)
{
  handleTick(request, CRGB::Green, "[:ARROW_UP:]");
}

void handleDownTick(RequestContext &request)
{
  handleTick(request, CRGB::Red, "[:ARROW_DOWN:] ");
}

void handleSameTick(RequestContext &request)
{
  handleTick(request, CRGB::Blue, nullptr);
}

void setupWifi()
{
  Serial.begin(9600, SERIAL_8N1);
  delay(10);
  Serial.println();

  WiFi.setHostname("crowticker");
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
  delay(1);
}

void setupRichHTTP()
{
  authProvider.disableAuthentication();
  httpServer
      .buildHandler("/up/:ticker")
      .on(HTTP_PUT, std::bind(handleUpTick, _1));
  httpServer
      .buildHandler("/down/:ticker")
      .on(HTTP_PUT, std::bind(handleDownTick, _1));
  httpServer
      .buildHandler("/same/:ticker")
      .on(HTTP_PUT, std::bind(handleSameTick, _1));
  httpServer.clearBuilders();
  httpServer.begin();
}

void setupPixie()
{
  pix.set_scroll_type(SMOOTH);
  pix.begin(DATA_PIN, PIXIES_X, PIXIES_Y);
  pix.clear();
  pix.show();
}

void scrollMessage(const char *msg, CRGB color)
{
  pix.clear();
  pix.set_brightness(32);
  pix.color(color);
  pix.scroll_message(msg, 0);
}

void setup()
{
  setupWifi();
  setupRichHTTP();
#ifdef PIXIE_ENABLED
  setupPixie();
#endif
}

void loop()
{
  httpServer.handleClient();
}
