from dataclasses import dataclass
from fastapi import FastAPI
from models import Server , ServerStatusResponse , add_new_server , read_server_list
from models import check_server_exsist
import httpx

app = FastAPI()

@app.get("/server")
def get_server(srv: str):
    return check_server_exsist(srv)

@app.post("/server")
def put_server(srv: str):

    if srv == "":
        return ServerStatusResponse(server_name=srv,server_status="Invaild server name inserted")

    servers  = read_server_list()
    if srv in servers:
        return ServerStatusResponse(server_name=srv,server_status="Allready exsist")

    new_server = Server(
        name=srv,
        online=True,
        cpus=4,
        ram=8
    )

    add_new_server(new_server)
    return ServerStatusResponse(server_name=srv,server_status="Server created")
    


