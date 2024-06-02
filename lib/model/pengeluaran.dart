class PengeluaranLainnya {
  final int id;
  final String namaPengeluaran;
  final int biayaPengeluaran;

  PengeluaranLainnya({
    required this.id,
    required this.namaPengeluaran,
    required this.biayaPengeluaran,
  });

  factory PengeluaranLainnya.fromJson(Map<String, dynamic> json) {
    return PengeluaranLainnya(
      id: json['id_pengeluaran'] as int,
      namaPengeluaran: json['nama_pengeluaran_lainnya'] as String,
      biayaPengeluaran: json['biaya_pengeluaran_lainnya'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pengeluaran': id,
      'nama_pengeluaran_lainnya': namaPengeluaran,
      'biaya_pengeluaran_lainnya': biayaPengeluaran,
    };
  }
}
