cp teams-service-notification.sh /etc/icinga2/scripts/
# cp teams-host-notification.sh /etc/icinga2/scripts/
chmod +x /etc/icinga2/scripts/teams-service-notification.sh
getenforce
if [ $? -eq 0 ]
    echo "SELinux seems to be installed. You may need to adapt the SEContext to allow script execution."
fi