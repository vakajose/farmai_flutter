import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp/Constant/ConstantService.dart';
import 'package:myapp/util/shared_preferences.dart';


class AuthBll {
  final String api = ConstanstAplication.SERVER_API;

  Future<String> login(String email, String password) async {
    final String loginUrl = '$api/auth/login';
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        SharedPref.setString(ConstanstAplication.USER, responseBody['username']);
        return responseBody['username'];
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Credenciales inválidas');
      } else {
        throw HttpException('Failed to Login: ${response.statusCode}');
      }
    } catch (e) {
      if (e is UnauthorizedException) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }

  Future<String> register(String username, String password) async {
    final String registerUrl = '$api/auth/register';
    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Registro exitoso
        return responseBody['username'];
      } else if (response.statusCode == 400) {
        // Error de registro
        throw RegistrationException(responseBody['detail']);
      } else {
        // Otros errores
        throw HttpException('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      if (e is RegistrationException) {
        rethrow;
      }
      throw Exception('Network error: $e');
    }
  }
}
class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}
class RegistrationException implements Exception {
  final String message;
  RegistrationException(this.message);
}