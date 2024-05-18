// import 'dart:ffi';

class Produk {
  final int idProduk;
  final String? image;
  final String namaProduk;
  final String jenisProduk;
  final int? stockProduk;
  final DateTime? tanggalMulaiPo;
  final DateTime? tanggalSelesaiPo;
  final int? kuota;
  final int? idPenitip;
  final int? idResep;
  final int? hargaProduk;
  final String? satuanProduk;
  final String? status;
  final String? tipeProduk;

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
    this.tipeProduk,
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
      tipeProduk: json['tipe_produk'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_produk': idProduk,
      'image': image ?? "", // Return empty string if image is null
      'nama_produk': namaProduk,
      'jenis_produk': jenisProduk,
      'stock_produk': stockProduk,
      'tanggal_mulai_po': tanggalMulaiPo
          ?.toIso8601String(), // Convert DateTime to ISO 8601 string format
      'tanggal_selesai_po': tanggalSelesaiPo
          ?.toIso8601String(), // Convert DateTime to ISO 8601 string format
      'kuota': kuota,
      'id_penitip': idPenitip,
      'id_resep': idResep,
      'harga_produk': hargaProduk,
      'satuan_produk': satuanProduk,
      'status': status,
      'tipe_produk': tipeProduk,
    };
  }
}
