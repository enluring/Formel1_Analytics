import psycopg2

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

# Read the SQL file and execute each statement
with open('tables.sql', 'r') as f:
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
