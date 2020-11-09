import 'package:login/model/api/api_auth_provider.dart';
import 'package:login/model/diagnostic/diagnostic.dart';
import 'package:login/model/login/login_body.dart';
import 'package:login/model/refreshtoken/refresh_token_body.dart';
import 'package:login/model/register/register.dart';
import 'package:login/model/token/token.dart';
import 'package:login/model/user/user.dart';

class ApiAuthRepository {
  final ApiAuthProvider _apiAuthProvider = ApiAuthProvider();

  Future<Diagnostic> postRegisterUser(Register register) =>
      _apiAuthProvider.registerUser(register);

  Future<Token> postLoginUser(LoginBody loginBody) =>
      _apiAuthProvider.loginUser(loginBody);

  Future<Token> postRefreshAuth(RefreshTokenBody refreshTokenBody) =>
      _apiAuthProvider.refreshAuth(refreshTokenBody);

  Future<User> fetchAllUsers() => _apiAuthProvider.getAllUsers();
}
