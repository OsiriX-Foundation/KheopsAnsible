echo 'Enter the hosts file'
read hosts

hosts=hosts

ssh -q vandooni@172.23.63.29 exit
RESULT=$?
if [ $RESULT -ne 0 ]
then
  echo 'SSH connection impossible'
  ssh vandooni@172.23.63.29
  echo 'Do you make a keygen ? (y/n)'
  read RESPONSE
  RESPONSE=${RESPONSE,,}
  if [[ $RESPONSE =~ ^(yes|y) ]]
  then
    ssh-keygen -f $HOME"/.ssh/known_hosts" -R 172.23.63.29
    ssh-keyscan -H 172.23.63.29 >> ~/.ssh/known_hosts
  fi
fi

echo 'Enter the playbook file'
read playbook

playbook=main.yml

echo 'Check the syntax of the playbook'
ansible-playbook $playbook --syntax-check

RESULT=$?

if [ $RESULT -eq 0 ];
then
  ansible-playbook --ask-pass --ask-become-pass -i $hosts $playbook
fi
