class Pegawai {
  int? idPegawai;
  String? namapegawai;

  Pegawai({
    this.idPegawai,
    this.namapegawai,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['id_pegawai'],
      namapegawai: json['nama_pegawai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pegawai': idPegawai.toString(),
    };
  }
}
