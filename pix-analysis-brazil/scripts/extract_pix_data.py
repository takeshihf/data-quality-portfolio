import requests
import pandas as pd

url = "https://api.bcb.gov.br/dados/serie/bcdata.sgs.XXXX/dados?formato=json"

response = requests.get(url)
data = response.json()

df = pd.DataFrame(data)
df.to_csv("pix_data.csv", index=False)

print("Data extracted successfully")
