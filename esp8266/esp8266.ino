#include <ESP8266WebServer.h>
#include <ESP8266WiFi.h>
#include <FS.h>
#include <LittleFS.h>  
#include "secrets.h"

ESP8266WebServer server(80);

#define LED 4

void handleIndex() {
  if (!SPIFFS.begin()) {
    Serial.println("Error al montar el sistema de archivos");
    return;
  }

  File file = SPIFFS.open("/index.html", "r");
  if (!file) {
    Serial.println("Error al abrir el archivo");
    SPIFFS.end();
    return;
  }

  String fileText = "";

  while (file.available()) {
    fileText += file.readStringUntil('\n');
  }

  server.send(200, "text/html", fileText);
}

void handleToggleLed() {
  digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
  digitalWrite(LED, !digitalRead(LED));
  
  String response = "{\"state\":";

  if (digitalRead(LED_BUILTIN) == HIGH) response += "\"off\"";
  else response += "\"on\"";

  response += "}\n";
  
  server.send(200, "text/plain", response);
}

void setup(void) {
  Serial.begin(115200);

  Serial.print("Connecting");
  WiFi.begin(ssid, passPhrase);

  while (WiFi.status() != WL_CONNECTED) {
    delay(2000);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("CONNECTED");

  server.on("/", HTTP_GET, handleIndex);
  server.on("/", HTTP_POST, handleToggleLed);

  digitalWrite(LED, HIGH);

  server.begin();
  Serial.print("Server IP: http://");
  Serial.print(WiFi.localIP());
  Serial.print("/\n");
}


void loop(void) {
  server.handleClient();
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(LED, OUTPUT);
}
