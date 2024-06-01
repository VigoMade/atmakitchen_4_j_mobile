class Pesanan {
  String? idTransaksi;
  int? idCustomer;
  String? fotoProduk;
  String? namaProduk;
  String? statusPesanan;

  Pesanan({
    this.idTransaksi,
    this.fotoProduk,
    this.namaProduk,
    this.statusPesanan,
    this.idCustomer,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
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
