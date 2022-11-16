import 'dart:async';
import 'package:app_upeu/apis/persona_api.dart';
import 'package:app_upeu/modelo/PersonaModel.dart';
import 'package:app_upeu/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class PersonaRepository {
  PersonaApi personaApi;

  PersonaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    personaApi = PersonaApi(_dio);
  }

  Future<List<PersonaModelo>> getPersona() async {
    return await personaApi
        .getPersona(TokenUtil.TOKEN)
        .then((value) => value.data);
  }

  Future<ResponseModelo> deletePersona(int id) async {
    return await personaApi.deletePersona(id);
  }

  Future<ResponseModelo> updatePersona(int id, PersonaModelo persona) async {
    return await personaApi.updatePersona(TokenUtil.TOKEN, id, persona);
  }

  Future<ResponseModelo> createPersona(PersonaModelo persona) async {
    return await personaApi.createPersona(TokenUtil.TOKEN, persona);
  }
}
