class Riwayat {
  int? id;
  String? noInvoice;
  int? penyewaId;
  int? total;
  int? status;
  String? createdAt;
  String? updatedAt;
  Penyewa? penyewa;
  OrderApi? orderApi;

  Riwayat(
      {this.id,
      this.noInvoice,
      this.penyewaId,
      this.total,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.penyewa,
      this.orderApi});

  Riwayat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noInvoice = json['no_invoice'];
    penyewaId = json['penyewa_id'];
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    penyewa =
        json['penyewa'] != null ? new Penyewa.fromJson(json['penyewa']) : null;
    orderApi = json['order_api'] != null
        ? new OrderApi.fromJson(json['order_api'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_invoice'] = this.noInvoice;
    data['penyewa_id'] = this.penyewaId;
    data['total'] = this.total;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.penyewa != null) {
      data['penyewa'] = this.penyewa!.toJson();
    }
    if (this.orderApi != null) {
      data['order_api'] = this.orderApi!.toJson();
    }
    return data;
  }
}

class Penyewa {
  int? id;
  String? nama;
  String? email;
  String? password;
  String? telepon;
  String? alamat;
  String? ktp;
  String? createdAt;
  String? updatedAt;

  Penyewa(
      {this.id,
      this.nama,
      this.email,
      this.password,
      this.telepon,
      this.alamat,
      this.ktp,
      this.createdAt,
      this.updatedAt});

  Penyewa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    password = json['password'];
    telepon = json['telepon'];
    alamat = json['alamat'];
    ktp = json['ktp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['password'] = this.password;
    data['telepon'] = this.telepon;
    data['alamat'] = this.alamat;
    data['ktp'] = this.ktp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class OrderApi {
  int? id;
  int? alatId;
  int? penyewaId;
  int? paymentId;
  int? durasi;
  String? starts;
  String? ends;
  int? harga;
  int? status;
  String? createdAt;
  String? updatedAt;
  Alat? alat;

  OrderApi(
      {this.id,
      this.alatId,
      this.penyewaId,
      this.paymentId,
      this.durasi,
      this.starts,
      this.ends,
      this.harga,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.alat});

  OrderApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alatId = json['alat_id'];
    penyewaId = json['penyewa_id'];
    paymentId = json['payment_id'];
    durasi = json['durasi'];
    starts = json['starts'];
    ends = json['ends'];
    harga = json['harga'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    alat = json['alat'] != null ? new Alat.fromJson(json['alat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['alat_id'] = this.alatId;
    data['penyewa_id'] = this.penyewaId;
    data['payment_id'] = this.paymentId;
    data['durasi'] = this.durasi;
    data['starts'] = this.starts;
    data['ends'] = this.ends;
    data['harga'] = this.harga;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.alat != null) {
      data['alat'] = this.alat!.toJson();
    }
    return data;
  }
}

class Alat {
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

  Alat(
      {this.id,
      this.kategoriId,
      this.namaAlat,
      this.deskripsi,
      this.harga24,
      this.harga12,
      this.harga6,
      this.gambar,
      this.createdAt,
      this.updatedAt});

  Alat.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
