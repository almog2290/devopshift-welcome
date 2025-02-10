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
    
def setup_logging():
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
    return logger

