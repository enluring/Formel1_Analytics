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
file_path = os.path.join(script_dir, 'data', 'dbViews.sql')

# Read the view definitions from an SQL file
with open(file_path, 'r') as f:
    # Remove comments and blank lines from the SQL file
    view_sql = '\n'.join([line for line in f.readlines() if not line.strip().startswith('--') and line.strip() != ''])

print("Reading SQL file: " + file_path)

# Split the SQL file into separate statements
view_statements = view_sql.split(';')

# Create each view in the database with the name specified in the SQL file
for view_statement in view_statements:
    if "CREATE VIEW" in view_statement:
        #print(view_statement)
        view_name = view_statement.split()[2]
        view_statement = view_statement.strip()
        if view_statement != '':
            print("Creating view: " + view_name)
            cursor.execute(view_statement)
            # Check if the view was created successfully
            cursor.execute("SELECT COUNT(*) FROM pg_views WHERE viewname=%s;", (view_name,))
            view_count = cursor.fetchone()[0]
            if view_count == 1:
                print("View {} was created successfully.".format(view_name))
            else:
                print("View {} was not created successfully.".format(view_name))

# Close the cursor and connection
cursor.close()
conn.close()
