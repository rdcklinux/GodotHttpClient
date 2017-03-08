extends Node

class WebClient:
	var host = '127.0.0.1'
	var port = 80
	var use_ssl = false
	var __headers = StringArray([])
	var __queue = Array()
	var __client = null
	var object = null
	

	func _init(host, object, port=80, use_ssl=false):
		self.host = host
		self.port = port
		self.use_ssl = use_ssl
		self.object = object
		self.__client = HTTPClient.new()

	func __perform_request(method, callback, path, data=''):
		var http = HTTPRequest.new()
		var str_port = ''
		self.__queue.append({'http': http, 'cb': callback})
		self.object.add_child(http)
		if self.port != 80:
			str_port = ':' + str(self.port)
		var uri = 'http' + ('s' if self.use_ssl else '') + '://' + self.host + str_port
		http.connect("request_completed", self.object, callback)
		http.request(uri + path, self.__headers, true, method, data)

	func finish_request():
		if not self.__queue.empty():
			var http = self.__queue[0]['http']
			var callback = self.__queue[0]['cb']
			http.disconnect("request_completed", self.object, callback)
			http.queue_free()
			self.object.remove_child(http)
			self.__queue.pop_front()

	func set_headers(headers):
		self.__headers.append_array(headers)

	func get(path, callback, data={}):
		data = self.__client.query_string_from_dict(data)
		path += '?' + data if data != '' else ''
		self.__perform_request(HTTPClient.METHOD_GET, callback, path)

	func post(path, callback, data={}):
		self.__headers.append_array(['Content-Type: application/x-www-form-urlencoded'])
		data = self.__client.query_string_from_dict(data)
		self.__perform_request(HTTPClient.METHOD_POST, callback, path, data)

class OAuth2:

	class Client:
		var http = null
		var flow = null
		var access_token = ''
	
		func _init(host, flow, object, port=80, use_ssl=false):
			self.http = WebClient.new(host, object, port, use_ssl)
			self.flow = flow
			
		func request_access_token():
			self.flow.request_access_token(self.http)

		func set_access_token(token):
		  self.access_token = token

		func request(path, callback, headers=StringArray([]), data={}, method='GET'):
			headers.append_array(['Authorization: Bearer ' + self.access_token])
			self.http.set_headers(headers)
			if method == 'POST':
				self.http.post(path, callback, data)
			elif method == 'GET':
				self.http.get(path, callback, data)

		func finish_request():
			self.http.terminate()


	class ClientCredentials:
		var client_id = ''
		var client_secret = ''
		var method = 'POST'
		var access_token_path = ''
		var callback = null

		func _init(client_id, client_secret, access_token_path, callback, method='POST'):
			self.method = method
			self.client_id = client_id
			self.client_secret = client_secret
			self.access_token_path = access_token_path
			self.callback = callback
		
		func request_access_token(http):
			var data = {
			  'client_id' : self.client_id,
			  'client_secret' : self.client_secret,
			  'grant_type': 'client_credentials'
			}
			if self.method == 'POST':
				http.post(self.access_token_path, self.callback, data)
			elif self.method == 'GET':
				http.get(self.access_token_path, self.callback, data)

