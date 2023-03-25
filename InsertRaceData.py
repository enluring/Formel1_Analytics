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
file_path = os.path.join(script_dir, 'data', 'races.csv')


# open CSV file and read contents into a list
with open(file_path, 'r') as csvfile:
    reader = csv.reader(csvfile)
    next(reader) # skip header row
    rows = [tuple(row) for row in reader]

# generate placeholders for SQL query
placeholders = ','.join(['%s'] * len(rows[0]))

# insert data into database
# --- raceId,year,round,circuitId,name,date,time,url,fp1_date,fp1_time,fp2_date,fp2_time,fp3_date,fp3_time,quali_date,quali_time,sprint_date,sprint_time
query = f"INSERT INTO races (raceId, year, round, circuitId, name, date, date, time, url, fp1_date,fp1_time,fp2_date,fp2_time,fp3_date,fp3_time,quali_date,quali_time,sprint_date,sprint_time) VALUES ({placeholders})"
cursor.executemany(query, rows)
conn.commit()

# close database connection
cursor.close()
conn.close()
