import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInAdminController extends GetxController {
  final formField = GlobalKey<FormState>();
  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
  void signAdminIn(){}
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
}