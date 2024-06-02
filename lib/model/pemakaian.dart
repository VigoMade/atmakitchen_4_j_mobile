class Pemakaian {
  String? idPemakaian;
  String? idBahanBaku;
  String? namaBahanBaku;
  String? tanggalPemakaian;
  int? totalPemakaian;
  String? satuan; // Menambahkan atribut satuan

  Pemakaian({
    this.idPemakaian,
    this.idBahanBaku,
    this.namaBahanBaku,
    this.tanggalPemakaian,
    this.totalPemakaian,
    this.satuan, // Memperbarui konstruktor
  });

  factory Pemakaian.fromJson(Map<String, dynamic> json) {
    return Pemakaian(
      idPemakaian: json['id_pemakaian'].toString(),
      idBahanBaku: json['id_bb'].toString(),
      namaBahanBaku: json['nama_bahan_baku'].toString(),
      tanggalPemakaian: json['tanggal_pemakaian'],
      totalPemakaian: json['total_pemakaian'] ?? 0,
      satuan: json['satuan_bahan_baku'], // Mengambil satuan dari JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pemakaian': idPemakaian,
      'id_bb': idBahanBaku,
      'nama_bahan_baku': namaBahanBaku,
      'tanggal_pemakaian': tanggalPemakaian,
      'total_pemakaian': totalPemakaian,
      'satuan_bahan_baku': satuan, // Menambahkan satuan ke dalam JSON
    };
  }
}
