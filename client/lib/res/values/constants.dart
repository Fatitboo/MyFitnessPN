import 'package:cloudinary_sdk/cloudinary_sdk.dart';

class Constant {
  static const GOAL_gainWeight = "bulking_slow";
  static const GOAL_loseWeight = "fatloss_moderate";
  static const GOAL_maintenance = "maintenance";

  static const male = "male";
  static const female = "female";

  static const EXC_ACTIVE_little = "little";
  static const EXC_ACTIVE_light = "light";
  static const EXC_ACTIVE_moderate = "moderate";
  static const EXC_ACTIVE_heavy = "heavy";


  static const SUBTASK_normal = "normal";
  static const SUBTASK_workout = "workout";
  static const SUBTASK_link = "link";

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
  static const CLOUDINARY_ADMIN_RECIPE_IMAGE = "admin/recipe/images";
  static const CLOUDINARY_ADMIN_PLAN_IMAGE = "admin/plan/images";
  static const CLOUDINARY_USER_MEAL_IMAGE = "user/meal/images";

}