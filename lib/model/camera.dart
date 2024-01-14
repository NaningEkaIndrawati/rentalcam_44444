class Kamera {
  final String id;
  final String kategoriId;
  final String namaAlat;
  final String? deskripsi;
  final String harga24;
  final String harga12;
  final String harga6;
  final String gambar;
  final String? createdAt;
  final String? updatedAt;
  final String category;

  Kamera({
    required this.id,
    required this.kategoriId,
    required this.namaAlat,
    this.deskripsi,
    required this.harga24,
    required this.harga12,
    required this.harga6,
    required this.gambar,
    this.createdAt,
    this.updatedAt,
    required this.category,
  });

  factory Kamera.fromJson(Map<String, dynamic> json) {
    return Kamera(
      id: json['id'].toString(), // Convert to String
      kategoriId: json['kategori_id'].toString(), // Convert to String
      namaAlat: json['nama_alat'],
      deskripsi: json['deskripsi'],
      harga24: json['harga24'].toString(), // Convert to String
      harga12: json['harga12'].toString(), // Convert to String
      harga6: json['harga6'].toString(), // Convert to String
      gambar: json['gambar'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      category: json['category']['nama_kategori'],
    );
  }
}
