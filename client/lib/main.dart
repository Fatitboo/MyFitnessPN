import 'package:do_an_2/res/routes/routes.dart';
import 'package:do_an_2/res/store/storage.dart';
import 'package:do_an_2/res/store/user.dart';
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<UserStore>(UserStore());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: ((context, child)=> GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColor.primaryColor1,
          fontFamily: "PublicSans"
        ),
        title: 'MyFitnessPN',
        initialRoute: AppRoutes.PICK_IMAGE_FOOD,
        getPages: AppPages.routes,
      )),
    );
  }
}

