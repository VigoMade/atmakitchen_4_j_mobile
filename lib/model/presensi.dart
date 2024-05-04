class Presensi {
  int? idPresensi;
  DateTime? tanggalPresensi;
  String? statusPresensi;
  String? namapegawai;

  Presensi({
    this.idPresensi,
    this.tanggalPresensi,
    this.statusPresensi,
    this.namapegawai,
  });

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      idPresensi: json['id_presensi'],
      tanggalPresensi: DateTime.parse(json['tanggal_presensi']),
      statusPresensi: json['status_presensi'],
      namapegawai: json['nama_pegawai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_presensi': idPresensi.toString(),
      'tanggal_presensi': tanggalPresensi?.toIso8601String(),
      'status_presensi': statusPresensi,
      'nama_pegawai': namapegawai,
    };
  }
}
