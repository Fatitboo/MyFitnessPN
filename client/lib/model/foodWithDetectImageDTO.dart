import 'package:do_an_2/model/foodDTO.dart';

import 'detectResponseDTO.dart';

class FoodWithDetectImageDTO extends FoodDTO{
  FoodWithDetectImageDTO(super.foodId, super.foodName, super.description, super.numberOfServing, super.servingSize, super.nutrition, this.roi);
  Roi roi;

}