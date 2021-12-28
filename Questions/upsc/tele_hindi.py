try:

    import requests
    import json

except Exception as e:
    print("Some Modules are Missing {}".format(e))


class WebCrawler(object):

    def __init__(self, data, sl, tl):
        self._headers = {'User-Agent': "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36"}
        self._base_url = "https://translate.googleapis.com/translate_a/single"
        self.data = data
        self.params = {
            "client": "gtx",
            "sl": sl,
            "tl": tl,
            "dt": "t",
            "q": self.data}

    @property
    def get(self):
        try:

            r = requests.get(url=self._base_url,
                             headers=self._headers,
                             params=self.params)

            data = r.json()
            return data[0][0][0]

        except Exception as e :
            print("Failed to Make Response  {}".format(e))

class EngtoHindi(object):

    def __init__(self, message):
        self.message = message
        self._crawler  = WebCrawler(data=self.message, sl="en", tl="hi")

    @property
    def convert(self):
        return self._crawler.get


class HindiToEng(object):

    def __init__(self, message):
        self.message = message
        self._crawler  = WebCrawler(data=self.message, sl="hi", tl="en")

    @property
    def convert(self):
        return self._crawler.get



from telethon import TelegramClient

api_id = 7544514
api_hash = '77944c05c35c878cfef5707c25aacb1a'
client = TelegramClient('anon', api_id, api_hash)

async def main():
    count = 1
    async for message in client.iter_messages(-1001269029231):

        if (message.poll):

            try:

                file = open("questions_hindi.txt", "a")


                question = message.poll.poll.question
                answers = []
                correct_answers = []

                for i in message.poll.poll.answers:
                    answer = str(i.text)
                    answer = answer.replace("\n", "ignore_new_line")
                    answers.append(answer)
                

                for i in message.poll.results.results: 
                    if i.correct:
                        correct_answers.append(str(i.option)[-2])
                
                count += 1

                question = question.replace("\n", "ignore_new_line")


                file.write(EngtoHindi(str(question)).convert)
                file.write("\n")
                file.write(str(len(answers)))
                file.write("\n")
                
                for ans in answers:
                    file.write(EngtoHindi(str(ans)).convert)
                    file.write("\n")

                
                for correct_answer in correct_answers:
                    file.write(correct_answer)
                    file.write(" ")
                
                file.write("\n\n")

                print("Success")

            
            except:
                print(">>> Unanswered Question")

with client:
    client.loop.run_until_complete(main())