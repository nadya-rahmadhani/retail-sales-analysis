-- =====================================================
-- Import Cleaned Data
-- =====================================================

-- CATATAN: Data diimport menggunakan Python script (import_cleaned_data.py)
-- dengan library SQLAlchemy + psycopg2, karena metode \copy pgAdmin GUI 
-- mengalami error parsing pada baris dengan karakter quote (") di dalam teks.
-- Script berada di: notebooks/import_cleaned_data.py

-- Cek jumlah baris yang berhasil diimport
SELECT COUNT(*) FROM superstore;

-- Preview data
SELECT * FROM superstore LIMIT 10;