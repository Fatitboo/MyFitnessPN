from flask import Flask, render_template, request, jsonify
from food_config import FoodsConfig 
import mrcnn.model as modellib
from mrcnn import visualize
import glob
import numpy as np
import cv2
from PIL import Image
import base64
from setting import Utilities

app = Flask(__name__)

class_names = [
    "BG", "almond", "apple", "apricot", "asparagus", "avocado", "bamboo shoots", "banana", "bean sprouts", "biscuit",
    "blueberry", "bread", "broccoli", "cabbage", "cake", "candy", "carrot", "cashew", "cauliflower", "celery stick",
    "cheese butter", "cherry", "chicken duck", "chocolate", "cilantro mint", "coffee", "corn", "crab", "cucumber",
    "date", "dried cranberries", "egg", "eggplant", "egg tart", "enoki mushroom", "fig", "fish", "french beans",
    "french fries", "fried meat", "garlic", "ginger", "grape", "green beans", "hamburg", "hanamaki baozi", "ice cream",
    "juice", "kelp", "king oyster mushroom", "kiwi", "lamb", "lemon", "lettuce", "mango", "melon", "milk", "milkshake",
    "noodles", "okra", "olives", "onion", "orange", "other ingredients", "oyster mushroom", "pasta", "peach", "peanut",
    "pear", "pepper", "pie", "pineapple", "pizza", "popcorn", "pork", "potato", "pudding", "pumpkin", "rape", "raspberry",
    "red beans", "rice", "salad", "sauce", "sausage", "seaweed", "shellfish", "shiitake", "shrimp", "snow peas", "soup",
    "soy", "spring onion", "steak", "strawberry", "tea", "tofu", "tomato", "walnut", "watermelon", "white button mushroom",
    "white radish", "wine", "wonton dumplings"
]

class InferenceConfig(FoodsConfig):
    GPU_COUNT = 1
    IMAGES_PER_GPU = 1
    DETECTION_MIN_CONFIDENCE = 0

IMAGE_SIZE=512

inference_config = InferenceConfig()

glob_list = glob.glob(f'mask_rcnn_foods_0025.h5')
model_path = glob_list[0] if glob_list else ''


model = modellib.MaskRCNN(mode='inference', 
                          config=inference_config,
                          model_dir="FoodSegmentation/Mask_RCNN")

assert model_path != '', "Provide path to trained weights"
print("Loading weights from ", model_path)
model.load_weights(model_path, by_name=True)

print("Load weight done!")

@app.route("/predict/", methods=['POST'])
def predict():
    try:
        file = request.files['image']
        # Read the image via file.stream
        print(file)
        original_image = Image.open(file.stream)
        original_image = np.array(original_image)
        
        img = cv2.resize(original_image, (IMAGE_SIZE, IMAGE_SIZE), interpolation=cv2.INTER_AREA)                         
        r = model.detect([img])
        r = r[0]
        
        if r['masks'].size > 0:
            masks = np.zeros((original_image.shape[0], original_image.shape[1], r['masks'].shape[-1]), dtype=np.uint8)
            for m in range(r['masks'].shape[-1]):
                masks[:, :, m] = cv2.resize(r['masks'][:, :, m].astype('uint8'), 
                                            (original_image.shape[1], original_image.shape[0]), interpolation=cv2.INTER_NEAREST)
            
            y_scale = original_image.shape[0]/IMAGE_SIZE
            x_scale = original_image.shape[1]/IMAGE_SIZE
            rois = (r['rois'] * [y_scale, x_scale, y_scale, x_scale]).astype(int)
            
            masks, rois = Utilities.refine_masks(masks, rois)
        else:
            masks, rois = r['masks'], r['rois']
            
        mask_list = []
        for m in range(masks.shape[-1]):
            mask_item = masks[:, :, m]
            
            encode_params = [int(cv2.IMWRITE_PNG_COMPRESSION), 9]
            _, buffer = cv2.imencode('.png', mask_item, encode_params)
            b64_bytearr = base64.b64encode(buffer).decode("utf-8")
            #b64 = str(b64_bytearr, 'utf-8')
            mask_list.append(b64_bytearr)
            print(r['scores'])

        
        return jsonify({'msg': 'success', 'masks': mask_list, 'rois': rois.tolist(), 'scores': r['scores'].tolist() ,'class_ids': r['class_ids'].tolist(), 'image_size': [original_image.shape[0], original_image.shape[1]]})
    except:
        return jsonify({"msg": "System Failed"})
        


if __name__ == '__main__':
    app.run(port=3000, debug=True)