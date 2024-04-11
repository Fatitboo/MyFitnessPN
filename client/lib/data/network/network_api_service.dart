import 'dart:convert';
import 'dart:io';

import 'package:do_an_2/data/app_exceptions.dart';
import 'package:do_an_2/data/network/base_api_service.dart';
import 'package:do_an_2/res/store/storage.dart';
import 'package:http/http.dart' as http;

import '../../res/store/user.dart';

class NetworkApiService extends BaseApiService {
  String token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY)??"";
  final String baseUrl = "http://10.0.2.2:8088/api/v1";
  @override
  Future<http.Response> getApi(String path) async {
    dynamic responseJson;
    print(token);
    try {
      final response = await http.get(Uri.parse(baseUrl + path), headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      print(response.body);
      return response;
    } on SocketException {
      throw InternetException();
    }
  }

  @override
  Future<http.Response> postApi(String path, Object body) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl + path),
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);
      print(response.body);
      return response;
    } on SocketException {
      throw InternetException();
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException();
    }
  }
}
