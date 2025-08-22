import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_flutter_project/core/base/base_state.dart';
import 'package:my_first_flutter_project/presentation/features/auth/bloc/auth_bloc.dart';
import 'package:my_first_flutter_project/presentation/features/auth/bloc/auth_event.dart';
import 'package:my_first_flutter_project/presentation/features/auth/bloc/auth_state.dart';
import 'package:my_first_flutter_project/presentation/routes/route_names.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: BlocConsumer<AuthBloc, BaseState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            Navigator.pushReplacementNamed(context, RouteNames.home);
          } else if (state is AuthFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
                TextField(controller: passCtrl, decoration: InputDecoration(labelText: "Password")),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      LoginEvent(emailCtrl.text, passCtrl.text),
                    );
                  },
                  child: Text("Login"),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, RouteNames.register),
                  child: Text("Don't have an account? Register"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

