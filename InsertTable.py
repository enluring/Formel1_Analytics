import psycopg2
import os

# Define the connection parameters
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
file_path = os.path.join(script_dir, 'Data', 'tables.sql')

# Read the SQL file and execute each statement
with open(file_path, 'r') as f:
    sql = f.read()

# Split the SQL statements by semicolons
statements = sql.split(';')

# Execute each statement
for statement in statements:
    if statement.strip() != '':
        cursor.execute(statement)

# Commit the changes and close the connection
conn.commit()
conn.close()
