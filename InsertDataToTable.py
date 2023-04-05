import csv
import os
from psycopg2.extras import execute_values
import psycopg2

# Connect to the database
# establish connection to the PostgreSQL server
conn = psycopg2.connect( 
    host="172.19.0.2",
    port="5432",
    database="f1db",
    user="f1admin",
    password="f1admin"
    )
cursor = conn.cursor()

# Define the folder containing the CSV files
DATA_DIR = "/home/harald/Formel1_Analytics/data"

# Define the order of the CSV files
csv_files = [
    "drivers.csv",
    "constructors.csv",
    "circuits.csv",
    "status.csv",
    "seasons.csv",
    "races.csv",
    "lap_times.csv",
    "pit_stops.csv",
    "qualifying.csv",
    "results.csv",
    "constructor_results.csv",
    "constructor_standings.csv",
    "driver_standings.csv"
]


# Loop through CSV files in the data directory
for file_name in csv_files:
    table_name = os.path.splitext(file_name)[0]
    file_path = os.path.join(DATA_DIR, file_name)
    with open(file_path, "r") as f:
        reader = csv.reader(f)
        header = next(reader)
        columns = ", ".join(header)
        print(f"Data from {file_name} inserted into table {table_name}")
        rows_to_insert = []
        for row in reader:
            # Replace '\N' values with None or an empty string
            row = [None if x in ['' ,'\\N'] or x.strip() == '' else x for x in row]
            try:
                rows_to_insert.append(tuple(row))
            except ValueError:
                continue
        try:
            execute_values(cursor, f"INSERT INTO {table_name} ({columns}) VALUES %s", rows_to_insert)
        except psycopg2.errors.UniqueViolation:
            conn.rollback()
            print(f"Skipping duplicate row in table {table_name}")
            continue
        conn.commit()

# Close the database connection
conn.close()
