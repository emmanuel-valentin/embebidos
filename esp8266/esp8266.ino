#include <ESP8266WiFi.h>
const char* ssid = "";
const char* password = "";

WiFiServer server(80);

void setup() {
  Serial.begin(115200);
  delay(10);

  // Conecta a la red wifi.
  Serial.println();
  Serial.println();
  Serial.println("Conectando con");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("Conectado con WiFi");

  // Inicio del Servidor web.
  server.begin();
  Serial.println("Servidor web iniciado");

  // Esta es la IP a la cual deberas conectarte una vez se haya establecido comunicacion con el ESP. 
  // Es decir, cuando se vea en consola la IP, deberas, conectarte desde tu navegador a esa IP.
  Serial.print("Esta es la IP para conectar: ");
  Serial.print("http://");
  Serial.print(WiFi.localIP());
  Serial.println("/");
}

void loop() {
  // Consulta si se ha conectado algun cliente
  WiFiClient client = server.available();
  if (!client) {
    return;
  }

  // Espera hasta que el cliente envue datos
  Serial.println("Nuevo cliente");
  while(!client.available()) {
    delay(1);
  }

  // Pagina WEB 
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println(""); // Linea importante
  client.println("<!DOCTYPE HTML>");
  client.println("<html>");
  client.println("<head><meta charset=utf-8></head>");
  client.println("<body><font face='Arial'><center><h1>Practica de Servidor web con NodeMCU.</h1>");
  client.println("<h2><font color='#009900'>Grupo 6CV2</font></h2>");
  client.println("<h3>Página web.</h3>");
  client.println("<br><br>");
  client.println("<img src='https://lagarto.ipn.mx/images/2019/10/03/img_20190905_091841_124.jpg'><br>");
  client.println("<button>Sistemas </button>");
  client.println("<button>Embebidos </button>");
  client.println("<button>6CV2 </button>");
  client.println("<a href=\"/mensaje=4\"\"><button>Práctica </button></a>");
  client.println("</font></center></body></html>");
  Serial.println("Cliente desconectado.");

}
