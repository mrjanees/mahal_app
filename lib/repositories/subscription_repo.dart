import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:mahal_app/core/apis.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/model/common/common_response.dart';
import 'package:mahal_app/model/subscription/house_details_list.dart';
import 'package:mahal_app/model/subscription/huse_details.dart';
import 'package:mahal_app/model/subscription/subscription_add.dart';

class SubscriptionRepository {
  Future<HouseDetials?> getHouseDetials({required String houseNo}) async {
    try {
      final response = await dio.get(APIs.getSubsDetlsHouseByNumber,
          queryParameters: {"houseno": houseNo});
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HouseDetials.fromJson(jsonDecode(response.data));
      } else {
        return HouseDetials.fromJson(jsonDecode(response.data));
      }
    } on DioException catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<CommonResponse?> addSubcription(SubscriptionAdd addData) async {
    try {
      final response = await dio.post(APIs.addSubscription, queryParameters: {
        "houseno": addData.houseNo,
        "type": addData.type,
        "month": addData.month,
        "year": addData.year,
        "dateofcollection": addData.dateOfCollection,
        "amount": addData.amount
      });
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CommonResponse.fromJson(jsonDecode(response.data));
      } else {
        return CommonResponse.fromJson(jsonDecode(response.data));
      }
    } on DioException catch (e) {
      log(e.response.toString());
      return null;
    }
  }

  Future<HouseDetialsList?> getDateWiseCollection(
      {required String fromDate, required String toDate}) async {
    log("From Date: $fromDate");
    log("to Date: $toDate");
    try {
      final response = await dio.get(APIs.getSubsDetailsByDateWise,
          queryParameters: {"datefrom": fromDate, "dateto": toDate});
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HouseDetialsList.fromJson(jsonDecode(response.data));
      } else {
        return HouseDetialsList.fromJson(jsonDecode(response.data));
      }
    } on DioException catch (e) {
      log(e.toString());
      return null;
    }
  }
}
