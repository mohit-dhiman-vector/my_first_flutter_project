import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_api_service.dart';
import 'api_result.dart';

class ApiService extends BaseApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  @override
  Future<ApiResult<dynamic>> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$endpoint"),
        headers: _defaultHeaders()..addAll(headers ?? {}),
      );
      return _processResponse(response);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<dynamic>> post(String endpoint, dynamic body, {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/$endpoint"),
        headers: _defaultHeaders()..addAll(headers ?? {}),
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<dynamic>> put(String endpoint, dynamic body, {Map<String, String>? headers}) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$endpoint"),
        headers: _defaultHeaders()..addAll(headers ?? {}),
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  @override
  Future<ApiResult<dynamic>> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$endpoint"),
        headers: _defaultHeaders()..addAll(headers ?? {}),
      );
      return _processResponse(response);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  // Default headers
  Map<String, String> _defaultHeaders() => {
    "Content-Type": "application/json",
  };

  // Global response handler
  ApiResult<dynamic> _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return ApiResult.success(jsonDecode(response.body));
      case 400:
        return ApiResult.failure("Bad Request: ${response.body}");
      case 401:
        return ApiResult.failure("Unauthorized");
      case 404:
        return ApiResult.failure("Not Found");
      case 500:
        return ApiResult.failure("Server Error");
      default:
        return ApiResult.failure("Unexpected error: ${response.statusCode}");
    }
  }
}
