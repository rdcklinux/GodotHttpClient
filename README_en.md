# GodotNetworking
The solution for implement over HTTP protocol and the applications suite about its.

Implements GET and POST methods, SSL (HTTPS), responses are catched from a callback in your script (function).

Also, implements the OAuth2 ClientCredentials flow, I'll going to add other flows for OAuth2.

## Example

put the **GodotNetworking.gd** file in somewhere in your Godot app,
next load it as a singleton from proyect configuration, and name it **Networking**.
Now you can use from some script gd.

### For common Request

```
  var http = Networking.WebClient.new(...)
```

### For OAuth2 Request

Also implements OAuth2 ClientCredentials flow, this give communication with a api that using OAuth2 and your Godot app.
esto permite comunicar tu aplicación con una api que usa como capa de seguridad OAuth2

```
  var oauth2_flow = Networking.OAuth2.ClientCredentials.new(...)
  oauth2_client = Networking.OAuth2.Client.new('127.0.0.1', oauth2_flow, self)
  oauth2_client.request_access_token() #get an access token from OAuth2 server
```

For both cases you can see an example in **net.gd** script.

At bottom of each callback (your function) is important using:
```
http.finish_request()
```
or
```
oauth2_client.finish_request()
```

This is for performance reason and to free memory useless.
