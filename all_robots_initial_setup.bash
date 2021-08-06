#!/bin/bash
HOSTS=("192.168.1.64" "192.168.1.28" )
USERNAMES=("hello-robot" "hello-robot")
PASSWORDS=("hello2020" "hello2020" )

SCRIPTS=(
    "cd; 
    mkdir catkin_ws_burak; 
    cd catkin_ws_burak; 
    rm -rf {*,.*};
    git clone https://github.com/burakaksoy/HelloStretchSandbox.git .;
    source /opt/ros/melodic/setup.bash;
    # catkin_make -DCATKIN_WHITELIST_PACKAGES='swarm_msgs;swarm_gui;swarm_launch;arduino_talker';
    # grep -qxF 'source ~/catkin_ws_burak/devel/setup.bash' ~/.bashrc || echo 'source ~/catkin_ws_burak/devel/setup.bash' >> ~/.bashrc;
    grep -qxF 'export ROS_IP=192.168.1.64' ~/.bashrc || echo 'export ROS_IP=192.168.1.64' >> ~/.bashrc;
    grep -qxF 'export ROS_MASTER_URI=http://192.168.1.201:11311' ~/.bashrc || echo 'export ROS_MASTER_URI=http://192.168.1.201:11311' >> ~/.bashrc;
    # source ~/.bashrc;
    # source ~/catkin_ws_burak/devel/setup.bash;
    # echo hello2020 | sudo -S apt install -y spacenavd;
    # echo hello2020 | sudo -S usermod -a -G dialout tablet
    "

    "cd; 
    ")

echo ${SCRIPTS}
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

# echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc; 
