from googletrans import Translator

class EngtoHindi:
    def __init__(self, s):
        self.s = s
    
    def convert(self):
        t = Translator()

        k = t.translate(self.s, "hindi")


        return k.text


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


                file.write(EngtoHindi(str(question)).convert())
                file.write("\n")
                file.write(str(len(answers)))
                file.write("\n")
                
                for ans in answers:
                    file.write(EngtoHindi(str(ans)).convert())
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