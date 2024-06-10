import 'dart:io';
import 'package:do_an_2/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;
import '../app_exceptions.dart';

class PredictApiService extends BaseApiService {
  final String baseUrl = "http://10.0.2.2:3000/";

  @override
  Future getApi(String path) {
    // TODO: implement getApi
    throw UnimplementedError();
  }

  @override
  Future<http.StreamedResponse> postApi(String path, String filename) async {
    try {
      print("Dô");
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl + path));
      request.files.add(await http.MultipartFile.fromPath('image', filename));
      var res = await request.send();
      print(res);
      return res;
    } on SocketException {
      throw InternetException();
    }
  }
}
