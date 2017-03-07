extends Node

var http = null
var oauth2_client = null

func _ready():
  #Common Request
	http = Networking.WebClient.new('127.0.0.1', self, 5000)
	http.get('/get', 'get_response', {"param":"query"})
	http.post('/save', 'post_response', {"param":"data"})
	
	#OAuth2 Request
	var cid = 'my_client_id'
	var csc = 'my_client_secret'
	var get_token_path = '/oauth/v2/token'
	var flow = Networking.OAuth2.ClientCredentials.new(cid, csc, get_token_path, 'get_oauth2_access_token')
	oauth2_client = Networking.OAuth2.Client.new('127.0.0.1', flow, self)
	oauth2_client.request_access_token()

func get_response(result, response_code, headers, body):
	print("GET")
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8())
	http.finish_request()
	
func post_response(result, response_code, headers, body):
	print("POST")
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8())
	http.finish_request()
	
func get_oauth2_access_token(result, response_code, headers, body):
	var data = {}
	data.parse_json(body.get_string_from_utf8())
	oauth2_client.set_access_token(data['access_token'])
	oauth2_client.finish_request()
	var my_headers = StringArray(['X-Custom-Header: my_value_header'])
	oauth2_client.request('/1.0/list/download/report_197.csv', 'get_data', my_headers)


func get_data(result, response_code, headers, body):
	print(body.get_string_from_utf8())
	oauth2_client.finish_request()


