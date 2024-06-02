class Pemasukan {
  final int id;
  final int totalPemasukan;
  final int tip;

  Pemasukan({
    required this.id,
    required this.totalPemasukan,
    required this.tip,
  });

  factory Pemasukan.fromJson(Map<String, dynamic> json) {
    return Pemasukan(
      id: json['id_pemasukan'] ?? 0,
      totalPemasukan: json['total_pemasukan'] ?? 0,
      tip: json['tip'] ?? 0, // Default value of 0 if tip is missing
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pemasukan': id,
      'total_pemasukan': totalPemasukan,
      'tip': tip,
    };
  }
}
