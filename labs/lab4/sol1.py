import httpx
import time

url = 'https://jsonplaceholder.typicode.com/users/1'
headers = {"Authorization": "Bearer 1234567890"}

try:
    res = httpx.get(url)
    if res.status_code == 200:
        users = res.json()
        print("User ID: ", users['name'])
        print("User Name: ", users['username'])
        print("User Email: ", users['email'])
        print("User Address: ", users['address']['street'], users['address']['suite'], users['address']['city'], users['address']['zipcode'])

    elif res.status_code == 404:
        print('User Not Found')
    elif res.status_code >= 500:
        print('Internal Server Error')
except httpx.ConnectError as e:
    print(f'Error: {e}')


#################### part 2 ####################

url="https://api.example.com/system/metrics"
headers = {"Authorization": "Bearer YOUR_API_KEY"}
retries = 3
data = {"metrics": "cpu", "memory":"1024"}

for attempt in range (1, retries):
    try:
        res = httpx.post(url, headers=headers, json=data ,timeout=5)
        if res.status_code == 200:
            print("System Metrics:", res.json())
            break
        elif res.status_code == 401:
            print('Invalid API Key')
            break
        elif res.status_code == 500:
            print('Server is currently down.')
            break
    except httpx.ConnectError as e:
        print("Error: Unable to connect to the API.")
    except httpx.TimeoutException as e:
        print("Error: The request timed out.")
    except httpx.HTTPError as e:
        print(f"General httpx error occurred: {e}")


    if attempt < retries:
        print(f"Retrying in 2 seconds...")
        time.sleep(2)
    else:
        print("All retry attempts failed.")






