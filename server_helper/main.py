import requests as re



url = "https://smartprep.azurewebsites.net/"




response = re.get(url)
print("Success : ", response.text[:12], "\n")