# ROS2 - Unity integration

This docker container allows you to control and monitor a simulation environment in Unity by using ROS2.

The Dockerfile is based on the ROS2 docker container from ```https://github.com/Unity-Technologies/Unity-Robotics-Hub/blob/main/tutorials/ros_unity_integration```
We added some extra stuff to make testing and prototyping faster. (building, sourcing, useful packages, ...)

## Installation

Make all the scripts executable:

```chmod +x 0*.sh```

Drop your custom ROS2 packages in the ```ros2_packages``` folder. They will be automatically included and built in the container.

Run ```./00_build.sh```

## Running the container

Run ```./01_launch.sh```, execute ```./02_attach.sh``` to ... attach your terminal to the container. (duh)

## Working with the container

Check the ```/home/dev_ws/scripts``` folder for some examples.

```./01_start_tcp_endpoint.sh``` is needed to establish connection between this container and your Unity environment.

Other scripts are optional:
* ```02_launch_publisher``` - Demo scripts that starts a ROS2 publisher that sends a custom KartControl message. (simkart_interfaces/KartControl.msg) It tells the cart to accelerate and alter left & right steering every 2 seconds. Should work out of the box when combined with the [Unity container](https://github.com/PXLRoboticsLab/Unity_Hub) and the ROSControl demo project.
* ```03_launch_rqt_image_view``` - Script that fires up rqt_image_view. This allows you to view published images in the ROS network. Should work out of the box when combined with the Unity container and the ROSControl demo project.
* More can be added in the future

### Changing ROS2 packages
When adding new ROS2 packages or making changes, don't forget to ```colcon build``` your workspace and ```source it up``` again. 

### Sourcing it up

```source /opt/ros/foxy/setup.bash && . /home/dev_ws/install/local_setup.sh```


## Also check

Check out the accompanying [Unity Hub container](https://github.com/PXLRoboticsLab/Unity_Hub) to ensure a quick setup.

## Contact

Contact [sam.vanderstraeten@pxl.be](sam.vanderstraeten@pxl.be) if you need something! Bring cookies to increase the probability of a helpful answer.
