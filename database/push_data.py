# Library
import psycopg2
import pandas as pd
from sqlalchemy import create_engine, text

# Define the database connection parameters
db_params = {
    'host': 'localhost',
    'database': 'camp2',
    'user': 'postgres',
    'password': '1234'
}

engine = create_engine(f'postgresql+psycopg2://{db_params["user"]}:{db_params["password"]}@{db_params["host"]}/{db_params["database"]}')
con = engine.connect()

csv_files = {
    'Arrival': './data/Arrival.csv',
    'Detachment': './data/Detachment.csv',
    'House': './data/House.csv',
    'Room': './data/Room.csv',
    'Bed': './data/Bed.csv',
    'Contact': './data/Contact.csv',
    'Client': './data/Client.csv',
    'Supervisor': './data/Supervisor.csv',
    'Users': './data/Users.csv',
}

for table_name, file_path in csv_files.items():
    df = pd.read_csv(file_path)

    if 'id' not in df.columns:
        df['id'] = range(1, len(df) + 1)

    df.to_sql(table_name, engine, if_exists='append', index=False)