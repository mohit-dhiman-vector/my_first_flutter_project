import 'package:my_first_flutter_project/core/network/api_result.dart';
import 'package:my_first_flutter_project/core/network/api_service.dart';
import 'package:my_first_flutter_project/data/models/user_model.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<ApiResult<UserModel>> register(String email, String password) async {
    final result = await apiService.post(
      "register",
      {"email": email, "password": password},
      headers: {"x-api-key": "reqres-free-v1"},
    );

    if (result.isSuccess) {
      try {
        final user = UserModel.fromJson(result.data);
        return ApiResult.success(user);
      } catch (e) {
        return ApiResult.failure("Parsing error: $e");
      }
    } else {
      return ApiResult.failure(result.error ?? "Unknown error");
    }
  }

  Future<ApiResult<UserModel>> login(String email, String password) async {
    final result = await apiService.post(
      "login",
      {"email": email, "password": password},
      headers: {"x-api-key": "reqres-free-v1"},
    );

    if (result.isSuccess) {
      try {
        final user = UserModel.fromJson(result.data);
        return ApiResult.success(user);
      } catch (e) {
        return ApiResult.failure("Parsing error: $e");
      }
    } else {
      return ApiResult.failure(result.error ?? "Unknown error");
    }
  }
}
