from log import setup_logging

logger = setup_logging()

servers = {"docker": True , "apache2": False , "nginx": True}


def check_server_exsist(srv: str):
    lowercase_server = {key.strip().lower(): value for key,value in servers.items()}

    try:
        if srv == "":
            raise ValueError(f"Invaild server name")
        elif lowercase_server[srv] == True:
            logger.info(f"The server {srv} is running")
        else:
            logger.info(f"The server {srv} is not running")

    except KeyError as err:
        logger.error(f"Error Msg:{err}")
    except ValueError as err:
        logger.error(f"Error Msg:{err}")

while True:
    server = input("Enter server name or 0 for exit:")
    server = server.strip().lower()
    if server == "0":
        break
    check_server_exsist(server)