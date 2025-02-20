import subprocess

command = "ls -la | grep part | awk -F ' ' '{print $9}'"

try:
    p = subprocess.run(command,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    if p.returncode == 0 :
        print (p.stdout.decode())
    else:
        print(f"Error:\n{p.stderr.decode()}")

except FileNotFoundError:
    print("Error: Command not found!")
except PermissionError:
    print("Error: Permission denied!")

