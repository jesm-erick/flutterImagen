class UsuarioModelo {
  String name, email, password;

  UsuarioModelo({this.name, this.email, this.password});

  factory UsuarioModelo.fromJson(Map<String, dynamic> map) {
    return UsuarioModelo(
      name: map["name"],
      email: map["email"],
      password: map["password"],
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }
}

class TokenModelo {
  String message;
  String token;
  TokenModelo({this.message, this.token});

    factory TokenModelo.fromJson(Map<String, dynamic> map) {
    return TokenModelo(
      message: map["message"],
      token: map["token"],
    );
  }
  Map<String, dynamic> toJson() {
    return {'message': message, 'token': token};
  }

}
