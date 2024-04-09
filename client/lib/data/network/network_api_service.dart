import 'dart:convert';
import 'dart:io';

import 'package:do_an_2/data/app_exceptions.dart';
import 'package:do_an_2/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

 class NetworkApiService extends BaseApiService {
  final String baseUrl = "http://10.0.2.2:8088";
  @override
  Future<dynamic> getApi(String path) async {
    dynamic responseJson;
    print(baseUrl+path);

    try {
      final response = await http.get(Uri.parse(baseUrl+path), headers: {
        'content-type': 'application/json',
        // 'Bearer Token': 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOnsidGltZXN0YW1wIjoxNzExNzY1OTU5LCJkYXRlIjoxNzExNzY1OTU5MDAwfSwidXNlcm5hbWUiOiJ1c2VyMSIsInN1YiI6InVzZXIxIiwiZXhwIjoxNzE1MjI4MDY3fQ.bhN0GE0oYxrGtLETeOpueGDs-QjLh_Wucfqu4n1uxs0'
      });
      print(baseUrl+path);
      print(response.body);
      return response;
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
  }
  @override
  Future<dynamic> postApi(String path, Object body) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl+path), headers: {
        'content-type': 'application/json',

      },
      body: body);
      print(response.body);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
  }
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException();
      default:
        throw FetchDataException();

    }
  }
}
