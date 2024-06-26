class User {
  int? idCustomer;
  int? pointCustomer;
  int? saldoCustomer;
  String? nama;
  String? username;
  String? password;
  String? email;
  String? noTelpon;
  String? emailVerifiedAt;
  String? token;
  String? role;
  String? image;
  String? device_key;
  User(
      {this.idCustomer,
      this.pointCustomer,
      this.saldoCustomer,
      this.nama,
      this.username,
      this.password,
      this.email,
      this.noTelpon,
      this.emailVerifiedAt,
      this.token,
      this.role,
      this.image,
      this.device_key});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idCustomer: json['id_customer'],
      pointCustomer: json['poin_customer'] ?? 0,
      saldoCustomer: json['saldo_customer'] ?? 0,
      nama: json['nama'],
      email: json['email'],
      noTelpon: json['noTelpon'],
      username: json['username'],
      emailVerifiedAt: json['email_verified_at'],
      role: json['role'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_customer': idCustomer,
      'nama': nama,
      'username': username,
      'password': password,
      'email': email,
      'noTelpon': noTelpon,
      'email_verified_at': emailVerifiedAt,
      'token': token,
      'role': role,
      'image': image,
      'device_key': device_key,
    };
  }
}
