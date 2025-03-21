import 'package:get/get.dart';

import 'blog_management_controller.dart';

class BlogManagementBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BlogManagementController>(() => BlogManagementController());
  }

}
