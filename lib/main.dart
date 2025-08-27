import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_flutter_project/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:my_first_flutter_project/presentation/features/home/bloc/post_bloc.dart';
import 'package:my_first_flutter_project/presentation/routes/route_generator.dart';
import 'package:my_first_flutter_project/presentation/routes/route_names.dart';

import 'core/network/api_service.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/post_repository.dart';

void main() {
  // Initialize core services
  final authApiService = ApiService(baseUrl: "https://reqres.in/api/");
  final postApiService = ApiService(
    baseUrl: "https://jsonplaceholder.typicode.com",
  );

  // Create repositories
  final authRepository = AuthRepository(authApiService);
  final postRepository = PostRepository(postApiService);

  runApp(MyApp(authRepository: authRepository, postRepository: postRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final PostRepository postRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.postRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authRepository)),
        BlocProvider(create: (_) => PostBloc(postRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Enterprise BLoC App",
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: RouteNames.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
