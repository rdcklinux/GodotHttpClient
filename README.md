# GodotNetworking
El inicio para distintos modulos para el protocolo HTTP y la suit de aplicaciones entorno a él.

Inicialmente se implementan los metodos GET y POST de HTTP puedes usarlo sobre SSL (HTTPS), la respuesta es capturada en un
callback de tu código (función).

## Ejemplo de uso

Debes dejar el archivo **GodotNetworking.gd** en alguna parte de tu aplicación Godot,
luego cargalo como un singleton desde la confguración de tu proyecto y llamale **Networking**.
Haora puedes usarlo desde cualquier script gd usando:

**var http = Networking.WebClient.new(...)**.

Puedes ver un ejemplo del script en: **net.gd**

Al final de cada callback (tu función) es importante usar:
```
http.terminate()
```
Esto es para optimizar rendimiento y no mantener en memoria recursos innecesarios.
