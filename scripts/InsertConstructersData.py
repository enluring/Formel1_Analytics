import csv
import psycopg2
import os

# set up database connection
conn_params = {
    "host": "172.19.0.2",
    "port": "5432",
    "database": "f1db",
    "user": "f1admin",
    "password": "f1admin"
}
# Connect to the PostgreSQL database
conn = psycopg2.connect(**conn_params)
cursor = conn.cursor()

# Get the path to the SQL file
script_dir = os.path.dirname(__file__)
file_path = os.path.join(script_dir, 'data', 'constructors.csv')


# open CSV file and read contents into a list
with open(file_path, 'r') as csvfile:
    reader = csv.reader(csvfile)
    next(reader) # skip header row
    rows = [[None if field == r' ' else field for field in row] for row in reader]

# generate placeholders for SQL query
placeholders = ','.join(['%s'] * len(rows[0]))

# insert data into database
## constructorId,constructorRef,name,nationality,url
query = f"INSERT INTO constructors (constructorId,constructorRef,name,nationality,url) VALUES ({placeholders})"
cursor.executemany(query, rows)
conn.commit()

# close database connection
cursor.close()
conn.close()