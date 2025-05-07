# YOLO Container for Object Detection

You Only Look Once (YOLO) is a state-of-the-art, real-time object detection system. Detailed documentation for YOLOv5 can be found at: <https://docs.ultralytics.com/models/yolov5/> . The official YOLOv5 code is available on GitHub at: <https://github.com/ultralytics/yolov5> .


1. Open terminal in from your Tempest account, and download the container of Yolo, using the following command.

```bash
apptainer pull 01.14-yolo5.sif docker://ultralytics/yolov5
```

This will create a .sif file in your directory.

Since we want to test it with GPUs, I will open a remote desktop with GPU. YOLO is a library for real-time object detection, so first, let's download some high-quality images to your directory. We will need to specify the path of the image/ images in the test code.

2. Go to Interactive Apps on Tempest and open remote desktop machine using GPUs.
3. Now, run the Yolo container by using the following command in the terminal on the remote desktop machine.

```bash
apptainer exec --nv -B $PWD:/code 01.14-yolo5.sif python test-yolo-container-with-gpu.py
```

The images will display with objects marked by boxes and labeled accordingly.

> [!IMPORTANT]
> Note: You will need to manually close each image before the next one is displayed.

4. Sample output of the results is shown below:

```bash
[d81v711@tempest-gpu009 ~]$ apptainer exec --nv -B $PWD:/code 01.14-yolo5.sif python test-yolo-container-with-gpu.py
Model is running on: cuda
Found 6 image(s) in the folder.

image 1/1 /home/d81v711/images/2012_001154.jpg: 448x640 4 persons, 5 chairs, 2 tvs, 1 laptop, 1 keyboard, 1 clock, 72.1ms
Speed: 18.4ms preprocess, 72.1ms inference, 28.9ms postprocess per image at shape (1, 3, 448, 640)

image 1/1 /home/d81v711/images/2012_003896.jpg: 480x640 3 persons, 69.1ms
Speed: 1.5ms preprocess, 69.1ms inference, 1.0ms postprocess per image at shape (1, 3, 480, 640)

image 1/1 /home/d81v711/images/2012_001297.jpg: 480x640 15 persons, 1 skateboard, 6.3ms
Speed: 1.8ms preprocess, 6.3ms inference, 1.3ms postprocess per image at shape (1, 3, 480, 640)

image 1/1 /home/d81v711/images/2012_001132.jpg: 480x640 8 persons, 2 bottles, 1 cup, 4 chairs, 2 tvs, 2 laptops, 1 microwave, 5.5ms
Speed: 1.7ms preprocess, 5.5ms inference, 1.0ms postprocess per image at shape (1, 3, 480, 640)

image 1/1 /home/d81v711/images/2012_000918.jpg: 480x640 5 persons, 3 horses, 5.6ms
Speed: 1.5ms preprocess, 5.6ms inference, 1.0ms postprocess per image at shape (1, 3, 480, 640)

image 1/1 /home/d81v711/images/2012_000168.jpg: 448x640 22 persons, 8 bicycles, 6.0ms
Speed: 1.5ms preprocess, 6.0ms inference, 1.1ms postprocess per image at shape (1, 3, 448, 640)
```
