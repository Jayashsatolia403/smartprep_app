import os 





def update_database_file():

    os.system("rm /home/site/wwwroot/database/db.sqlite3")
    os.system("cp db.sqlite3 /home/site/wwwroot/database/")


def fetch_persistant_db_file():

    try:
        path = "/home/site/wwwroot/database/db.sqlite3"
        f = open(path)
    except:
        os.system("cp db.sqlite3 /home/site/wwwroot/database/")


    os.system("rm db.sqlite3")
    os.system("cp /home/site/wwwroot/database/db.sqlite3 .")