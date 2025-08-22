import 'package:my_first_flutter_project/core/base/base_state.dart';

class AuthSuccessState extends BaseState {}

class AuthFailureState extends BaseState {
  final String message;
  AuthFailureState(this.message);
}
