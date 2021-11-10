import socket

ip = socket.gethostbyname(socket.gethostname())

f = open(r"C:\Users\Jayash Satolia\Desktop\Projects\smartprep_app\app\assets\text\ip.txt", "w")

f.write(ip)