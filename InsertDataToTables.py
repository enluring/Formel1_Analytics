import os
import csv
import psycopg2

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

# define mapping between CSV files and database tables
file_table_map = {
    'drivers.csv': {
        'table_name': 'drivers',
        'columns': ['driverId','driverRef','number','code','forename','surname','dob','nationality','url'],
        'path': '/data/drivers.csv'
    },
    'driver_standings.csv': {
        'table_name': 'driver_standings',
        'columns': ['driverStandingsId','raceId','driverId','points','position','positionText','wins'],
        'path': '/data/driver_standings.csv'
    },
    'constructors.csv': {
        'table_name': 'constructors',
        'columns': ['constructorId','constructorRef','name','nationality','url'],
        'path': '/data/constructors.csv'
    },
    'constructor_results.csv': {
        'table_name': 'constructor_results',
        'columns': ['constructorResultsId','raceId','constructorId','points','status'],
        'path': '/data/constructor_results.csv'
    },
    # add more file-table mappings as needed
}

# iterate through CSV files and insert into database
for filename, table_info in file_table_map.items():
    tablename = table_info['table_name']
    filepath = table_info['path']
    with open(filepath, 'r') as csvfile:
        reader = csv.reader(csvfile)
        next(reader) # skip header row
        rows = [[None if field == r'\N' else field for field in row] for row in reader]
        placeholders = ','.join(['%s'] * len(columns))
        column_names = ','.join(columns)
        query = f"INSERT INTO {tablename} ({column_names}) VALUES ({placeholders})"
        cursor.executemany(query, [row[:len(columns)] for row in rows])
        conn.commit()

# close database connection
cursor.close()
conn.close()
