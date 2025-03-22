
class CommonResponse {
  bool? status;
  String? message;

  CommonResponse({this.status, this.message});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["message"] is String) {
      message = json["message"];
    }
  }

  static List<CommonResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(CommonResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    return _data;
  }
}