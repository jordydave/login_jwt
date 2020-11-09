import 'package:login/model/api/api_auth_repository.dart';
import 'package:login/model/diagnostic/diagnostic.dart';
import 'package:login/model/register/register.dart';
import 'package:bloc/bloc.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);
}

class RegisterSuccess extends RegisterState {}

class RegisterEvent {
  final Register register;

  RegisterEvent(this.register);
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ApiAuthRepository apiAuthRepository = ApiAuthRepository();

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    Register register = event.register;
    String username = register.username;
    String password = register.password;
    int age = register.age;
    if (username == null || username.isEmpty) {
      print('username is required');
      yield RegisterFailure('Username is required');
      return;
    } else if (password == null || password.isEmpty) {
      yield RegisterFailure('Password is required');
      return;
    } else if (age <= 0) {
      yield RegisterFailure('Age must be greater than 0');
      return;
    }
    yield RegisterLoading();
    Diagnostic diagnostic = await apiAuthRepository.postRegisterUser(register);
    if (diagnostic.error != null) {
      yield RegisterFailure('${diagnostic.error}');
      return;
    }
    yield RegisterSuccess();
  }
}
