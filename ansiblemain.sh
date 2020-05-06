#!/bin/bash

decotext=`echo ${2} | base64 --decode`
  
echo "User ID is : ${1}" >> /home/"${1}"/log.txt
echo "encoded text : ${2}" >> /home/"${1}"/log.txt
echo "decoded text : ${decotext}" >> /home/"${1}"/log.txt

clonerepo(){
  cd /home/"${1}"/ 
  wget https://raw.githubusercontent.com/sayosh0512/ansibles-wordpress-script/master/ansibleserversetup.sh
  sudo chown -R "${1}":"${1}" /home/"${1}"/moodleinstall.sh
}
clonerepo ${1} >> /home/"${1}"/log.txt

moodlesetup()
    git clone https://github.com/sayosh0512/moodle_playbook.git
    ansible-playbook /home/azureadmin/moodle_playbook/playbook.yml -i /etc/ansible/hosts -u azureadmin


  cat <<EOF > /home/"${1}"/run.sh
  #!/bin/bash
  bash /home/${1}/moodleinstall.sh ${decotext}
EOF
sudo chown -R "${1}":"${1}" /home/"${1}"/run.sh
