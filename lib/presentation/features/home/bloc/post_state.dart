import 'package:my_first_flutter_project/core/base/base_state.dart';
import 'package:my_first_flutter_project/data/models/post_model.dart';

class PostLoadedState extends BaseState {
  final List<PostModel> posts;
  PostLoadedState(this.posts);
}
