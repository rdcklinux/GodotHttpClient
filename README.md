# GodotNetworking
El inicio para distintos modulos para el protocolo HTTP y la suit de aplicaciones entorno a él.

Inicialmente se implementan los metodos GET y POST de HTTP puedes usarlo sobre SSL (HTTPS), la respuesta es capturada en un
callback de tu código (función).

## Ejemplo de uso

Debes dejar el archivo **GodotNetworking.gd** en alguna parte de tu aplicación Godot,
luego cargalo como un singleton desde la confguración de tu proyecto y llamale **Networking**.
Haora puedes usarlo desde cualquier script gd usando:

### Request Comun

**var http = Networking.WebClient.new(...)**.


### OAuth2 Request

También se implementa el flujo oauth2 Client Credentials
esto permite comunicar tu aplicaion con una api que usa como capa de seguridad OAuth2

```
  var oauth2_flow = Networking.OAuth2.ClientCredentials.new(...)
	oauth2_client = Networking.OAuth2.Client.new('127.0.0.1', oauth2_flow, self)
	oauth2_client.request_access_token() #obtiene un access token desde OAuth2 server
```

Para ambos casos puedes ver un ejemplo del script en: **net.gd**

Al final de cada callback (tu función) es importante usar:
```
http.finish_request()
```
Esto es para optimizar rendimiento y no mantener en memoria recursos innecesarios.
