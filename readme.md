# The Devices In The Lab:

| Description             | Username       | Hostname (Computer Name) | IP            | Password  | OS           | ROS     |
| ---                     | ---            | ---                      | ---           | ---       | ---          | ---     |
| Stretch Robot (Grey)    | hello-robot    | stretch-re1-1027         | 192.168.1.64  | hello2020 | Ubuntu 18.04 | Melodic |
| Stretch Robot (Yellow)  | hello-robot    | stretch-re1-1028         | 192.168.1.128 | hello2020 | Ubuntu 18.04 | Melodic |

# Commonly Used Stretch Robot Tools

The commonly used commands after sshing into the robots are given below.


| **Tool**                              | **Utility**                                                  |
| ------------------------------------- | ------------------------------------------------------------ |
| **stretch_robot_home.py**             | Commonly run after booting up the robot in-order to calibrate the joints |
| **stretch_robot_system_check.py**     | Scans for all hardware devices and ensure they are present on the bus and reporting valid values. Useful to verify that the robot is in good working order prior to commanding motion. It will report all success in green, failures in red. |
| **stretch_robot_stow.py**             | Useful to return the robot arm and tool to a safe position within the base footprint. It can also be useful if a program fails to exit cleanly and the robot joints are not backdriveable. It will restore them to their 'Safety' state. |
| **stretch_robot_battery_check.py**    | Quick way to check the battery voltage / current consumption |
| **stretch_xbox_controller_teleop.py** | Useful to quickly test if a robot can achieve a task by manually teleoperating the robot |
| **stretch_robot_dynamixel_reboot.py** | This will reset all Dynamixels in the robot, which may be needed if a servo overheats during high use and enters an error state. |

Note: The table above is copied from [here](https://github.com/hello-robot/stretch_body/blob/master/docs/stretch_body_guide.md#commonly-used-tools) 

# How to setup Stretch robot Gazebo simulation with a Lab world?

Gazebo Lab world is [here](https://github.com/burakaksoy/AssistiveRobot-SimulationFiles/tree/master/catkin_ws_gazebo/src/lab_gazebo). Download it to your computer and Add the following lines to `~/.bashrc` and then source.
```
export GAZEBO_MODEL_PATH=<your-download-path>/lab_gazebo/models
export GAZEBO_RESOURCE_PATH=<your-download-path>/lab_gazebo/worlds
```

Then, follow the instructions to setup the stretch gazebo as described [here](https://github.com/hello-robot/stretch_ros/blob/master/stretch_gazebo/README.md#setup).

To run the gazebo simulation, I slightly edited default `gazebo.launch` file to make the gazebo world as lab instead of empty world and also added position parameters to specify the initial position of the stretch robot in the lab. The new launch file is [here](). Copy it into `stretch_ros/stretch_gazebo/launch/` next to `gazebo.launch` file. After that, you can run

```
roslaunch stretch_gazebo gazebo_stretch_lab.launch rviz:=true
```
Now you should be able to see Gazebo and Rviz with a Stretch Robot in the lab world.


*Note: you can use `killall gzserver` and `killall gzclient` commands to shutdown Gazebo.*