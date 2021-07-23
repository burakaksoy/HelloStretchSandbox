#!/bin/bash
HOSTS=("192.168.1.64" "192.168.1.128" )
USERNAMES=("hello-robot" "hello-robot")
PASSWORDS=("hello2020" "hello2020" )

SCRIPTS=(
    "source /opt/ros/melodic/setup.bash; cd; cd catkin_ws_burak;  # catkin_make -DCATKIN_WHITELIST_PACKAGES='swarm_msgs;swarm_gui;swarm_launch;arduino_talker'"
    "source /opt/ros/melodic/setup.bash; cd; cd catkin_ws_burak;  # catkin_make -DCATKIN_WHITELIST_PACKAGES='swarm_msgs;swarm_gui;swarm_control;swarm_launch'")
for i in ${!HOSTS[*]} ; do
    echo "------------"
    # echo ${HOSTS[i]}
    echo ${USERNAMES[i]}
    # echo ${PASSWORDS[i]}
    echo ${SCRIPTS[i]}
    ssh-keygen -f "$HOME/.ssh/known_hosts" -R ${HOSTS[i]}
    # sudo apt-get install sshpass
    sshpass -p ${PASSWORDS[i]} ssh -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms='ssh-rsa' -o ConnectTimeout=2 -l ${USERNAMES[i]} ${HOSTS[i]} "${SCRIPTS[i]}"
    # ssh -o StrictHostKeyChecking=no -l ${USERNAMES[i]} ${HOSTS[i]} "${SCRIPTS[i]}"
done
