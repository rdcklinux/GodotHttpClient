# GodotNetworking
La solucion para distintas implementaciones sobre el protocolo HTTP y la suite de aplicaciones entorno a él.

Inicialmente se implementan los metodos GET y POST de HTTP puedes usarlo sobre SSL (HTTPS), la respuesta es capturada en un
callback de tu código (función).
También se implementa el flujo OAuth2 ClientCredentials. Se irán agregando otros flujos para OAuth2.

## Ejemplo de uso

Debes dejar el archivo **GodotNetworking.gd** en alguna parte de tu aplicación Godot,
luego cargalo como un singleton desde la configuración de tu proyecto y llamale **Networking**.
Ahora puedes usarlo desde cualquier script gd

### Para Request Común

```
  var http = Networking.WebClient.new(...)
```

### Para OAuth2 Request

También se implementa el flujo oauth2 Client Credentials
esto permite comunicar tu aplicación con una api que usa como capa de seguridad OAuth2

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
ó
```
oauth2_client..finish_request()
```

Esto es para optimizar rendimiento y no mantener en memoria recursos innecesarios.
