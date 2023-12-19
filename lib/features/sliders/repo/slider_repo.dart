import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:organic_foods_admin/constants/app_strings.dart';
import 'package:organic_foods_admin/models/api_response.dart';

import '../../../common/api.dart';
import '../../../constants/api_endpoints.dart';
import '../../../constants/app_helper.dart';
import '../../../models/app_slider.dart';
import '../../../models/data_result.dart';
import '../../../models/response_status.dart';

class SliderRepo {
  SliderRepo._();

  static Future<DataResult> getSliders() async {
    final DataResult dataResult = DataResult();

    final result = await Api.get(ApiEndPoints.getSliders);

    if (result.error == null) {
      final json = result.json != null ? result.json as List<dynamic> : [];

      final items = json.map((p) => AppSlider.fromJson(p)).toList();

      dataResult.data = items;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> deleteSlider(String id) async {
    final DataResult dataResult = DataResult();

    final result = await Api.delete(ApiEndPoints.deleteSlider(id));

    if (result.error == null) {
      final json = result.json != null ? result.json as Map<String, dynamic> : <String, dynamic>{};

      dataResult.data = ResponseStatus.fromJson(json);
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }

  static Future<DataResult> createSlider(List<String> images) async {
    DataResult dataResult = DataResult();

    try {
      final token = await AppHelper.getToken();
      var headers = {'Authorization': 'Bearer $token'};

      var url = Uri.parse(ApiEndPoints.createSlider);

      var request = http.MultipartRequest("POST", url);

      request.headers.addAll(headers);

      for (var img in images) {
        String ext = img.split('.').last;

        var file = await http.MultipartFile.fromPath("images", img, contentType: MediaType('image', ext));
        request.files.add(file);
      }

      final response = await request.send();

      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      final json = jsonDecode(responseString);

      if (response.statusCode == 200 || response.statusCode == 201) {
        dataResult.data = ResponseStatus.fromJson(json);
      } else {
        dataResult.error = AppHelper.handleError(response.statusCode, json);
      }
    } catch (e) {
      dataResult.error = AppString.somethingWentWrong;
    }

    return dataResult;
  }
}
