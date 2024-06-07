import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:do_an_2/model/planTypeDTO.dart';
import 'package:do_an_2/views/admin/plan_management/plan/plan_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/status/http_status.dart';

class PlanManagementController extends GetxController{


   @override
  void onInit() {
    super.onInit();
  }

   Rx<bool> loading = false.obs;
   final String baseUri = "/admin/plan-types";

   RxList listPlanTypes = [].obs;
   final NetworkApiService networkApiService = NetworkApiService();
   Rx<Offset> tapPosition = Offset.zero.obs;
   Rx<PlanTypeDTO> selectedPlanType = PlanTypeDTO.init().obs;
   var progressValue = 0.0.obs;
   var index = 0.obs;

   void changePage(int index){
     this.index.value = index;
     progressValue.value = index/4;
   }

   void getAllPlanTypes() async{
     loading.value = true;
     http.Response res = await networkApiService.getApi(baseUri);
     loading.value = false;
     if(res.statusCode == HttpStatus.ok){
       Iterable i = json.decode(utf8.decode(res.bodyBytes));
       List<PlanTypeDTO> planTypes = List<PlanTypeDTO>.from(i.map((model)=> PlanTypeDTO.fromJson(model))).toList();
       listPlanTypes.value = planTypes;
     }
     else{
       Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
       print(resMessage["message"]);
     }
   }

   Future<bool> createPlanType (Object planType) async{
     loading.value = true;
     http.Response res = await networkApiService.postApi("$baseUri/create-plan-type", planType);
     loading.value = false;
     if(res.statusCode == HttpStatus.created){
       PlanTypeDTO planTypeDTO = PlanTypeDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
       listPlanTypes.add(planTypeDTO);
       return true;
     }
     else{
       Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
       print(resMessage["message"]);
       return false;
     }
   }

   Future<bool> updatePlanType (Object planTypeObj, Map<String, dynamic> objJson) async{
     loading.value = true;
     http.Response res = await networkApiService.putApi("$baseUri/update-plan-type/${selectedPlanType.value.planTypeId}", planTypeObj);
     loading.value = false;
     if(res.statusCode == HttpStatus.ok){
       PlanTypeDTO planTypeDTO = PlanTypeDTO.fromJson(objJson);
       int index = listPlanTypes.indexWhere((element) => element.planTypeId == selectedPlanType.value.planTypeId);
       listPlanTypes.removeAt(index);
       listPlanTypes.insert(index, planTypeDTO);
       return true;
     }
     else{
       Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
       print(resMessage["message"]);
       return false;
     }
   }

   Future<bool> deletePlanType (String planTypeId, int index) async{
     loading.value = true;
     http.Response res = await networkApiService.deleteApi("$baseUri/delete-plan-type/$planTypeId");
     loading.value = false;
     if(res.statusCode == HttpStatus.ok){
       listPlanTypes.removeAt(index);
       return true;
     }
     else{
       Map<String, dynamic> resMessage = json.decode(utf8.decode(res.bodyBytes));
       print(resMessage["message"]);
       return false;
     }
   }

}