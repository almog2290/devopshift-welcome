from dataclasses import dataclass
from fastapi import FastAPI
from models import Server , ServerStatusResponse , add_new_server , read_server_list
from models import check_server_exsist
import httpx

app = FastAPI()

@app.get("/server")
def get_server(srv: str) -> ServerStatusResponse:
    return check_server_exsist(srv)

@app.post("/server")
def put_server(srv: Server) -> ServerStatusResponse:

    if srv.name == "":
        return ServerStatusResponse(server_name=srv.name,server_status="Invaild server name inserted")

    servers  = read_server_list()
    if srv.name in servers:
        return ServerStatusResponse(server_name=srv.name,server_status="Allready exsist")

    add_new_server(srv)
    return ServerStatusResponse(server_name=srv.name,server_status="Server created")
    


