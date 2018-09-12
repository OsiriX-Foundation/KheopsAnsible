echo 'Enter the hosts file'
read hosts

IPADDR="129.194.108.253"

hosts=hosts

ssh -q vandooni@$IPADDR exit
RESULT=$?

if [ $RESULT -ne 0 ]
then
  echo 'SSH connection impossible'
  ssh vandooni@$IPADDR
  echo 'Do you make a keygen ? (y/n)'
  read RESPONSE
  RESPONSE=${RESPONSE,,}
  if [[ $RESPONSE =~ ^(yes|y) ]]
  then
    ssh-keygen -f $HOME"/.ssh/known_hosts" -R $IPADDR
    ssh-keyscan -H $IPADDR >> ~/.ssh/known_hosts
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
