import os
import sys
import logging
import json

log_level=os.environ.get("LOG_LEVEL","DEBUG")
log_format=os.environ.get("LOG_FORMAT","TEXT")

class JsonFromatter(logging.Formatter):
    def format(self,record : logging.LogRecord) -> str:
        log = {
            "timestamp": self.formatTime(record,self.datefmt),
            "level": record.levelname ,
            "message": record.getMessage()
        }
        return json.dumps(log)

servers = {
    "docker": True , 
    "apache2": False , 
    "nginx": True
}

def check_server_exsist(srv: str):
    try:
        if srv == "":
            raise ValueError(f"Invaild server name")
        elif servers[srv] == True:
            logger.info(f"The server {srv} is running")
        else:
            logger.info(f"The server {srv} is not running")

    except KeyError as err:
        logger.error(f"Error was made:{err}")
    except ValueError as err:
        logger.error(f"Error was made:{err}")

#logging.basicConfig(filename="myapp.log", level=log_level)
logger = logging.getLogger("myapp")
logger.setLevel(log_level)
stdout_handler = logging.StreamHandler(sys.stdout)
file_handler = logging.FileHandler("myapp.log")


if log_format == "JSON" :
    stdout_handler.setFormatter(JsonFromatter())
    file_handler.setFormatter(JsonFromatter())
else:
    stdout_handler.setFormatter(logging.Formatter())
    file_handler.setFormatter(logging.Formatter())

logger.addHandler(stdout_handler)
logger.addHandler(file_handler)    

while True:
    server = input("Enter server name or 0 for exit:")
    if server == "0":
        break
    check_server_exsist(server)
