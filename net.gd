extends Node

var http = null

func _ready():
	http = Networking.WebClient.new('127.0.0.1', 5000, self)
	http.get('/get', 'get_response', {"param":"query"})
	http.post('/save', 'post_response', {"param":"data"})

func get_response(result, response_code, headers, body):
	print("GET")
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8())
	http.terminate()
	
func post_response(result, response_code, headers, body):
	print("POST")
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8())
	http.terminate()
