echo 'Enter the hosts file'
read hosts
echo 'Enter the playbook file'
read playbook

echo 'Check the syntax of the playbook'
ansible-playbook $playbook --syntax-check

ansible-playbook --ask-pass --ask-become-pass -i $hosts $playbook
