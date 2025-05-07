import torch
import cv2
import os
import matplotlib.pyplot as plt
from ultralytics import YOLO

# Load the pre-trained YOLO model (replace with the path to your model, if custom)
model = YOLO("yolov8n.pt")  # Replace with your model name or path

# Check if CUDA (GPU) is available and if the model is using the GPU
device = 'cuda' if torch.cuda.is_available() else 'cpu'
model.to(device)  # Ensure the model is moved to the correct device

# Print out the device that the model is using
print(f"Model is running on: {device}")

# Path to the images folder
images_folder = "./images/"

# List all image files in the folder
image_files = [f for f in os.listdir(images_folder) if f.endswith(('.jpg', '.jpeg', '.png'))]

# Check how many images were found
print(f"Found {len(image_files)} image(s) in the folder.")

# Loop through each image file in the folder
for i, image_file in enumerate(image_files, 1):  # Adding index to the loop
    img_path = os.path.join(images_folder, image_file)

    # Run YOLO on the image
    results = model(img_path)

    # Plot the results (with detections visualized on the image)
    fig, ax = plt.subplots(figsize=(12, 8))
    ax.imshow(cv2.cvtColor(results[0].plot(), cv2.COLOR_BGR2RGB))
    ax.axis("off")
    plt.title(f"Detection results for image {i}/{len(image_files)}: {image_file}")
    
    # Show the plot for each image
    plt.show()
    
    # Close the plot after displaying it to avoid blocking the next one
    plt.close(fig)
