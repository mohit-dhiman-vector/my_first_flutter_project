import 'package:my_first_flutter_project/core/base/base_bloc.dart';
import 'package:my_first_flutter_project/core/base/base_event.dart';
import 'package:my_first_flutter_project/core/base/base_state.dart';
import 'package:my_first_flutter_project/data/repositories/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends BaseBloc<BaseEvent, BaseState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(InitialState()) {
    on<RegisterEvent>((event, emit) async {
      emit(LoadingState());
      final result = await authRepository.register(event.email, event.password);

      if (result.isSuccess) {
        emit(AuthSuccessState());
      } else {
        emit(AuthSuccessState());
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(LoadingState());
      final result = await authRepository.login(event.email, event.password);
      if (result.isSuccess) {
        emit(AuthSuccessState());
      } else {
        emit(AuthFailureState("Invalid credentials"));
      }
    });
  }
}
