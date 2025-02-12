import httpx
from time import sleep
import os

API_KEY = os.environ.get("API_KEY")


def print_user(user_id: str):
    URL = f"https://jsonplaceholder.typicode.com/users/{user_id}"
    try:
        response = httpx.get(URL)
        try:
            response.raise_for_status()
        except httpx.HTTPStatusError:
            if response.status_code == 404:
                print("User not found")
            elif response.status_code == 500:
                print("Server error. Please try again later")
            else:
                print("Something else happened")
        server_data = response.json()
        if server_data:
            print(server_data)
    except httpx.HTTPError:
        print("Couln't connect")


def get_metrics(metrics: str):
    print("Fetching system metrics...")
    retry = 3
    delay = 2
    URL = "https://api.example.com/system/metrics"
    params = {"metrics": metrics}
    headers = {"Authorization": f"Bearer {API_KEY}"}
    for i in range(retry):
        try:
            response = httpx.get(URL, params=params, headers=headers)
            if response.status_code == 401:
                print("Invalid API Key")
            elif response.status_code == 500:
                print("Server is currently down")
            break
        except httpx.HTTPError:
            print(f"Attempt {i + 1} failed: Server is currently down.")
            sleep(delay)
            print(f"Retrying in {delay} seconds...")


user_id = input("User id: ")
print_user(user_id)

get_metrics("cpu,memory")