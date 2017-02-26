#!/bin/bash
# This script will set up a new SSH key and OAUTH2 with your Github account.

read -p "GitHub Username: " uname
read -s -p "GitHub Password: " passwd
if [[ "$uname" == "" || "$passwd" == "" ]]; then
  echo -e "\n\nCan't set up your GitHub SSH keys without authorization. You're on your own now, champ."
  exit 1
fi

token=$(curl -u $uname:$passwd --silent -d '{"scopes":["user"]}' "https://api.github.com/authorizations" | grep -o '[0-9A-Fa-f]\{40\}')

echo -e "\n"
read -p "Generate new (and backup any current) SSH keys? (y):" createkey

if [[ "${createkey:=y}" == "y" ]]; then
  echo -e "Generating new SSH keys...\n"
  read -p "Enter your email address: " email
  mkdir -p ~/.ssh/key_backup && mv ~/.ssh/id_rsa* ~/.ssh/key_backup
  echo -e "\n\n\n" | ssh-keygen -t rsa -N "" -C ${email:=null@example.com}
fi

sshkey=`cat ~/.ssh/id_rsa.pub`
curl -X POST -H "Content-type: application/json" -d "{\"title\": \"$email\",\"key\": \"$sshkey\"}" "https://api.github.com/user/keys?access_token=$token"

echo -e "\nAll set, now get to work!"
exit 0
