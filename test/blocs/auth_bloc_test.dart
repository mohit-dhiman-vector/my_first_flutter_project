import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_first_flutter_project/core/network/api_result.dart';
import 'package:my_first_flutter_project/data/models/user_model.dart';

import 'package:my_first_flutter_project/data/repositories/auth_repository.dart';
import 'package:my_first_flutter_project/core/base/base_state.dart';
import 'package:my_first_flutter_project/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:my_first_flutter_project/presentation/features/auth/bloc/auth_event.dart';
import 'package:my_first_flutter_project/presentation/features/auth/bloc/auth_state.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc Tests', () {
    final dummyUser = UserModel(
      id: 1,
      token: "abcd1234",
    );

    blocTest<AuthBloc, BaseState>(
      'RegisterEvent → emits [LoadingState, AuthSuccessState] on success',
      build: () {
        when(() => mockAuthRepository.register(any(), any()))
            .thenAnswer((_) async => ApiResult.success(dummyUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(RegisterEvent("test@email.com", "password")),
      expect: () => [
        isA<LoadingState>(),
        isA<AuthSuccessState>(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.register("test@email.com", "password"))
            .called(1);
      },
    );

    blocTest<AuthBloc, BaseState>(
      'LoginEvent → emits [LoadingState, AuthSuccessState] on success',
      build: () {
        when(() => mockAuthRepository.login(any(), any()))
            .thenAnswer((_) async => ApiResult.success(dummyUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginEvent("eve.holt@reqres.in", "cityslicka")),
      expect: () => [
        isA<LoadingState>(),
        isA<AuthSuccessState>(),
      ],
      verify: (_) {
        verify(() => mockAuthRepository.login("eve.holt@reqres.in", "cityslicka"))
            .called(1);
      },
    );

    blocTest<AuthBloc, BaseState>(
      'LoginEvent → emits [LoadingState, AuthFailureState] on failure',
      build: () {
        when(() => mockAuthRepository.login(any(), any()))
            .thenAnswer((_) async => ApiResult.failure("Invalid credentials"));
        return authBloc;
      },
      act: (bloc) => bloc.add(LoginEvent("wrong@email.com", "wrongpass")),
      expect: () => [
        isA<LoadingState>(),
        isA<AuthFailureState>(),
      ],
    );
  });
}
