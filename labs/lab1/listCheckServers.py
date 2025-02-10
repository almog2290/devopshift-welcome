servers = ["docker","apache2","nginx"]

def check_server_exsist(srv: str):
    try:
        if srv == "":
            raise ValueError(f"Invaild server name")
        elif not srv in servers:
            print("Server not found")
            raise ValueError(f"The server {srv} not recognized")
        else:
            print(f"The server {srv} is running")
    except ValueError as err:
        print("Error was made:",err)


while True:
    server = input("Enter server name or 0 for exit:")
    if server == "0":
        break
    check_server_exsist(server)