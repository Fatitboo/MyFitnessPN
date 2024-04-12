import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'blog_management_controller.dart';


class BlogManagementPage extends GetView<BlogManagementController> {
  const BlogManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('blog management'),
    );
  }
}
