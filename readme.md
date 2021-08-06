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

