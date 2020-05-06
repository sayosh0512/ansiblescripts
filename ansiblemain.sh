#!/bin/bash

decotext=`echo ${2} | base64 --decode`
  
echo "User ID is : ${1}" >> /home/"${1}"/log.txt
echo "encoded text : ${2}" >> /home/"${1}"/log.txt
echo "decoded text : ${decotext}" >> /home/"${1}"/log.txt

clonerepo(){
  cd /home/"${1}"/ 
  wget https://raw.githubusercontent.com/sayosh0512/ansibles-wordpress-script/master/ansibleserversetup.sh
  sudo chown -R "${1}":"${1}" /home/"${1}"/ansibleserversetup.sh
  bash /home/"${1}"/ansibleserversetup.sh 
}

moodle_install() {
cd /home/${1}
git clone https://github.com/sayosh0512/moodle_playbook.git
echo "username is : ${1}" >> /home/${1}/var.txt
echo "dbservername is : ${2}" >> /home/${1}/var.txt
echo "dbusername is : ${3}" >> /home/${1}/var.txt
echo "dbPassword is : ${4}" >> /home/${1}/var.txt
echo "domain_name is : ${5}" >> /home/${1}/var.txt

sudo sed -i "s~domain_name: domain~domain_name: ${5}~" /home/${1}/moodle_playbook/group_vars/all >> /home/${1}/var.txt
sudo sed -i "s~user_name: azusername~user_name: ${1}~" /home/${1}/moodle_playbook/group_vars/all  >> /home/${1}/var.txt 
ansible-playbook /home/${1}/moodle_playbook/playbook.yml -i /etc/ansible/hosts -u ${1}
}

clonerepo ${1} >> /home/"${1}"/log.txt
moodle_install ${3} ${4} ${5} ${6} ${7} >> /home/${3}/var.txt


  cat <<EOF > /home/"${1}"/run.sh
  #!/bin/bash
  bash /home/${1}/moodleinstall.sh ${decotext}
EOF
sudo chown -R "${1}":"${1}" /home/"${1}"/run.sh
