file = open("questions_final_hindi.txt", "r")

a = file.readlines()


for i in range(1, len(a)//10):
    if (a[i*10-1] != "\n"):
        print("Bad")

print("Success")