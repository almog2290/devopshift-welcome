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
            print(f"The server {srv} is running")
        else:
            print(f"The server {srv} is not running")
    except KeyError as err:
        print("Error was made:",err)
    except ValueError as err:
        print("Error was made:",err)

while True:
    server = input("Enter server name or 0 for exit:")
    if server == "0":
        break
    check_server_exsist(server)
