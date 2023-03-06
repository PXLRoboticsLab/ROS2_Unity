# ROS2 - Unity integration

This docker container allows you to control and monitor a simulation environment in Unity by using ROS2.

The Dockerfile is based on the ROS2 docker container from ```https://github.com/Unity-Technologies/Unity-Robotics-Hub/blob/main/tutorials/ros_unity_integration```
We added some extra stuff to make testing and prototyping faster. (building, sourcing, useful packages, ...)

## Installation

Make sure all scripts are executable:

```chmod +x 0*.sh```

Drop your custom ROS2 packages in the ```ros2_packages``` folder. They will be automatically included and built in the container.

Run ```./00_build.sh```

## The Unity part

Build a nice simulation scene in Unity and fire it up. It should work fine if you run Unity locally on your host machine.

If you're going to use a Unity simulation that is provided as an executable, you can skip this section. (Go to 'Running the container' below)


### Start from scratch
If you start a new Unity project from scratch, execute the following steps.
Basically, all steps are copied from [Unity Robotics Hub](https://github.com/Unity-Technologies/Unity-Robotics-Hub/blob/main/tutorials/ros_unity_integration/setup.md#-unity-setup)


1. Add the ROS TCP Connector package. Go to ```Window > Package Manager```, click on ```Add package from git URL``` and insert the git URL to install the plugin:    
```https://github.com/Unity-Technologies/ROS-TCP-Connector.git?path=/com.unity.robotics.ros-tcp-connector```
2. Go to ```Robotics > ROS Settings``` and switch the protocol to ```ROS2```.
3. More documentation can be found at [Unity Robotics Hub](https://github.com/Unity-Technologies/Unity-Robotics-Hub/blob/main/tutorials/ros_unity_integration/README.md) and [ROS TCP Connector](https://github.com/Unity-Technologies/ROS-TCP-Connector)

### Custom messages
Standard ROS messages are available in the ROS TCP Connector plugin. ([view here](https://github.com/Unity-Technologies/ROS-TCP-Connector/tree/main/com.unity.robotics.ros-tcp-connector/Runtime/Messages))

If you want to import custom ROS messages, you'll have to build them in Unity (once) so that your scripts recognize them as valid messages. View an example at [this URL](https://github.com/Unity-Technologies/Unity-Robotics-Hub/blob/main/tutorials/ros_unity_integration/README.md).

It could prove convenient to share a folder between this container and the ROS-Unity container, so that you can share the custom created ROS messages between them. If this is not the case, then you'll have to copy your custom ROS messages from your ROS2 workspace to this container, so that you can access them and build them from the Unity editor.

### Demo scenes
You can also check some demo scenes that we used for testing purposes:
* [ROSControl - Kart demo](https://hogeschoolpxl-my.sharepoint.com/:u:/g/personal/20004716_pxl_be/Ee_vpv0UOvJEgDKkral1awgBZERW1gyTLewqM60CmZitjw?e=3FbEz2)
   * Default Unity tutorial with the kart, modified to enable ROS control from outside Unity. Use the scripts in this container (02_launch_publisher) for quick try-out.
* [AI Hub](https://hogeschoolpxl-my.sharepoint.com/:u:/g/personal/20004716_pxl_be/EZmUfmWsjg5NpSgBnk3SbHMBtUvNyH67CW0jtnn7dbBmZA?e=mJ5tFr)
   * Unity scene that represents our AI Hub @ Corda. Big thanks to Steve Van Reeth for creating and sharing this!

## Running the container

Run ```./01_launch.sh```, execute ```./02_attach.sh``` to ... attach your terminal to the container. (duh)

## Working with the container

Check the ```/home/dev_ws/scripts``` folder for some examples.

```./01_start_tcp_endpoint.sh``` is needed to establish connection between this container and your Unity environment.

Other scripts are optional:
* ```02_launch_publisher``` - Demo scripts that starts a ROS2 publisher that sends a custom KartControl message. (simkart_interfaces/KartControl.msg) It tells the cart to accelerate and alter left & right steering every 2 seconds. Should work out of the box when combined with the customized [Unity kart tutorial scene](https://hogeschoolpxl-my.sharepoint.com/:u:/g/personal/20004716_pxl_be/Ee_vpv0UOvJEgDKkral1awgBZERW1gyTLewqM60CmZitjw?e=3FbEz2).
* ```03_launch_rqt_image_view``` - Script that fires up rqt_image_view. This allows you to view published images in the ROS network. Should work out of the box when combined with the Unity container and the ROSControl demo project.
* More can be added in the future

### Changing ROS2 packages
When adding new ROS2 packages or making changes, don't forget to ```colcon build``` your workspace and ```source it up``` again. 

### Sourcing it up

```source /opt/ros/foxy/setup.bash && . /home/dev_ws/install/local_setup.sh```

## Contact

Contact [sam.vanderstraeten@pxl.be](sam.vanderstraeten@pxl.be) if you need something! Bring cookies to increase the probability of a helpful answer.
