import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:do_an_2/model/detectResponseDTO.dart';
import 'package:do_an_2/model/foodWithDetectImageDTO.dart';
import 'package:do_an_2/model/mealDTO.dart';
import 'package:do_an_2/model/recipeDTO.dart';
import 'package:http/http.dart' as http;
import 'package:bottom_picker/bottom_picker.dart';
import 'package:do_an_2/data/network/predict_api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../data/network/cloudinary.dart';
import '../../../../data/network/network_api_service.dart';
import '../../../../model/foodDTO.dart';
import '../../../../model/logDiaryDTO.dart';
import '../../../../res/service/remote_service.dart';
import '../../../../res/values/constants.dart';
import '../../diary/diary_controller.dart';

class PickImageController extends GetxController {
  Rx<XFile> thumbnail = XFile('').obs;
  Rx<File> thumbnaiSend = File('').obs;
  var loading = true.obs;
  final List<String> itemsMeal = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];
  var selectedMeal = "Breakfast".obs;
  List<String> class_names = [
    "BG",
    "almond",
    "apple",
    "apricot",
    "asparagus",
    "avocado",
    "bamboo shoots",
    "banana",
    "bean sprouts",
    "biscuit",
    "blueberry",
    "bread",
    "broccoli",
    "cabbage",
    "cake",
    "candy",
    "carrot",
    "cashew",
    "cauliflower",
    "celery stick",
    "cheese butter",
    "cherry",
    "chicken duck",
    "chocolate",
    "cilantro mint",
    "coffee",
    "corn",
    "crab",
    "cucumber",
    "date",
    "dried cranberries",
    "egg",
    "eggplant",
    "egg tart",
    "enoki mushroom",
    "fig",
    "fish",
    "french beans",
    "french fries",
    "fried meat",
    "garlic",
    "ginger",
    "grape",
    "green beans",
    "hamburg",
    "hanamaki baozi",
    "ice cream",
    "juice",
    "kelp",
    "king oyster mushroom",
    "kiwi",
    "lamb",
    "lemon",
    "lettuce",
    "mango",
    "melon",
    "milk",
    "milkshake",
    "noodles",
    "okra",
    "olives",
    "onion",
    "orange",
    "other ingredients",
    "oyster mushroom",
    "pasta",
    "peach",
    "peanut",
    "pear",
    "pepper",
    "pie",
    "pineapple",
    "pizza",
    "popcorn",
    "pork",
    "potato",
    "pudding",
    "pumpkin",
    "rape",
    "raspberry",
    "red beans",
    "rice",
    "salad",
    "sauce",
    "sausage",
    "seaweed",
    "shellfish",
    "shiitake",
    "shrimp",
    "snow peas",
    "soup",
    "soy",
    "spring onion",
    "steak",
    "strawberry",
    "tea",
    "tofu",
    "tomato",
    "walnut",
    "watermelon",
    "white button mushroom",
    "white radish",
    "wine",
    "wonton dumplings"
  ];
  Map<String, TextEditingController> formController = {
    "description": TextEditingController(),
    "direction": TextEditingController(),
    "numberOfServing": TextEditingController(),
    "calories": TextEditingController(),
    "fat_total_g": TextEditingController(),
    "fat_saturated_g": TextEditingController(),
    "cholesterol_mg": TextEditingController(),
    "protein_g": TextEditingController(),
    "sodium_mg": TextEditingController(),
    "potassium_mg": TextEditingController(),
    "carbohydrates_total_g": TextEditingController(),
    "fiber_g": TextEditingController(),
    "sugar_g": TextEditingController(),
  };
  late PredictApiService predictApiService;
  RxList myFood = <FoodDTO>[].obs;
  RxList myPredictRecipes = <RecipeDTO>[].obs;
  RxList myPredictFoods = <FoodDTO>[].obs;
  RxList myRois = <Roi>[].obs;
  late DateTime sltDate = DateTime.now();

  var checked = false.obs;
  final picker = ImagePicker();
  var type = "".obs;
  late ui.Image loadedImage;
  var isShow = false.obs;
  var isSeftAdd = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await _loadImage([400, 300]);
    formController["numberOfServing"]!.text = "${1.0}";
    predictApiService = PredictApiService();

    sltDate = Get.find<DiaryController>().sltDate;

    updateData();
  }

  void pickThumbnail() async {
    loading.value = true;
    final _image = await picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      thumbnail.value = XFile(_image.path);
      thumbnaiSend.value = File(_image.path);
      _loadImage([400, 300]);
      sendRequestDetect(thumbnail.value.path);
    }

  }

  void pickFromCamera() async {
    loading.value = true;
    final _image = await picker.pickImage(source: ImageSource.camera);
    if (_image != null) {
      thumbnail.value = XFile(_image.path);
      thumbnaiSend.value = File(_image.path);
      _loadImage([400, 300]);
      sendRequestDetect(thumbnail.value.path);
    }

  }

  void updateData() {
    var item = {
      "calories": 0.0,
      "fat_total_g": 0.0,
      "fat_saturated_g": 0.0,
      "protein_g": 0.0,
      "sodium_mg": 0.0,
      "potassium_mg": 0.0,
      "cholesterol_mg": 0.0,
      "carbohydrates_total_g": 0.0,
      "fiber_g": 0.0,
      "sugar_g": 0.0
    };
    for (FoodDTO f in myFood) {
      double cv = (f.numberOfServing ?? 1) * (f.servingSize ?? 100) / 100;
      print(cv);
      item["calories"] = item["calories"]! + f.nutrition!.elementAt(0).amount * cv ?? 0.0;
      item["fat_total_g"] = item["fat_total_g"]! + f.nutrition!.elementAt(2).amount * cv ?? 0.0;
      item["fat_saturated_g"] = item["fat_saturated_g"]! + f.nutrition!.elementAt(3).amount * cv ?? 0.0;
      item["protein_g"] = item["protein_g"]! + f.nutrition!.elementAt(4).amount * cv ?? 0.0;
      item["sodium_mg"] = item["sodium_mg"]! + f.nutrition!.elementAt(5).amount * cv ?? 0.0;
      item["potassium_mg"] = item["potassium_mg"]! + f.nutrition!.elementAt(6).amount * cv ?? 0.0;
      item["cholesterol_mg"] = item["cholesterol_mg"]! + f.nutrition!.elementAt(7).amount * cv ?? 0.0;
      item["carbohydrates_total_g"] = item["carbohydrates_total_g"]! + f.nutrition!.elementAt(8).amount * cv ?? 0.0;
      item["fiber_g"] = item["fiber_g"]! + f.nutrition!.elementAt(9).amount * cv ?? 0.0;
      item["sugar_g"] = item["sugar_g"]! + f.nutrition!.elementAt(10).amount * cv ?? 0.0;
    }
    double i = double.parse(formController["numberOfServing"]?.text ?? "1.0");
    formController["calories"]!.text = (item["calories"]! * i).toStringAsFixed(2);
    formController["fat_total_g"]!.text = (item["fat_total_g"]! * i).toStringAsFixed(2);
    formController["fat_saturated_g"]!.text = (item["fat_saturated_g"]! * i).toStringAsFixed(2);
    formController["protein_g"]!.text = (item["protein_g"]! * i).toStringAsFixed(2);
    formController["sodium_mg"]!.text = (item["sodium_mg"]! * i).toStringAsFixed(2);
    formController["potassium_mg"]!.text = (item["potassium_mg"]! * i).toStringAsFixed(2);
    formController["cholesterol_mg"]!.text = (item["cholesterol_mg"]! * i).toStringAsFixed(2);
    formController["carbohydrates_total_g"]!.text = (item["carbohydrates_total_g"]! * i).toStringAsFixed(2);
    formController["fiber_g"]!.text = (item["fiber_g"]! * i).toStringAsFixed(2);
    formController["sugar_g"]!.text = (item["sugar_g"]! * i).toStringAsFixed(2);
  }

  void onChangeSize(String item) {
    updateData();
  }

  Future<void> _loadImage(List<int> size) async {
    final data = await thumbnail.value.readAsBytes();
    final codec = await ui.instantiateImageCodec(data);
    final frame = await codec.getNextFrame();

    loadedImage = frame.image;
  }

  Future<void> sendRequestDetect(String filename) async {
    // http.StreamedResponse StrRes = await predictApiService.postApi("predict/", filename);
    try {
      // var response = await http.Response.fromStream(StrRes);

      // Map<String, dynamic> i = json.decode(utf8.decode(response.bodyBytes));
      Map<String, dynamic> i = {
        "class_ids": [16, 81, 16, 37, 22],
        "image_size": [485, 512],
        "masks": [
          "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"
        ],
        "msg": "success",
        "rois": [
          [109, 49, 467, 510],
          [0, 35, 125, 352],
          [400, 120, 339, 503],
          [77, 270, 258, 511],
          [0, 352, 94, 504]
        ]
      };
      DetectResponseDTO detectResponseDTO = DetectResponseDTO.fromJson(i);
      String searchQuery = "";
      String searchQuery2 = "";
      _loadImage(detectResponseDTO.imageSize);
      myRois.value = detectResponseDTO.rois;
      for (var element in detectResponseDTO.classIds) {
        searchQuery += "${class_names.elementAt(element)} ";
        searchQuery2 += "${class_names.elementAt(element)}, ";
      }
      if (searchQuery.length <= 2) {
        Get.defaultDialog(
            radius: 8,
            title: "Cannot detect the food",
            middleText: "Please choose another images.",
            textConfirm: "Dismiss",
            onConfirm: () {
              Get.close(1);
            });
      } else {
        List<FoodDTO> foods = await RemoteService().getFoodsFromApi(searchQuery);
        List<RecipeDTO> recipes = await RemoteService().getRecipesPredictFromApiMyFitness(searchQuery2);
        final Set<String?> seenFoodNames = {};
        formController["description"]!.text = "Recipe with $searchQuery";
        List<FoodWithDetectImageDTO> f = [];
        final List<FoodDTO> uniquefoods = foods.where((item) {
          if (seenFoodNames.contains(item.foodName)) {
            return false;
          } else {
            // f.add(FoodWithDetectImageDTO(item.foodId, item.foodName, item.description, item.numberOfServing, item.servingSize, item.nutrition, Roi(x: x, y: y, height: height, width: width)))
            seenFoodNames.add(item.foodName);

            return true;
          }
        }).toList();

        myPredictFoods.value = uniquefoods;
        myPredictRecipes.value = recipes;
        loading.value = false;
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  void chooseType(BuildContext context) {
    BottomPicker(
      items: const [
        Center(
          child: Text('Pick an image'),
        ),
        Center(
          child: Text('Take a photo'),
        ),
      ],
      onSubmit: (value) {
        if (value == 0) {
          pickThumbnail();
        }
        if (value == 1) {
          pickFromCamera();
        }
        onClose();
      },
      pickerTitle: const Text('Choose an type'),
      titleAlignment: Alignment.center,
      pickerTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      height: 220,
      closeIconColor: Colors.red,
    ).show(context);
  }

  Future<void> logFood() async {
    String url = "";
    String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(sltDate);
    if (thumbnaiSend.value.path.isNotEmpty) {
      Map<String, dynamic> resImg =
          await CloudinaryNetWork().upload(Constant.CLOUDINARY_USER_MEAL_IMAGE, thumbnaiSend.value, Constant.FILE_TYPE_image);
      if (resImg["isSuccess"]) {
        url = resImg["imageUrl"];
      } else {
        print(resImg["message"]);
        Get.defaultDialog(radius: 8, title: "Have some error?", middleText: "Have some error when upload image.", textCancel: "Dismiss");
        return;
      }
    }
    var item;
    var itemMeal = {
      "mealId": "fromSeftAdd",
      "description": formController["description"]!.text.toString().trim(),
      "direction": formController["direction"]!.text.toString().trim(),
      "photo": url,
      "mealType": "PersonalAdd",
      "numberOfServing": 1.0,
      "foods": myFood.toJson(),
      "recipes": []
    };
    item = {
      "logDiaryId": "",
      "dateLog": formattedDateTime,
      "foodLogItem": {
        "meal": itemMeal,
        "numberOfServing": double.tryParse(formController["numberOfServing"]?.text.toString().trim() ?? "0.0"),
        "foodLogType": "meal"
      },
      "logDiaryType": selectedMeal.value
    };
    Object obj = jsonEncode(item);
    NetworkApiService networkApiService = NetworkApiService();
    DiaryController clr = Get.find<DiaryController>();

    http.Response res = await networkApiService.postApi("/log-diary/add-log/${clr.loginResponse.userId}", obj);

    if (res.statusCode == 200) {
      LogDiaryDTO logDiaryDTO = LogDiaryDTO.fromJson(json.decode(utf8.decode(res.bodyBytes)));
      DiaryController diaryController = Get.find<DiaryController>();
      if (selectedMeal.value == "Breakfast") {
        diaryController.breakfast.add(logDiaryDTO);
      } else if (selectedMeal.value == "Lunch") {
        diaryController.lunch.add(logDiaryDTO);
      } else if (selectedMeal.value == "Dinner") {
        diaryController.dinner.add(logDiaryDTO);
      } else if (selectedMeal.value == "Snack") {
        diaryController.snack.add(logDiaryDTO);
      }
    }

    Get.close(2);
  }
}
