import 'dart:convert';
import 'package:do_an_2/models/login_response.dart';
import 'package:do_an_2/res/store/storage.dart';
import 'package:get/get.dart';

const String STORAGE_USER_PROFILE_KEY = 'user_profile';

const String STORAGE_USER_TOKEN_KEY = 'user_token';

const String STORAGE_DEVICE_FIRST_OPEN_KEY = 'device_first_open';

class UserStore extends GetxController {
  static UserStore get to => Get.find();
  bool isFirstOpen = false;
  final _isLogin = false.obs;
  String token = '';
  final _profile = LoginResponse().obs;

  bool get isLogin => _isLogin.value;
  LoginResponse get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    isFirstOpen = StorageService.to.getBool(STORAGE_DEVICE_FIRST_OPEN_KEY);
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(LoginResponse.fromJson(jsonDecode(profileOffline)));
    }
  }

  // token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  //  profile
  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    // var result = await UserAPI.profile();
    // _profile(result);
    // _isLogin.value = true;
    return StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  //  profile
  Future<void> saveProfile(LoginResponse profile) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    setToken(profile.token!);
  }

  //
  Future<void> onLogout() async {
    // if (_isLogin.value) await UserAPI.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
  }
  Future<bool> saveAlreadyOpen() {
    return StorageService.to.setBool(STORAGE_DEVICE_FIRST_OPEN_KEY, true);
  }
}
