import 'dart:convert';

class Penarikan {
  final int idPenarikan;
  final int idRekening;
  final int totalPenarikan;
  final String status;
  final String tanggal;
  final String namaCustomer;
  final String namaBank;
  final String nomorRekening;

  Penarikan({
    required this.idPenarikan,
    required this.idRekening,
    required this.totalPenarikan,
    required this.status,
    required this.tanggal,
    required this.namaCustomer,
    required this.namaBank,
    required this.nomorRekening,
  });

  factory Penarikan.fromJson(Map<String, dynamic> json) {
    return Penarikan(
      idPenarikan: json['id_penarikan'] as int,
      idRekening: json['id_rekening'] as int,
      totalPenarikan: json['total_penarikan'] as int,
      status: json['status_penarikan'] as String,
      tanggal: json['tanggal_penarikan'] as String,
      namaCustomer: json['nama_customer'] as String,
      namaBank: json['nama_bank'] as String,
      nomorRekening: json['rekening_bank'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_penarikan': idPenarikan,
      'id_rekening': idRekening,
      'total_penarikan': totalPenarikan,
      'status_penarikan': status,
      'tanggal_penarikan': tanggal,
      'nama_customer': namaCustomer,
      'nama_bank': namaBank,
      'rekening_bank': nomorRekening,
    };
  }
}
