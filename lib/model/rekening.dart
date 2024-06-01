import 'dart:convert';

class Rekening {
  final int idRekening;
  final int idCustomer;
  final String namaBank;
  final String nomorRekening;

  Rekening({
    required this.idRekening,
    required this.idCustomer,
    required this.namaBank,
    required this.nomorRekening,
  });

  factory Rekening.fromJson(Map<String, dynamic> json) {
    return Rekening(
      idRekening: json['id_rekening'] as int,
      idCustomer: json['id_customer'] as int,
      namaBank: json['nama_bank'] as String,
      nomorRekening: json['rekening_bank'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_rekening': idRekening,
      'id_customer': idCustomer,
      'nama_bank': namaBank,
      'rekening_bank': nomorRekening,
    };
  }
}
