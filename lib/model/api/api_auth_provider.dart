import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:login/model/diagnostic/diagnostic.dart';
import 'package:login/model/login/login_body.dart';
import 'package:login/model/refreshtoken/refresh_token_body.dart';
import 'package:login/model/register/register.dart';
import 'package:login/model/token/token.dart';
import 'package:login/model/user/user.dart';
import 'package:login/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:login/utils/dio_logging_interceptor.dart';

class ApiAuthProvider {
  final Dio _dio = new Dio();
  final String _baseUrl = 'https://project.bintorobuild.co.id/api/v2/';
  final String clientId = 'oke';
  final String clientSecret = 'oke';

  ApiAuthProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Future<Diagnostic> registerUser(Register register) async {
    try {
      final response = await _dio.post(
        'register/user',
        data: register.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return Diagnostic.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Diagnostic.withError('$error');
    }
  }

  Future<Token> loginUser(LoginBody loginBody) async {
    try {
      final response = await _dio.post(
        'login',
        data: FormData.fromMap(loginBody.toJson()),
        options: Options(
          headers: {
            'Authorization': 'Basic${base64Encode(
              utf8.encode('$clientId:$clientSecret'),
            )}',
          },
          // followRedirects: false,
          // validateStatus: (status) {
          //   return status < 500;
          // },
        ),
      );
      return Token.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Token.withError('$error');
    }
  }

  Future<Token> refreshAuth(RefreshTokenBody refreshTokenBody) async {
    try {
      final response = await _dio.post(
        'validate_login',
        data: FormData.fromMap(refreshTokenBody.toJson()),
        options: Options(
          headers: {
            'Authorization': 'Basic ${base64Encode(
              utf8.encode('$clientId:$clientSecret'),
            )}',
            HttpHeaders.authorizationHeader:
                SharedPreferencesManager.keyAccessToken,
          },
          // followRedirects: false,
          // validateStatus: (status) {
          //   return status < 500;
          // },
        ),
      );
      return Token.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return Token.withError('$error');
    }
  }

  Future<User> getAllUsers() async {
    try {
      print('getAllUsers');
      final response = await _dio.post(
        'validate_login',
        options: Options(
          headers: {
            'requirestoken': true,
          },
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      return User.fromJson(response.data);
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      return User.withError('$error');
    }
  }

  void _printError(error, StackTrace stacktrace) {
    debugPrint('error: $error & stacktrace: $stacktrace');
  }
}
