from mrcnn.config import Config 
NUM_CLASS = 103
IMAGE_SIZE = 512
class FoodsConfig(Config):
    NAME = "foods"
    NUM_CLASSES = NUM_CLASS + 1
    
    GPU_COUNT = 1
    IMAGES_PER_GPU = 4
    
    BACKBONE = 'resnet50'
    
    RPN_ANCHOR_SCALES = (16, 32, 64, 128, 256)
    
    STEPS_PER_EPOCH = 1000
    VALIDATION_STEPS = 200
    
    IMAGE_MIN_DIM = IMAGE_SIZE
    IMAGE_MAX_DIM = IMAGE_SIZE  