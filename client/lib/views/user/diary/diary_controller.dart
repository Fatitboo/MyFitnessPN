import 'dart:convert';

import 'package:do_an_2/model/login_response.dart';
import 'package:do_an_2/res/store/storage.dart';
import 'package:do_an_2/res/store/store.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/network/network_api_service.dart';

class DiaryController extends GetxController {
  var str = "".obs;
  Future<void> getFoodSaved() async {
    try {
      LoginResponse loginResponse = LoginResponse.fromJson(
          jsonDecode(StorageService.to.getString(STORAGE_USER_PROFILE_KEY)));
      // print(loginResponse.userId);
      http.Response getApi = await NetworkApiService().getApi("/foods/${loginResponse.userId}/getFood");
      // print(getApi.body);
    } catch (err) {
      print(err);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getFoodSaved();
  }
}
