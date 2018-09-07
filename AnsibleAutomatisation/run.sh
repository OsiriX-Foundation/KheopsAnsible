echo 'Enter the hosts file'
read hosts
echo 'Enter the playbook file'
#read playbook

playbook=mainInstall.yml

echo 'Check the syntax of the playbook'
ansible-playbook $playbook --syntax-check

RESULT=$?

if [ $RESULT -eq 0 ];
then
  ansible-playbook --ask-pass --ask-become-pass -i $hosts $playbook
fi
