# Data Dictionary
## Retail Sales Analysis - Superstore Dataset

| Kolom | Tipe Data | Deskripsi |
|---|---|---|
| Row ID | Integer | ID unik untuk setiap baris data |
| Order ID | Text | ID unik untuk setiap transaksi/order |
| Order Date | Date | Tanggal order dibuat |
| Ship Date | Date | Tanggal barang dikirim |
| Ship Mode | Text | Metode pengiriman (Standard Class, Second Class, First Class, Same Day) |
| Customer ID | Text | ID unik pelanggan |
| Customer Name | Text | Nama pelanggan |
| Segment | Text | Segmen pelanggan (Consumer, Corporate, Home Office) |
| Country | Text | Negara tujuan pengiriman |
| City | Text | Kota tujuan pengiriman |
| State | Text | State/provinsi tujuan pengiriman |
| Postal Code | Text | Kode pos tujuan pengiriman |
| Region | Text | Wilayah (West, East, Central, South) |
| Product ID | Text | ID unik produk |
| Category | Text | Kategori produk (Furniture, Office Supplies, Technology) |
| Sub-Category | Text | Sub-kategori produk |
| Product Name | Text | Nama produk |
| Sales | Numeric | Total penjualan dalam USD |
| Quantity | Integer | Jumlah unit yang terjual |
| Discount | Numeric | Persentase diskon yang diberikan (0-1) |
| Profit | Numeric | Keuntungan dalam USD (bisa bernilai negatif) |

## Catatan Tambahan

- Dataset mencakup periode transaksi dari tahun 2014 hingga 2017
- Total baris data setelah proses cleaning: 9.994 baris
- Tidak ditemukan missing values pada dataset ini
- Kolom `Postal Code` disimpan sebagai teks (bukan angka) karena bersifat identifier, bukan nilai untuk dihitung