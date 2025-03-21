
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:do_an_2/model/planDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../../../res/values/constants.dart';

class PlanController extends GetxController{
  RxBool loading = false.obs;
  RxInt currentDay = 0.obs;
  final String baseUri = "/plan/";
  final NetworkApiService networkApiService = NetworkApiService();
  Rx<DateTime> currentDate = (new DateTime.now()).obs;
  @override
  void onInit() {
  }

  void changeCurrentDate(int type){
    if(type > 0) {
      currentDate.value = currentDate.value.add(const Duration(hours: 24));
    }
    else{
      if(type < 0){
        currentDate.value = currentDate.value.subtract(const Duration(hours: 24));
      }
    }
    currentDate.refresh();
  }
}