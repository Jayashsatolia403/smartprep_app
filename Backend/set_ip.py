import socket

ip = socket.gethostbyname(socket.gethostname())

f = open("/home/jayash/Desktop/Projects/smartprep_app/app/assets/text/ip.txt", "w")

f.write(ip)