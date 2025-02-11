from log import setup_logging

logger = setup_logging()

servers = {"docker": True , "apache2": False , "nginx": True}

def check_server_exsist(srv: str):
    lowercase_server = {key.strip().lower(): value for key,value in servers.items()}

    try:
        if srv == "":
            raise ValueError(f"Invaild server name inserted")
        elif lowercase_server[srv] == True:
            logger.info(f"The server {srv} is running")
            return {"Server": srv , "Status": "running"}
        else:
            logger.info(f"The server {srv} is not running")
            return {"Server": srv , "Status": "not running"}

    except KeyError as err:
        logger.error(f"Error Msg:{err}")
        return {"Server": None , "Status": f"The value key {err} not recognized"}
    except ValueError as err:
        logger.error(f"Error Msg:{err}")
        return {"Server": None , "Status": f"{err}"}