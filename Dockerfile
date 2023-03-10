FROM ros:foxy-ros-base

# Based on ROS2 docker container from https://github.com/Unity-Technologies/Unity-Robotics-Hub/blob/main/tutorials/ros_unity_integration
# Added some stuff to make prototyping easier

RUN apt-get update && apt-get upgrade -y \
        && apt-get install -y nano \
        && apt-get install -y ros-foxy-rqt-image-view \
        && apt-get install -y ros-foxy-compressed-image-transport \
        && apt-get install -y python3-opencv \
        && apt-get install -y qt5-default \
	&& useradd -ms /bin/bash user \
	&& echo "user:user" | chpasswd && adduser user sudo \
	&& echo "user ALL=(ALL) NOPASSWD: ALL " >> /etc/sudoers

# RUN apt-get update && apt-get install tmux

USER user
WORKDIR /home/user
RUN sudo usermod -a -G video user

# RUN git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack  \
#         && git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux-resurrect
# COPY --chown=user:user ./.tmux.conf /home/user/.tmux.conf
# COPY --chown=user:user ./.powerline.sh /home/user/.powerline.sh

# # Set some decent colors if the container needs to be accessed via /bin/bash.
# RUN echo LS_COLORS=$LS_COLORS:\'di=1\;33:ln=36\' >> ~/.bashrc \
#         && echo export LS_COLORS >> ~/.bashrc \
#         && echo 'source ~/.powerline.sh' >> ~/.bashrc \
#         && echo 'alias tmux="tmux -2"' >> ~/.bashrc \
#         && echo 'PATH=~/bin:$PATH' >> ~/.bashrc \
#         && touch ~/.sudo_as_admin_successful # To surpress the sudo message at run.

# Make ROS2 Workspace Dirs
RUN mkdir -p /home/user/dev_ws/src

#Check out ROS-TCP-Endpoint, ROS2 version
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
RUN git clone https://github.com/Unity-Technologies/ROS-TCP-Endpoint /home/user/dev_ws/src/ros_tcp_endpoint -b ROS2v0.7.0

# Copy example scripts
RUN mkdir /home/user/dev_ws/scripts
COPY ./Scripts/ /home/user/dev_ws/scripts/
RUN sudo chmod +x /home/user/dev_ws/scripts/*

# Reference script with commands to source workspace
COPY ./source_ros.sh /home/user/dev_ws/source_ros.sh

# Change to workspace on sign in
RUN echo "cd /home/user/dev_ws" >> ~/.bashrc

# Build the workspace
RUN cd /home/user/dev_ws && . /opt/ros/foxy/setup.sh && colcon build

RUN sudo chown -R user /home/user/dev_ws

# Source the workspace on sign in
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
RUN echo ". install/local_setup.bash" >> ~/.bashrc
