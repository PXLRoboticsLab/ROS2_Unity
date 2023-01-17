FROM ros:foxy-ros-base

# Based on ROS2 docker container from https://github.com/Unity-Technologies/Unity-Robotics-Hub/blob/main/tutorials/ros_unity_integration
# Added some stuff to make prototyping easier

# Make ROS2 Workspace Dirs
RUN mkdir -p /home/dev_ws/src

# Copy ROS2 packages into workspace
COPY ./ros2_packages/ /home/dev_ws/src

# Copy example scripts
RUN mkdir /home/dev_ws/scripts
COPY ./scripts/ /home/dev_ws/scripts/
RUN chmod +x /home/dev_ws/scripts/*

#Check out ROS-TCP-Endpoint, ROS2 version
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
RUN git clone https://github.com/Unity-Technologies/ROS-TCP-Endpoint /home/dev_ws/src/ros_tcp_endpoint -b ROS2v0.7.0

RUN apt-get update && apt-get upgrade -y \
        && apt-get install -y nano \
        && apt-get install -y ros-foxy-rqt-image-view \
        && apt-get install -y ros-foxy-compressed-image-transport \
        && apt-get install -y python3-opencv \
        && apt-get install -y qt5-default

# Reference script with commands to source workspace
COPY ./source_ros.sh /home/dev_ws/source_ros.sh

# Change to workspace on sign in
RUN echo "cd /home/dev_ws" >> ~/.bashrc

# Build the workspace
RUN cd /home/dev_ws && . /opt/ros/foxy/setup.sh && colcon build

# Source the workspace on sign in
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
RUN echo ". install/local_setup.bash" >> ~/.bashrc
