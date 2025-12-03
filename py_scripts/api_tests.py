import requests
import json

# Buscar dados da API
response = requests.get("https://jsonplaceholder.typicode.com/posts")
data = response.json()

first_item = data[0]

output = {
    "title": first_item["title"],
    "body": first_item["body"]
}

print(json.dumps(output))