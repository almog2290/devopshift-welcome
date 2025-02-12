import subprocess

command = "systemctl status sshd"

try:
    p = subprocess.run(command.split(),stdout=subprocess.PIPE,stderr=subprocess.PIPE)

    if p.returncode == 0 :
        print (p.stdout.decode())
    else:
        print(f"Error:\n{p.stdout.decode()}\n{p.stderr.decode()}")

except FileNotFoundError:
    print("Error: Command not found!")
except PermissionError:
    print("Error: Permission denied!")

