import 'dart:ffi';

class Produk {
  final int idProduk;
  final String namaProduk;
  final int? hargaProduk;
  final String jenisProduk;
  final String? satuanProduk;
  final int? idPenitip;
  final int? idResep;
  final int? stockProduk;
  final DateTime? tanggalMulaiPo;
  final DateTime? tanggalSelesaiPo;
  final int? kuota;
  final String? status;
  final String? image;

  Produk({
    required this.idProduk,
    required this.namaProduk,
    required this.hargaProduk,
    required this.jenisProduk,
    required this.satuanProduk,
    this.idPenitip,
    this.idResep,
    this.stockProduk,
    this.tanggalMulaiPo,
    this.tanggalSelesaiPo,
    this.kuota,
    this.status,
    this.image,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      idProduk: json['id_produk'],
      namaProduk: json['nama_produk'],
      hargaProduk: json['harga_produk'],
      jenisProduk: json['jenis_produk'],
      satuanProduk: json['satuan_produk'],
      idPenitip: json['id_penitip'],
      idResep: json['id_resep'],
      stockProduk: json['stock_produk'],
      tanggalMulaiPo: json['tanggal_mulai_po'] != null
          ? DateTime.parse(json['tanggal_mulai_po'])
          : null,
      tanggalSelesaiPo: json['tanggal_selesai_po'] != null
          ? DateTime.parse(json['tanggal_selesai_po'])
          : null,
      kuota: json['kuota'],
      status: json['status'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_produk'] = this.idProduk;
    data['nama_produk'] = this.namaProduk;
    data['harga_produk'] = this.hargaProduk;
    data['jenis_produk'] = this.jenisProduk;
    data['satuan_produk'] = this.satuanProduk;
    data['id_penitip'] = this.idPenitip;
    data['id_resep'] = this.idResep;
    data['stock_produk'] = this.stockProduk;
    data['tanggal_mulai_po'] = this.tanggalMulaiPo?.toString();
    data['tanggal_selesai_po'] = this.tanggalSelesaiPo?.toString();
    data['kuota'] = this.kuota;
    data['status'] = this.status;
    data['image'] = this.image;
    return data;
  }
}
