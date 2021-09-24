#!/bin/bash

ICINGA_HOSTNAME="YOUR_ICINGA_INSTALLATION"
TEAMS_WEBHOOK_URL="TEAMS_WEBHOOK"

## Main
while getopts 4:6:b:c:d:e:f:hi:l:n:o:r:s:t:u:v: opt
do
  case "$opt" in
    4) HOSTADDRESS=$OPTARG ;;
    6) HOSTADDRESS6=$OPTARG ;;
    b) NOTIFICATIONAUTHORNAME=$OPTARG ;;
    c) NOTIFICATIONCOMMENT=$OPTARG ;;
    d) LONGDATETIME=$OPTARG ;; # required
    e) SERVICENAME=$OPTARG ;; # required
    h) Usage ;;
    i) ICINGAWEB2URL=$OPTARG ;;
    l) HOSTNAME=$OPTARG ;; # required
    n) HOSTDISPLAYNAME=$OPTARG ;; # required
    o) SERVICEOUTPUT=$OPTARG ;; # required
    r) USEREMAIL=$OPTARG ;; # required
    s) SERVICESTATE=$OPTARG ;; # required
    t) NOTIFICATIONTYPE=$OPTARG ;; # required
    u) SERVICEDISPLAYNAME=$OPTARG ;; # required
    v) VERBOSE=$OPTARG ;;
  esac
done

#Set the message icon based on ICINGA Host state
if [ "$SERVICESTATE" = "CRITICAL" ]
then
    COLOR="DD6755"
elif [ "$SERVICESTATE" = "WARNING" ]
then
    COLOR="FFA500"
elif [ "$SERVICESTATE" = "OK" ]
then
    COLOR="008000"
elif [ "$SERVICESTATE" = "UNKNOWN" ]
then
    COLOR="808080"
else
    COLOR=""
fi

#Send message to Teams
read -d '' PAYLOAD << EOF
{
    "@type":"MessageCard",
    "themeColor":"${COLOR}",
    "summary":"${SERVICENAME}: ${HOSTDISPLAYNAME} - ${SERVICEDISPLAYNAME}",
    "sections": [
        {
            "activityTitle":"${SERVICENAME}: ${HOSTDISPLAYNAME} - ${SERVICEDISPLAYNAME}",
            "facts": [
                {
                    "name":"Host",
                    "value":"[${HOSTDISPLAYNAME}](${ICINGA_HOSTNAME}/monitoring/host/services?host=${HOSTNAME})"
                },
                {
                    "name":"State",
                    "value":"${SERVICESTATE}"
                },
                {
                    "name":"Plugin output",
                    "value":"\`\`\`${SERVICEOUTPUT}\`\`\`"
                }
            ],
            "markdown":true
        }
    ]
}
EOF

curl --connect-timeout 30 --max-time 60 -s -S -X POST -H 'Content-type: application/json' --data "${PAYLOAD}" "${TEAMS_WEBHOOK_URL}"