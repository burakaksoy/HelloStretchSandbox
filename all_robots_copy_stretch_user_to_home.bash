#!/bin/bash
HOSTS=("192.168.1.64" "192.168.1.28" )
USERNAMES=("hello-robot" "hello-robot")
PASSWORDS=("hello2020" "hello2020" )

# SCRIPTS=(
#     "cd; 
#     "
#     "cd; 
#     ")

echo ${SCRIPTS}
for i in ${!HOSTS[*]} ; do
    echo "------------"
    echo ${i}
    echo ${HOSTS[i]}
    echo ${USERNAMES[i]}
    # echo ${PASSWORDS[i]}
    # echo ${SCRIPTS[i]}

    cd ~
    mkdir 'stretch_user-'${HOSTS[i]}''
    cd 'stretch_user-'${HOSTS[i]}''

    ssh-keygen -f "$HOME/.ssh/known_hosts" -R ${HOSTS[i]}
    # sudo apt-get install sshpass
    # sshpass -p ${PASSWORDS[i]} ssh -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms='ssh-rsa' -o ConnectTimeout=2 -l ${USERNAMES[i]} ${HOSTS[i]} "${SCRIPTS[i]}"
    sshpass -p ${PASSWORDS[i]} rsync -avzhe "ssh -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms='ssh-rsa' -o ConnectTimeout=2" ${USERNAMES[i]}@${HOSTS[i]}:~/stretch_user ./
    
done
