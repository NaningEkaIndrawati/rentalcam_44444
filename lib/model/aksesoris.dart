class Aksesoris {
  int? id;
  String? namaKategori;
  String? namaAlat;
  String? deskripsi;
  int? harga24;
  int? harga12;
  int? harga6;
  String? gambar;
  String? createdAt;
  String? updatedAt;

  Aksesoris(
      {this.id,
      this.namaKategori,
      this.namaAlat,
      this.deskripsi,
      this.harga24,
      this.harga12,
      this.harga6,
      this.gambar,
      this.createdAt,
      this.updatedAt});

  Aksesoris.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKategori = json['category']['nama_kategori'];
    namaAlat = json['nama_alat'];
    deskripsi = json['deskripsi'];
    harga24 = json['harga24'];
    harga12 = json['harga12'];
    harga6 = json['harga6'];
    gambar = json['gambar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
