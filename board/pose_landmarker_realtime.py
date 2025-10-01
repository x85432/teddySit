import cv2
import numpy as np
import tflite_runtime.interpreter as tflite
import time
import logging


LINE_COLOR = (255, 128, 0)
POINT_COLOR = (0, 0, 255)

keypoints_def = [
    {'label': 'nose',               'connections': [1, 2,]},
    {'label': 'left_eye',           'connections': [0, 3,]},
    {'label': 'right_eye',          'connections': [0, 4,]},
    {'label': 'left_ear',           'connections': [1,]},
    {'label': 'right_ear',          'connections': [2,]},
    {'label': 'left_shoulder',      'connections': [6, 7, 11,]},
    {'label': 'right_shoulder',     'connections': [5, 8, 12,]},
    {'label': 'left_elbow',         'connections': [5, 9,]},
    {'label': 'right_elbow',        'connections': [6, 10,]},
    {'label': 'left_wrist',         'connections': [7,]},
    {'label': 'right_wrist',        'connections': [8,]},
    {'label': 'left_hip',           'connections': [5, 12, 13,]},
    {'label': 'right_hip',          'connections': [6, 11, 14,]},
    {'label': 'left_knee',          'connections': [11, 15,]},
    {'label': 'right_knee',         'connections': [12, 16,]},
    {'label': 'left_ankle',         'connections': [13,]},
    {'label': 'right_ankle',        'connections': [14,]},
    ]

connections = [(i, j) for i in range(len(keypoints_def))
               for j in keypoints_def[i]["connections"]]

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s [%(levelname)s] %(message)s"
)


class poseLandmarker:
    def __init__(self, tflite_model_path):
        self.interpreter = tflite.Interpreter(
            model_path=tflite_model_path,
            # We run landmarker on CPU
            #experimental_delegates=[tflite.load_delegate('/usr/lib/libethosu_delegate.so')]
        )
        self.interpreter.allocate_tensors()
        self.input_details = self.interpreter.get_input_details()
        self.output_details = self.interpreter.get_output_details()

        self.input_shape =  self.input_details[0]["shape"]
        self.input_idx = self.input_details[0]["index"]
        self.output_idx = self.output_details[0]["index"]
        self.bbox = None

    def preprocess_image(self, image):
        """Preprocess image for pose estimation"""
        # Convert BGR to RGB
        image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        # Resize to model input size
        image = cv2.resize(image, (192, 192))
        # Reverse channel order back to BGR for model
        image = image[..., ::-1]
        # Add batch dimension
        image = np.expand_dims(image, axis=0)
        return image

    def load_image(self, filename):
        # Load image and preprocess it (kept for backward compatibility)
        orig_image = cv2.imread(filename, 1)
        image = self.preprocess_image(orig_image)
        return orig_image, image

    def run_inference(self, input_data):
        """Run inference on input data
        Args:
            input_data: Either a filename (string) or a cv2 image array
        """
        if isinstance(input_data, str):
            # If input is filename, load image
            orig_image, processed_image = self.load_image(input_data)
        else:
            # If input is image array, preprocess it
            orig_image = input_data.copy()
            processed_image = self.preprocess_image(input_data)
        
        # Run inference
        self.interpreter.set_tensor(self.input_idx, processed_image)
        self.interpreter.invoke()
        return self.interpreter.get_tensor(self.output_idx)
    
    def draw_landmarks(self, orig_image, out, save_result=False):
        """Draw landmarks on the image
        Args:
            orig_image: Original image to draw on
            out: Model output landmarks
            save_result: Whether to save result to file
        """
        # Create a copy to avoid modifying original image
        result_image = orig_image.copy()
        
        # Get image dimensions
        h, w = result_image.shape[:2]
        
        # Scale landmarks to image size
        scaled_landmarks = out.copy()
        scaled_landmarks[:, 0] *= h  # y coordinates
        scaled_landmarks[:, 1] *= w  # x coordinates
        
        # Draw connections (skeleton)
        for c in connections:
            i = c[0]
            j = c[1]
            # Check if both keypoints are visible (confidence > threshold)
            if len(scaled_landmarks[i]) > 2 and len(scaled_landmarks[j]) > 2:
                if scaled_landmarks[i][2] > 0.3 and scaled_landmarks[j][2] > 0.5:
                    cv2.line(result_image,
                            (int(scaled_landmarks[i, 1]), int(scaled_landmarks[i, 0])),
                            (int(scaled_landmarks[j, 1]), int(scaled_landmarks[j, 0])), 
                            LINE_COLOR, 3)
        
        # Draw keypoints
        for i in range(scaled_landmarks.shape[0]):
            # Check confidence if available
            if len(scaled_landmarks[i]) > 2:
                if scaled_landmarks[i][2] > 0.3:  # confidence threshold
                    cv2.circle(result_image,
                              (int(scaled_landmarks[i, 1]), int(scaled_landmarks[i, 0])), 
                              4, POINT_COLOR, -1)
            else:
                cv2.circle(result_image,
                          (int(scaled_landmarks[i, 1]), int(scaled_landmarks[i, 0])), 
                          4, POINT_COLOR, -1)
        
        if save_result:
            cv2.imwrite("pose_landmarks_result.jpg", result_image)
            print("Pose landmarks result saved to pose_landmarks_result.jpg")
        
        return result_image