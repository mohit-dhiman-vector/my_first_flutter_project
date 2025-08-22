import 'package:my_first_flutter_project/core/base/base_event.dart';

class RegisterEvent extends BaseEvent {
  final String email;
  final String password;

  RegisterEvent(this.email, this.password);
}

class LoginEvent extends BaseEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}