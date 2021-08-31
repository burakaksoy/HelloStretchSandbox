# The Devices In The Lab:

| Description             | Username       | Hostname (Computer Name) | IP            | Password  | OS           | ROS     |
| ---                     | ---            | ---                      | ---           | ---       | ---          | ---     |
| Stretch Robot (Yellow)    | hello-robot    | stretch-re1-1027         | 192.168.1.64  | hello2020 | Ubuntu 18.04 | Melodic |
| Stretch Robot (Grey)  | hello-robot    | stretch-re1-1028         | 192.168.1.28 | hello2020 | Ubuntu 18.04 | Melodic |

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

Gazebo Lab world is [here](https://github.com/burakaksoy/AssistiveRobot-SimulationFiles). Clone it to your `catkin_ws/src` computer, execute `catkin_make` from your `catkin_ws` and add the following lines to `~/.bashrc` and then source.
```
export GAZEBO_MODEL_PATH=~/catkin_ws/src/AssistiveRobot-SimulationFiles/lab_gazebo/models
export GAZEBO_RESOURCE_PATH=~/catkin_ws/src/AssistiveRobot-SimulationFiles/lab_gazebo/worlds
```

Then, follow the instructions to setup the stretch gazebo as described [here](https://github.com/hello-robot/stretch_ros/blob/master/stretch_gazebo/README.md#setup). (You may also want to [see](https://docs.hello-robot.com/untethered_operation/#visualizing-remotely-with-rviz))

To run the gazebo simulation, I slightly edited default `gazebo.launch` file to make the gazebo world as lab instead of empty world and also added position parameters to specify the initial position of the stretch robot in the lab. The new launch file is [here](https://github.com/burakaksoy/HelloStretchSandbox/blob/main/gazebo_stretch_lab.launch). Copy it into `stretch_ros/stretch_gazebo/launch/` next to `gazebo.launch` file. After that, you can run

```
roslaunch stretch_gazebo gazebo_stretch_lab.launch rviz:=true
```
Now you should be able to see Gazebo and Rviz with a Stretch Robot in the lab world.
![stretch_gazebo_in_lab](https://github.com/burakaksoy/HelloStretchSandbox/blob/main/.images/stretch_gazebo_in_lab.png?raw=true)

If you will open Rviz with another launch use:
```
roslaunch stretch_gazebo gazebo_stretch_lab.launch rviz:=false
```

*Note: you can use `killall gzserver` and `killall gzclient` commands to shutdown Gazebo.*

# How to run 2D Mapping on Gazebo simulation?

With the real stretch helloe robots one would run `roslaunch stretch_navigation mapping.launch` as described in [here](https://github.com/hello-robot/stretch_ros/tree/master/stretch_navigation#readme) to start 2D mapping. This launch file launches stretch_driver and lidar sensors from `stretch_core` package. It also launches keyboard teleoperation with topic name `/stretch/cmd_vel`, a configured rviz to visualize the map, and finally launches `gmapping` package for the mapping. 

For the Gazebo simulation, however, we don't need to launch stretch_driver and lidar sensors from `stretch_core` package because,although differently, they are already provided with previously mentioned Gazebo package launching command `roslaunch stretch_gazebo gazebo_stretch_lab.launch rviz:=false` (ie. `/scan` topic by lidar sensor is already published by gazebo and `/stretch_diff_drive_controller/cmd_vel` topic is listened to move the base, instead of `/stretch/cmd_vel`, also `/tf` is also provided by gazebo which means there is no need for stretch_core package). 

Based on explanation above, I edited the `mapping.launch` file as `mapping_gazebo_2D.launch` that can be found in [here](https://github.com/burakaksoy/HelloStretchSandbox/blob/main/mapping_gazebo_2D.launch). Copy it into `stretch_ros/stretch_navigation/launch/` next to `mapping.launch` file. After that, you can run:
```
roslaunch stretch_navigation mapping_gazebo_2D.launch
```
Now you can start 2D mapping in simulation with your keyboard input. (You may need to install [ROS teleop_twist_keyboard package](http://wiki.ros.org/teleop_twist_keyboard) with command `sudo apt-get install ros-melodic-teleop-twist-keyboard`)
![stretch_gazebo_in_lab](https://github.com/burakaksoy/HelloStretchSandbox/blob/main/.images/stretch_gazebo_in_lab_2D_mapping.png?raw=true)

*Note: How to save the constructed map is described in [here](https://github.com/hello-robot/stretch_ros/tree/master/stretch_navigation#readme). For example: I created an example 2D map of the simulated lab in gazebo with command `rosrun map_server map_saver -f ./maps/lab2d` in maps directory of this repo. Then I also had to edit the generetad `lab2d.yaml` file with replacing the line `image: ./maps/lab2d.pgm` to `image: ./lab2d.pgm`*

# How to navigate on a known (saved) 2D map using Gazebo Simulation?
(You may need to install [ROS AMCL localization package](http://wiki.ros.org/teleop_twist_keyboard) with command `sudo apt-get install ros-melodic-amcl`)

Similar to the previous section, with the real stretch hello robots one would run `roslaunch stretch_navigation navigation.launch map_yaml:=<path-to-maps>/maps/<map_name>.yaml` as described in [here](https://github.com/hello-robot/stretch_ros/tree/master/stretch_navigation#readme) to start 2D navigation. However, we will run:
```
roslaunch stretch_navigation navigation_gazebo_2D.launch map_yaml:=<path-to-maps>/maps/<map_name>.yaml
```
after copying [`navigation_gazebo_2D.launch`](https://github.com/burakaksoy/HelloStretchSandbox/blob/main/navigation_gazebo_2D.launch) into `stretch_ros/stretch_navigation/launch/` next to `navigation.launch` file.

(For example, I run `roslaunch stretch_navigation navigation_gazebo_2D.launch map_yaml:=/home/burak/common/RESEARCH/HelloStretchRobotFiles/HelloStretchSandbox/maps/lab2d.yaml`)

Then, as explained in [here](https://github.com/hello-robot/stretch_ros/tree/master/stretch_navigation#readme),
* In the top bar of the opened Rviz window, use 2D Pose Estimate to lay an arrow down roughly where the robot is located in the real space. AMCL, the localization package, will better localize our pose once we give the robot a 2D Nav Goal. In the top bar of Rviz, use 2D Nav Goal to lay down an arrow where you'd like the robot to go. In the terminal, you'll see move_base go through the planning phases and then navigate the robot to the goal. If planning fails, the robot will begin a recovery behavior: spinning around 360 degrees in place.

* It is also possible to send 2D Pose Estimates and Nav Goals programatically. In your own launch file, you may include navigation.launch to bring up the navigation stack. Then, you can send move_base_msgs::MoveBaseGoal messages in order to navigate the robot programatically. 

