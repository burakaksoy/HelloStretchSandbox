#!/bin/bash
HOSTS=("192.168.1.64" "192.168.1.28" )
USERNAMES=("hello-robot" "hello-robot")
PASSWORDS=("hello2020" "hello2020" )
# SCRIPTS=("cd; ls;"
#     "cd; ls;"
#     "cd; ls;"
#     "cd; ls;"
#     "cd; ls;")
COMMAND="gnome-terminal"

for i in ${!HOSTS[*]} ; do
    echo "------------"
    echo ${i}
    # echo ${HOSTS[i]}
    echo ${USERNAMES[i]}
    # echo ${PASSWORDS[i]}
    # echo ${SCRIPTS[i]}
    ssh-keygen -f "$HOME/.ssh/known_hosts" -R ${HOSTS[i]}
    COMMAND+=' --tab --title='${USERNAMES[i]}' -e "sshpass -p '${PASSWORDS[i]}' ssh -X -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms='"'ssh-rsa'"' -o ConnectTimeout=2 -l '${USERNAMES[i]}' '${HOSTS[i]}'"'
    # gnome-terminal --tab --title=${USERNAMES[i]} -e "sshpass -p ${PASSWORDS[i]} ssh -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms='ssh-rsa' -o ConnectTimeout=2 -l ${USERNAMES[i]} ${HOSTS[i]}"
done

eval $COMMAND