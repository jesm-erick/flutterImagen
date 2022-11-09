import 'package:app_upeu/modelo/PersonaModel.dart';
import 'package:app_upeu/modelo/UsuarioModel.dart';
import 'package:app_upeu/util/UrlApi.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
part 'persona_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class PersonaApi {
  factory PersonaApi(Dio dio, {String baseUrl}) = _PersonaApi;
  static PersonaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return PersonaApi(dio);
  }

  @POST("/apiv1/auth/login")
  Future<TokenModelo> login(@Body() UsuarioModelo usuario);
  @GET("/apiv1/persona/all")
  Future<ResponseModelo> getPersona(@Header("Authorization") String token);
  @POST("/apiv1/persona/create")
  Future<ResponseModelo> createPersona(
      @Header("Authorization") String token, @Body() PersonaModelo persona);
  @DELETE("/apiv1/persona/{id}")
  Future<ResponseModelo> deletePersona(@Path("id") int id);
  @PUT("/apiv1/persona/{id}")
  Future<ResponseModelo> updatePersona(@Header("Authorization") String token,
      @Path("id") int id, @Body() PersonaModelo persona);
}
