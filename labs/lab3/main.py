from dataclasses import dataclass
from fastapi import FastAPI
from tools import check_server_exsist ,servers
import httpx

app = FastAPI()

@app.get("/server/")
def check_server(server_name: str):
    return check_server_exsist(server_name)

@app.post("/server/")
def put_server(server_name: str):

    if server_name in servers:
        return {"Server": server_name , "Status": "Allready exsist"}

    servers[server_name] = True
    return {"Server": server_name , "Status": "Server created"}
    


