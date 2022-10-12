MY_INPUT='/home/clem/Documents/Projet/Shell.exe/Job_09/Shell_Userlist.csv'
declare -a A_FIRSTNAME
declare -a A_LASTNAME
declare -a A_ID
declare -a A_ROLE
declare -a A_PASSWORD
while IFS=, read -r COL1 COL2 COL3 COL4 COL5; do
    A_FIRSTNAME+=("$COL2")
    A_LASTNAME+=("$COL3")
    A_ID+=("$COL1")
    A_ROLE+=("$COL5")
    A_PASSWORD+=("$COL4")
done <"$MY_INPUT"

for index in "${!A_FIRSTNAME[@]}"; do
   sudo  useradd -d "/home/${A_FIRSTNAME[$index]}" -s /bin/bash -u "${A_ID[$index]}" -p "$(echo "${A_PASSWORD[$index]}" | openssl passwd -1 -stdin)" --badname "${A_FIRSTNAME[$index]}""${A_LASTNAME[$index]}"

if [ "${A_ROLE[$index]}" == Admin ]
then

 sudo usermod -aG sudo "${A_FIRSTNAME[$index]}""${A_LASTNAME[$index]}"

fi

done
