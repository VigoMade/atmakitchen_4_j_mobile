class History {
  int? idTransaksi;
  String? fotoProduk;
  String? namaProduk;
  String? statusPesanan;

  History({
    this.idTransaksi,
    this.fotoProduk,
    this.namaProduk,
    this.statusPesanan,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      idTransaksi: json['id_transaksi'],
      fotoProduk: json['image'],
      namaProduk: json['nama_produk'],
      statusPesanan: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_transaksi': idTransaksi.toString(),
      'image': fotoProduk,
      'nama_produk': namaProduk,
      'status': statusPesanan,
    };
  }
}
