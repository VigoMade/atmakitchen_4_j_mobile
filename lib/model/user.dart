class User {
  int? idCustomer;
  String? nama;
  String? username;
  String? password;
  String? email;
  String? noTelpon;
  String? emailVerifiedAt;
  String? token;
  User({
    this.idCustomer,
    this.nama,
    this.username,
    this.password,
    this.email,
    this.noTelpon,
    this.emailVerifiedAt,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idCustomer: json['id_customer'],
      nama: json['nama'],
      email: json['email'],
      noTelpon: json['noTelpon'],
      username: json['username'],
      emailVerifiedAt: json['email_verified_at'],
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
    };
  }
}
