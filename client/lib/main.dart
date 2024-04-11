import 'package:do_an_2/res/routes/routes.dart';
import 'package:do_an_2/res/store/storage.dart';
import 'package:do_an_2/res/store/user.dart';
import 'package:do_an_2/res/values/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      )),
    );
  }
}

