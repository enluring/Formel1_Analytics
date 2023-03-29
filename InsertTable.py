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
file_path = os.path.join(script_dir, 'data', 'tables.sql')

# Read the SQL file and execute each statement
#with open(file_path, 'r') as f:
#    sql = f.read()

with open(file_path, 'r') as f:
    # Remove comments from the SQL file
    sql = '\n'.join([line for line in f.readlines() if not line.strip().startswith('--')])


# Split the SQL statements by semicolons
statements = sql.split(';')

# Execute each statement
for statement in statements:
    if statement.strip() != '':
        table_name = statement.split()[2]
        print(f"Trying to create table {table_name}")
        check_table_sql = f"SELECT to_regclass('{table_name}');"
        cursor.execute(check_table_sql)
        table_exists = cursor.fetchone()[0]
        if not table_exists:
            try:
                cursor.execute(statement)
            except Exception as e:
                print(f"Error executing statement: {statement}")
                print(f"Error message: {e}")
                conn.rollback()
                break


# Commit the changes and close the connection
conn.commit()
conn.close()
