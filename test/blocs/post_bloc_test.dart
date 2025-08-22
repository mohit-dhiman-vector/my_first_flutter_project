import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_first_flutter_project/core/base/base_state.dart';
import 'package:my_first_flutter_project/core/network/api_result.dart';
import 'package:my_first_flutter_project/data/models/post_model.dart';
import 'package:my_first_flutter_project/data/repositories/post_repository.dart';
import 'package:my_first_flutter_project/presentation/features/home/bloc/post_bloc.dart';
import 'package:my_first_flutter_project/presentation/features/home/bloc/post_event.dart';
import 'package:my_first_flutter_project/presentation/features/home/bloc/post_state.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late MockPostRepository mockPostRepository;
  late PostBloc postBloc;

  setUp(() {
    mockPostRepository = MockPostRepository();
    postBloc = PostBloc(mockPostRepository);
  });

  tearDown(() {
    postBloc.close();
  });

  final dummyPosts = [
    PostModel(id: 1, title: "Post 1"),
    PostModel(id: 2, title: "Post 2"),
  ];

  blocTest<PostBloc, BaseState>(
    'emits [LoadingState, PostLoadedState] when fetchPosts succeeds',
    build: () {
      when(() => mockPostRepository.fetchPosts())
          .thenAnswer((_) async => ApiResult.success(dummyPosts));
      return postBloc;
    },
    act: (bloc) => bloc.add(LoadPostsEvent()),
    expect: () => [
      isA<LoadingState>(),
      isA<PostLoadedState>().having((s) => s.posts.length, "post count", 2),
    ],
    verify: (_) {
      verify(() => mockPostRepository.fetchPosts()).called(1);
    },
  );

  blocTest<PostBloc, BaseState>(
    'emits [LoadingState, ErrorState] when fetchPosts fails',
    build: () {
      when(() => mockPostRepository.fetchPosts())
          .thenAnswer((_) async => ApiResult.failure("Failed to load posts"));
      return postBloc;
    },
    act: (bloc) => bloc.add(LoadPostsEvent()),
    expect: () => [
      isA<LoadingState>(),
      isA<ErrorState>().having((s) => s.message, "error message", "Failed to load posts"),
    ],
    verify: (_) {
      verify(() => mockPostRepository.fetchPosts()).called(1);
    },
  );
}
