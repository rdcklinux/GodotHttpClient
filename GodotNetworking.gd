extends Node

class WebClient:
	var host = '127.0.0.1'
	var port = 5000
	var use_ssl = false
	var __headers = StringArray()
	var __queue = Array()
	var __client = null
	var object = null
	

	func _init(host, port, object, use_ssl=false):
		self.host = host
		self.port = port
		self.use_ssl = use_ssl
		self.object = object
		self.__client = HTTPClient.new()

	func __perform_request(method, callback, path, data=''):
		var http = HTTPRequest.new()
		self.__queue.append({'http': http, 'cb': callback})
		self.object.add_child(http)
		var uri = 'http' + ('s' if use_ssl else '') + '://' + host + ':' + str(port)
		http.connect("request_completed", self.object, callback)
		http.request(uri + path, self.__headers, true, method, data)

	func terminate():
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
