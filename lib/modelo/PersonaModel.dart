import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PersonaModelo {
  int id = 0;
  String dni, nombre, ap_paterno, ap_materno, telefono, genero, correo;
  PersonaModelo(
      {this.id,
      this.dni,
      this.nombre,
      this.ap_paterno,
      this.ap_materno,
      this.telefono,
      this.genero,
      this.correo});
  factory PersonaModelo.fromJson(Map<String, dynamic> map) {
    return PersonaModelo(
      id: map['id'] as int,
      dni: map['dni'],
      nombre: map['nombre'],
      ap_paterno: map['ap_paterno'],
      ap_materno: map['ap_materno'],
      telefono: map['telefono'],
      genero: map['genero'],
      correo: map['correo'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dni': dni,
      'nombre': nombre,
      'ap_paterno': ap_paterno,
      'ap_materno': ap_materno,
      'telefono': telefono,
      'genero': genero,
      'correo': correo,
    };
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["dni"] = dni;
    map["nombre"] = nombre;
    map["ap_paterno"] = ap_paterno;
    map["ap_materno"] = ap_materno;
    map["genero"] = genero;
    map["telefono"] = telefono;
    map["correo"] = correo;
    // if (id != null) {
    //   map["id"] = id;
    // }
    return map;
  }

  PersonaModelo.fromObject(dynamic o) {
    this.id = o["id"];
    this.dni = o["dni"];
    this.nombre = o["nombre"];
    this.ap_paterno = o["ap_paterno"];
    this.ap_materno = o["ap_materno"];
    this.genero = o["genero"];
    this.telefono = o["telefono"];
    this.correo = o["correo"];
    //this.edad = int.tryParse(o["edad"].toString());
  }

  @override
  String toString() {
    return 'PersonaModelo{id: $id,dni: $dni, nombre: $nombre, apellido_paterno:$ap_paterno,apellido_materno: $ap_materno, telefono: $telefono, genero: $genero, correo:$correo}';
  }
}

@JsonSerializable()
class ResponseModelo {
  List<PersonaModelo> data;
  String message;
  ResponseModelo({this.data, this.message});
  factory ResponseModelo.fromJson(Map<String, dynamic> map) {
    return ResponseModelo(
      data: (map['data'] as List)
          ?.map((e) => e == null
              ? null
              : PersonaModelo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      message: map['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'message': message,
    };
  }
}

@JsonSerializable()
class MsgModelo {
  String mensaje;

  MsgModelo({this.mensaje});
  factory MsgModelo.fromJson(Map<String, dynamic> map) {
    return MsgModelo(mensaje: map["mensaje"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'mensaje': mensaje,
    };
  }
}
