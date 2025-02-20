from os import path
from log import setup_logging
from pydantic import BaseModel, ValidationError
import json

logger = setup_logging()

class ServerStatusResponse(BaseModel):
    server_name: str | None
    server_status: str | bool

class Server(BaseModel):
    name: str
    online: bool
    cpus: int
    ram: int


def read_server_list() -> dict[str: Server]:
    if not path.exists("servers.txt"):
        with open("servers.txt", "w") as f:
            pass 

    with open("servers.txt", "r") as f:
        servers: dict[str: Server] = {}
        for line in f.readlines():
            if line.strip():
                json_object = json.loads(line)
                try:
                    new_server = Server(**json_object)
                    servers[new_server.name]=new_server
                except ValidationError:
                    pass                
    return servers


def add_new_server(new_server: Server):
    with open("servers.txt", "a") as f:
        f.write(f"{new_server.model_dump_json()}\n")


def check_server_exsist(srv: str):
    servers = read_server_list()
    try:
        if srv == "":
            raise ValueError(f"Invaild server name inserted")
        elif servers[srv].online == True:
            logger.info(f"The server {srv} is running")
            return ServerStatusResponse(server_name=srv,server_status=True)
    except KeyError or FileNotFoundError as err:
        logger.error(f"error msg => The value key {err} not recognized")
        return ServerStatusResponse(server_name=srv,server_status=f"The value key {err} not recognized")
    # VauleError or FileNotFoundError and other exceptions
    except Exception as err:
        logger.error(f"error msg => {err}")
        return ServerStatusResponse(server_name=None,server_status=f"{err}")

    logger.info(f"The server {srv} is not running")
    return ServerStatusResponse(server_name=srv,server_status=False)