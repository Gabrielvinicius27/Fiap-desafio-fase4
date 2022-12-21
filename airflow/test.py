import requests
res = requests.get('http://data.insideairbnb.com/brazil/rj/rio-de-janeiro/2022-09-21/visualisations/listings.csv')
print(res.content)