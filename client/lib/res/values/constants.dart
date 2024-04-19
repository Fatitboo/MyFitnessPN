import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class Constant {
  static const GOAL_gainWeight = "gainweight";
  static const GOAL_loseWeight = "loseweight";
  static const GOAL_maintenance = "maintenance";

  // exercise type
  static const EXERCISE_strength = "Strength";
  static const EXERCISE_cardio = "Cardio";

  // File type
  static const FILE_TYPE_video = CloudinaryResourceType.video;
  static const FILE_TYPE_image = CloudinaryResourceType.image;

  // Folder cloudinary type  root = Home
  static const CLOUDINARY_ADMIN_EXERICSE_VIDEO = "admin/exercise/videos";
  static const CLOUDINARY_ADMIN_ROUTINE_VIDEO = "admin/routine/videos";
  static const CLOUDINARY_ADMIN_ROUTINE_IMAGE = "admin/routine/images";
}