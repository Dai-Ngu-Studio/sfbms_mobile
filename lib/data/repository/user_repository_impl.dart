import 'dart:developer';

import 'package:sfbms_mobile/data/models/user.dart';
import 'package:sfbms_mobile/data/remote/network/api_end_point.dart';
import 'package:sfbms_mobile/data/remote/network/base_api_service.dart';
import 'package:sfbms_mobile/data/remote/network/network_api_service.dart';
import 'package:sfbms_mobile/data/repository/interface/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<User> login({required String idToken}) async {
    try {
      dynamic response = await _apiService.postResponse(
        ApiEndPoint().user,
        function: "login",
        header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
      );

      log('UserRepositoryImpl :: login :: response: $response');

      return User.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
