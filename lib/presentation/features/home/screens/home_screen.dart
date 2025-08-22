import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_flutter_project/presentation/features/home/bloc/post_bloc.dart';
import 'package:my_first_flutter_project/presentation/features/home/bloc/post_event.dart';
import 'package:my_first_flutter_project/presentation/features/home/bloc/post_state.dart';
import '../../../../core/base/base_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<PostBloc>().add(LoadPostsEvent());

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: BlocBuilder<PostBloc, BaseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostLoadedState) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text("Post ID: ${post.id}"),
                );
              },
            );
          } else if (state is ErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No data"));
        },
      ),
    );
  }
}
