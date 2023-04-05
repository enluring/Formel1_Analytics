import os
import csv
import psycopg2
from psycopg2.extras import execute_values

# Connect to the database
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

# Loop through CSV files in the data directory
for file_name in os.listdir(DATA_DIR):
    if not file_name.endswith(".csv"):
        continue
    table_name = os.path.splitext(file_name)[0]
    file_path = os.path.join(DATA_DIR, file_name)
    with open(file_path, "r") as f:
        reader = csv.reader(f)
        header = next(reader)
        columns = ", ".join(header)
        print(f"Data from {file_name} updated in table {table_name}")
        for row in reader:
            # Replace '\N' values with None or an empty string
            row = [None if x in ['', '\\N'] or x.strip() == '' else x for x in row]
            # Convert numeric values to float
            row = [float(x) if x.replace(".", "", 1).isdigit() else x for x in row]
            # Generate SET clause for update query
            #set_clause = ", ".join([f"{col} = %s" for col in header])
            # Generate WHERE clause for update query
            #where_clause = " AND ".join([f"{header[i]} = %s" for i in range(len(header))])
            # Execute update query
            try:
                cursor.execute(f"UPDATE {table_name} SET {set_clause} WHERE {where_clause}", row + row)
                conn.commit()
            except psycopg2.errors.UniqueViolation:
                conn.rollback()
                print(f"Skipping duplicate row in table {table_name}")
                continue

# Close the database connection
conn.close()
