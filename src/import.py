import pandas as pd
from sqlalchemy import create_engine
import urllib



DB_CONFIG = {
    "server": "real-estate-server.database.windows.net",
    "database": "real-state_DB",
    "username": "real-estate",
    "password": "R_S_azure",
    "driver": "ODBC Driver 17 for SQL Server"
}

def create_connection_string(config):
    """Create a connection string for the SQL Server database."""
    params = urllib.parse.quote_plus(
        f"DRIVER={{{config['driver']}}};"
        f"SERVER={config['server']};"
        f"DATABASE={config['database']};"
        f"UID={config['username']};"
        f"PWD={config['password']}"
    )
    return f"mssql+pyodbc:///?odbc_connect={params}"

files = {
    'Properties': r'C:\Users\elsay\Desktop\EYouth_project - Real state\Real_state_data\Properties.csv',
    'Agents':     r'C:\Users\elsay\Desktop\EYouth_project - Real state\Real_state_data\Agents.csv',
    'Clients':    r'C:\Users\elsay\Desktop\EYouth_project - Real state\Real_state_data\Clients.csv',
    'Sales':      r'C:\Users\elsay\Desktop\EYouth_project - Real state\Real_state_data\Sales.csv',
    'Visits':     r'C:\Users\elsay\Desktop\EYouth_project - Real state\Real_state_data\Visits.csv'
}

def import_data(file_path, table_name):
    """Import data from a CSV file into the SQL Server database."""
    connection_string = create_connection_string(DB_CONFIG)
    engine = create_engine(connection_string)

    df = pd.read_csv(file_path)
    df.to_sql(table_name, con=engine, if_exists="append", index=False)

for table_name, file_path in files.items():
    try:
        import_data(file_path, table_name)
        print(f"✅ Data imported successfully from {file_path} to the table '{table_name}'.")
    except Exception as e:
        print(f"❌ Failed to import data from {file_path} to the table '{table_name}': {e}")
