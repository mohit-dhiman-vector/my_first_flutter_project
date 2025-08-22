import 'package:my_first_flutter_project/core/base/base_bloc.dart';
import 'package:my_first_flutter_project/core/base/base_event.dart';
import 'package:my_first_flutter_project/core/base/base_state.dart';
import 'package:my_first_flutter_project/data/repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends BaseBloc<BaseEvent, BaseState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(InitialState()) {
    on<LoadPostsEvent>((event, emit) async {
      emit(LoadingState());

      final result = await postRepository.fetchPosts();

      if (result.isSuccess) {
        emit(PostLoadedState(result.data!));
      } else {
        emit(ErrorState(result.error ?? "Unknown error"));
      }
    });
  }
}
