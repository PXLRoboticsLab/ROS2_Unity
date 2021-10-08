# ROS2 - Unity integration

This docker container allows you to control and monitor a simulation environment in Unity by using ROS2.

The Dockerfile is based on the ROS2 docker container from ```https://github.com/Unity-Technologies/Unity-Robotics-Hub/blob/main/tutorials/ros_unity_integration```
We added some extra stuff to make testing and prototyping faster. (bulding, sourcing, useful packages, ...)

## Installation

Make all the scripts executable:

```chmod +x 0*.sh```

Drop your custom ROS2 packages in the ```ros2_packages``` folder. They will be automatically included and built in the container.

Run ```./00_build.sh```

## Running the container

Run ```./01_launch.sh```

## Attaching a bash terminal to the container

* Run ```./02_attach.sh```
* Check the ```scripts``` folder for examples.
* When combined with the Unity container (*work in progress*), these scripts should work out of the box for the kart demo.
* When adding new ROS2 packages or making changes, don't forget to ```colcon build``` your workspace and ```source it up``` again. 

## Sourcing it up

```source /opt/ros/foxy/setup.bash && . /home/dev_ws/install/local_setup.sh```

## Contact

Contact [sam.vanderstraeten@pxl.be](sam.vanderstraeten@pxl.be) if you need something! Bring cookies to increase the probability of a helpful answer.
