import 'package:do_an_2/data/network/network_api_service.dart';
import 'package:get/get.dart';

class ExerciseController extends GetxController{
  List<dynamic> myExercises = [].obs;

  late final NetworkApiService networkApiService;

  final String baseUri = "/api/v1/user/exercises/";


  @override
  void onInit() {
    networkApiService = NetworkApiService();
  }

  void getAllExercise (String userId) async {
    var res = await networkApiService.getApi(baseUri + userId);
    print(baseUri + userId);
    print("[RES]");
    print(res);
  }
}