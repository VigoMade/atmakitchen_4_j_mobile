class BahanBaku {
  final int id;
  final String nama;
  final int takaran;
  final String satuan;
  final String status;

  BahanBaku(
      {required this.id,
      required this.nama,
      required this.takaran,
      required this.satuan,
      required this.status});

  factory BahanBaku.fromJson(Map<String, dynamic> json) {
    return BahanBaku(
      id: json['id_bahan_baku'] as int,
      nama: json['nama_bahan_baku'] as String,
      takaran: json['takaran_bahan_baku_tersedia'] as int,
      satuan: json['satuan_bahan_baku'] as String,
      status: json['status_bb'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_bahan_baku': id,
      'nama_bahan_baku': nama,
      'takaran_bahan_baku_tersedia': takaran,
      'status_bb': satuan,
    };
  }
}
