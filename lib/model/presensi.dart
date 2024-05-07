class Presensi {
  int? idPresensi;
  DateTime? tanggalPresensi;
  String? statusPresensi;
  String? namapegawai;
  int? idPegawai;

  Presensi({
    this.idPresensi,
    this.tanggalPresensi,
    this.statusPresensi,
    this.namapegawai,
    this.idPegawai,
  });

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      idPresensi: json['id_presensi'],
      tanggalPresensi: DateTime.parse(json['tanggal_presensi']),
      statusPresensi: json['status_presensi'],
      namapegawai: json['nama_pegawai'],
      idPegawai: json['id_pegawai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_presensi': idPresensi.toString(),
      'tanggal_presensi': tanggalPresensi?.toIso8601String(),
      'status_presensi': statusPresensi,
      'id_pegawai': idPegawai.toString(),
    };
  }
}
