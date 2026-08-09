from sqlalchemy import create_engine
import pandas as pd

# --- Konfigurasi koneksi ---
DB_USER = 'postgres'
DB_PASSWORD = 'admin'
DB_HOST = 'localhost'
DB_PORT = '5432'
DB_NAME = 'retail_sales_analysis'

# --- Load data ---
path = '../data/cleaned/superstore_cleaned.csv'
df = pd.read_csv(path)

# --- Samakan nama kolom dengan tabel PostgreSQL ---
df.columns = [c.lower().replace(' ', '_').replace('-', '_') for c in df.columns]

print(f"Jumlah baris yang akan diimport: {len(df)}")
print(df.head())

# --- Konek & import ---
engine = create_engine(f'postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}')
df.to_sql('superstore', engine, if_exists='append', index=False)

print("Import berhasil!")