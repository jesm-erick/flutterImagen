class UsuarioModelo {
  String username, email, password;

  UsuarioModelo({this.username, this.email, this.password});

  factory UsuarioModelo.fromJson(Map<String, dynamic> map) {
    return UsuarioModelo(
      username: map["username"],
      email: map["email"],
      password: map["password"],
    );
  }
  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email, 'password': password};
  }
}

class TokenModelo {
  String message;
  String data;
  TokenModelo({this.message, this.data});

  factory TokenModelo.fromJson(Map<String, dynamic> map) {
    return TokenModelo(
      message: map["message"],
      data: map["data"],
    );
  }
  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data};
  }
}
