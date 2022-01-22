import os 





def update_database_file():
    return 

    os.system("rm /home/site/wwwroot/database/db.sqlite3")
    os.system("cp db.sqlite3 /home/site/wwwroot/database/")


def fetch_persistant_db_file():
    return

    try:
        path = "/home/site/wwwroot/database/db.sqlite3"
        f = open(path)
    except:
        os.system("cp db.sqlite3 /home/site/wwwroot/database/")


    os.system("rm db.sqlite3")
    os.system("cp /home/site/wwwroot/database/db.sqlite3 .")


SHOW_LOGGING = False

LOGGING = {
 'version': 1,
 'disable_existing_loggers': False,
 'filters': {
 'require_debug_false': {
 '()': 'django.utils.log.RequireDebugFalse'
    }
 },
 'handlers': {
 'logfile': {
 'class': 'logging.handlers.WatchedFileHandler',
 'filename': '/home/site/wwwroot/logs.log'
    }
 },
 'loggers': {
 'django': {
 'handlers': ['logfile'],
 'level': 'ERROR',
 'propagate': False,
    }
 }
}