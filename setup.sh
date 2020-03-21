GROUP=family
DATA_DIRECTORY=/data/users
# declare -a USERS=("user1" "user2")

groupadd ${GROUP}

for user in "${USERS[@]}"; do
    echo "Creating user ${user} in group ${GROUP}"
    useradd \
        -g ${GROUP} \
        -d "${DATA_DIRECTORY}/${user}" \
        -s /sbin/nologin \
        ${user}
    while true; do
        read -s -p "Password: " password
        echo
        read -s -p "Password (again): " password2
        echo
        [ "$password" = "$password2" ] && break
        echo "Please try again"
    done
    usermod --password ${user} ${password}
    smbpasswd -a ${user}
    (
        echo ${password}
        echo ${password}
    ) | smbpasswd -a -s ${user}
    echo "Setting ownership and Permission to user ${user} on directory ${DATA_DIRECTORY}/${user}"
    chown -R ${user}:${GROUP} "${DATA_DIRECTORY}/${user}"
    chmod -R 600 "${DATA_DIRECTORY}/${user}"
done
