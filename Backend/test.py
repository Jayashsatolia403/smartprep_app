import requests as r

data = {"content" : 'a b c d e T F T F T', 'isCorrect' : True, 'statement' : "Please Solve the Question!", 'subject' : "quantApt"}

url = "http://127.0.0.1:8000/addQues/"

token = "Token aac66f1135786c6fe1e5e8e645b3c202fee49b40"


f = r.post(url, headers={'Authorization': token}, data=data)