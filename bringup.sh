#!/bin/bash

# Network configuration
export ROBOT_HOSTNAME=192.168.0.200
export JETSON_HOSTNAME=192.168.0.50
export JETSON_WORKSPACE=~/catkin_ws

# Camera 1 configuration
export JETSON_CAMERA_1_MODEL=zed2
export JETSON_CAMERA_1_ID=front_rgbd_camera
export JETSON_CAMERA_1_DEVICE_ID=29258168

# Camera 2 configuration
export JETSON_CAMERA_2_MODEL=zed2
export JETSON_CAMERA_2_ID=rear_rgbd_camera
export JETSON_CAMERA_2_DEVICE_ID=29167454


while ! $HOME/ntp-seconds.sh; do
       sleep 1
done

export ROS_MASTER_URI=http://$ROBOT_HOSTNAME:11311
export ROS_IP=$JETSON_HOSTNAME
source /opt/ros/melodic/setup.bash
source $JETSON_WORKSPACE/devel/setup.bash

echo ""
echo -e "ROS_MASTER_URI\t= http://$ROBOT_HOSTNAME:11311"
echo -e "ROS_IP\t= $JETSON_HOSTNAME"
echo -e "WORKSPACE\t= $JETSON_WORKSPACE/devel/setup.bash"
echo ""

killall screen
sleep 2;
screen -S zed_1 -d -m roslaunch zed_bringup zed_complete_1.launch --wait;
sleep 2;
screen -S zed_2 -d -m roslaunch zed_bringup zed_complete_2.launch --wait;
