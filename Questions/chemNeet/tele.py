from telethon import TelegramClient

# Remember to use your own values from my.telegram.org!
muttu_api_id = 11617933
muttu_api_hash = '8c0b10b74ab03bdc114bf55fe8f31ffa'
api_id = 7544514
api_hash = '77944c05c35c878cfef5707c25aacb1a'
client = TelegramClient('anon', api_id, api_hash)

async def main():
    # Getting information about yourself
    me = await client.get_me()

    # "me" is a user object. You can pretty-print
    # any Telegram object with the "stringify" method:
    # print(me.stringify())

    # When you print something, you see a representation of it.
    # You can access all attributes of Telegram objects with
    # the dot operator. For example, to get the username:
    username = me.username
    # print(username)
    # print(me.phone)

    # You can print all the dialogs/conversations that you are part of:
    # async for dialog in client.iter_dialogs():
    #     print(dialog.name, 'has ID', dialog.id)

    # You can send messages to yourself...
    # await client.send_message('me', 'Hello, myself!')
    # ...to some chat ID
    # await client.send_message(1057197716, 'Hello, group!')
    # # ...to your contacts
    # await client.send_message('+34600123123', 'Hello, friend!')
    # # ...or even to any username
    # await client.send_message('username', 'Testing Telethon!')

    # You can, of course, use markdown in your messages:
    # message = await client.send_message(
    #     'me',
    #     'This message has **bold**, `code`, __italics__ and '
    #     'a [nice website](https://example.com)!',
    #     link_preview=False
    # )

    # Sending a message returns the sent message object, which you can use
    # print(message.raw_text)

    # You can reply to messages directly if you have a message object
    # await message.reply('Cool!')

    # Or send files, songs, documents, albums...
    # await client.send_file('me', '/home/me/Pictures/holidays.jpg')

    # You can print the message history of any chat:
    count = 1
    async for message in client.iter_messages(-1001443947250):

        if (message.poll):

            try:

                file = open("questions_final.txt", "a")


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

                file.write(question)
                file.write("\n")
                file.write(str(len(answers)))
                file.write("\n")
                
                for ans in answers:
                    file.write(ans)
                    file.write("\n")

                
                for correct_answer in correct_answers:
                    file.write(correct_answer)
                    file.write(" ")
                
                file.write("\n")

                try:
                    solution = str(message.poll.results.solution)
                    solution = solution.replace("\n", "ignore_new_line")
                    file.write("y")
                    file.write("\n")
                    file.write(solution)
                except Exception as e:
                    print(e)
                
                file.write("\n\n")

                print("Success")

            
            except:
                print(">>> Unanswered Question")
            
            # break

        # x = message.poll

        # x.poll
        # else:
        #     print(message)

        # You can download media from messages, too!
        # The method will return the path where the file was saved.
        # if message.photo:
        #     path = await message.download_media()
        #     print('File saved to', path)  # printed after download is done

with client:
    client.loop.run_until_complete(main())






































# MessageMediaPoll(
#     poll=Poll(id=6208397603147612174, 
#     question='Amravati Stupa is (a famous specimen of the Buddhist art  and architecture of ancient India) located at which of the following State..', 
#     answers=[
#         PollAnswer(text='A: Andhra Pradesh', option=b'0'), 
#         PollAnswer(text='B: Telangana', option=b'1'), 
#         PollAnswer(text='C: Tamilnadu', option=b'2'), 
#         PollAnswer(text='D: Karnataka', option=b'3')], 
#     closed=False, 
#     public_voters=False, 
#     multiple_choice=False, 
#     quiz=True, 
#     close_period=None, 
#     close_date=None), 
#     results=PollResults(
#         min=False, 
#         results=[
#             PollAnswerVoters(option=b'0', voters=929, chosen=False, correct=True), 
#             PollAnswerVoters(option=b'1', voters=346, chosen=False, correct=False), 
#             PollAnswerVoters(option=b'2', voters=107, chosen=True, correct=False), 
#             PollAnswerVoters(option=b'3', voters=98, chosen=False, correct=False)], 
#         total_voters=1480, 
#         recent_voters=[], 
#         solution='Amrawati Stupa is located at Amravati in Andhra Pradesh, was built in 3rd century BC, and was  an important monastic centre till the 14th century AD and was discovered by Colin Mackenzie in 1797.', 
#         solution_entities=[]))



# Message(
#     id=28174, 
#     peer_id=PeerChannel(
#         channel_id=1239140977
#     ), 
#     date=datetime.datetime(2021, 12, 24, 3, 38, 45, tzinfo=datetime.timezone.utc), 
#     message='', 
#     out=False, 
#     mentioned=False, 
#     media_unread=False, 
#     silent=False, 
#     post=True, 
#     from_scheduled=False, 
#     legacy=False, 
#     edit_hide=False, 
#     pinned=False, 
#     from_id=None, 
#     fwd_from=None, 
#     via_bot_id=None, 
#     reply_to=None, 
#     media=MessageMediaPoll(
#         poll=Poll(
#             id=6208397603147612174, 
#             question='Amravati Stupa is (a famous specimen of the Buddhist art  and architecture of ancient India) located at which of the following State..', 
#             answers=[
#                 PollAnswer(text='A: Andhra Pradesh', option=b'0'), 
#                 PollAnswer(text='B: Telangana', option=b'1'), 
#                 PollAnswer(text='C: Tamilnadu', option=b'2'), 
#                 PollAnswer(text='D: Karnataka', option=b'3')], 
#             closed=False, 
#             public_voters=False, 
#             multiple_choice=False, 
#             quiz=True, 
#             close_period=None, 
#             close_date=None), 
#         results=PollResults(
#             min=False, 
#             results=[
#                 PollAnswerVoters(option=b'0', voters=997, chosen=False, correct=True), 
#                 PollAnswerVoters(option=b'1', voters=362, chosen=False, correct=False), 
#                 PollAnswerVoters(option=b'2', voters=118, chosen=True, correct=False), 
#                 PollAnswerVoters(option=b'3', voters=100, chosen=False, correct=False)], 
#             total_voters=1577, 
#             recent_voters=[], 
#             solution='Amrawati Stupa is located at Amravati in Andhra Pradesh, was built in 3rd century BC, and was  an important monastic centre till the 14th century AD and was discovered by Colin Mackenzie in 1797.', 
#             solution_entities=[])), 
#     reply_markup=None, 
#     entities=[], 
#     views=3753, 
#     forwards=12, 
#     replies=None, 
#     edit_date=None, 
#     post_author=None, 
#     grouped_id=None, 
#     restriction_reason=[], 
#     ttl_period=None)