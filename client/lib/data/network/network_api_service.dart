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
    try {
      final response = await http.get(Uri.parse(baseUrl+path), headers: {
        'content-type': 'application/json',

      });
      print(response.body);
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
