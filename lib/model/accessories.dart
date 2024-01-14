class Accessories {
  List<Data>? data;
  String? message;

  Accessories({this.data, this.message});

  Accessories.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? kategoriId;
  String? namaAlat;
  String? deskripsi;
  int? harga24;
  int? harga12;
  int? harga6;
  String? gambar;
  String? createdAt;
  String? updatedAt;
  Category? category;

  Data(
      {this.id,
      this.kategoriId,
      this.namaAlat,
      this.deskripsi,
      this.harga24,
      this.harga12,
      this.harga6,
      this.gambar,
      this.createdAt,
      this.updatedAt,
      this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategoriId = json['kategori_id'];
    namaAlat = json['nama_alat'];
    deskripsi = json['deskripsi'];
    harga24 = json['harga24'];
    harga12 = json['harga12'];
    harga6 = json['harga6'];
    gambar = json['gambar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kategori_id'] = this.kategoriId;
    data['nama_alat'] = this.namaAlat;
    data['deskripsi'] = this.deskripsi;
    data['harga24'] = this.harga24;
    data['harga12'] = this.harga12;
    data['harga6'] = this.harga6;
    data['gambar'] = this.gambar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? namaKategori;
  Null? createdAt;
  String? updatedAt;

  Category({this.id, this.namaKategori, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKategori = json['nama_kategori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_kategori'] = this.namaKategori;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
