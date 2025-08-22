import 'package:my_first_flutter_project/core/network/api_result.dart';
import 'package:my_first_flutter_project/core/network/api_service.dart';
import 'package:my_first_flutter_project/data/models/post_model.dart';

class PostRepository {
  final ApiService apiService;

  PostRepository(this.apiService);

  Future<ApiResult<List<PostModel>>> fetchPosts() async {
    final result = await apiService.get("posts");

    if (result.isSuccess) {
      try {
        final posts = (result.data as List)
            .map((e) => PostModel.fromJson(e))
            .toList();
        return ApiResult.success(posts);
      } catch (e) {
        return ApiResult.failure("Parsing error: $e");
      }
    } else {
      return ApiResult.failure(result.error ?? "Unknown error");
    }
  }
}
