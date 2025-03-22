import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mahal_app/core/apis.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/model/common/common_response.dart';

class LoginRepository {
  Future<CommonResponse?> login(
      {required String username, required String password}) async {
    try {
      final response = await dio.post(APIs.login,
          queryParameters: {"username": username, "password": password});
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CommonResponse.fromJson(jsonDecode(response.data));
      } else {
        return CommonResponse.fromJson(jsonDecode(response.data));
      }
    } on DioException catch (e) {
      return null;
    }
  }
}
