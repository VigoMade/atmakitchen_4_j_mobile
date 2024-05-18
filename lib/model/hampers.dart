class Hampers {
  int? idHampers;
  int? hargaHampers;
  String? deskripsiHampers;
  String? namaHampers;
  String? image;

  Hampers({
    this.idHampers,
    this.hargaHampers,
    this.deskripsiHampers,
    this.namaHampers,
    this.image,
  });

  factory Hampers.fromJson(Map<String, dynamic> json) {
    return Hampers(
      idHampers: json['id_hampers'],
      hargaHampers: json['harga_hampers'],
      deskripsiHampers: json['deskripsi_hampers'],
      namaHampers: json['nama_hampers'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_transaksi': idHampers.toString(),
      'harga_hampers': hargaHampers,
      'deskripsi_hampers': deskripsiHampers,
      'nama_hampers': namaHampers,
      'image': image,
    };
  }
}
