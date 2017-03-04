extends Node

var http = null

func _ready():
	var GodotWebClient = load("GodotWebClient.gd").GodotWebClient
	http = GodotWebClient.new('127.0.0.1', 5000, self)
	http.get('/get', 'get_save', {"param":"query"})
	http.post('/save', 'post_save', {"param":"query"})

func get_save(result, response_code, headers, body):
	print("GET")
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8())
	http.terminate()
	
func post_save(result, response_code, headers, body):
	print("POST")
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8())
	http.terminate()
