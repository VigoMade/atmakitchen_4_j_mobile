class History {
  String? idTransaksi;
  int? idCustomer;
  String? fotoProduk;
  String? namaProduk;
  String? statusPesanan;

  History({
    this.idTransaksi,
    this.fotoProduk,
    this.namaProduk,
    this.statusPesanan,
    this.idCustomer,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      idTransaksi: json['id_transaksi'].toString(),
      idCustomer: json['id_customer'],
      fotoProduk: json['image'],
      namaProduk: json['nama_produk'],
      statusPesanan: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_transaksi': idTransaksi.toString(),
      'id_customer': idCustomer.toString(),
      'image': fotoProduk,
      'nama_produk': namaProduk,
      'status': statusPesanan,
    };
  }
}
