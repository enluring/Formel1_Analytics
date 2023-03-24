import mysql.connector

# Connect to the database
db = mysql.connector.connect(
    host="172.19.0.2",
    user="f1admin",
    password="f1admin",
    database="f1db"
)

# Open the SQL file and read the commands
with open("tables.sql", "r") as f:
    commands = f.read()

# Split the commands into individual statements
statements = commands.split(";")

# Remove any whitespace or empty statements
statements = [s.strip() for s in statements if s.strip()]

# Execute each statement
for statement in statements:
    cursor = db.cursor()
    cursor.execute(statement)

# Close the database connection
db.close()
