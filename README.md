# icinga2-rocketchat-notification

![alt text]( "Rocket.chat screenshot")

## Common

1. Clone the repo into `/etc/icinga2/scripts/` or only put the script `teams-service-notification.sh` in this folder
2. Set up a new incoming webhook from the admin page on your rocket.chat instance

### Director

1. Create a new command :
  1. Command type : `Notification Plugin Command`
  2. Command : `/etc/icinga2/scripts/teams-service-notification.sh`
  3. Arguments : you need to make the correspondence between icinga2 and the arguments used in the script
2. Create a Notification template with the previous created command
3. Create a rule to apply this template  on the type you want (`Services` or `Host`)
  1. You can create specific rules to assign this notification
4. Deploy and enjoy :heart: 

|Argument|Value|
|---|---|
|-d|$icinga.long_date_time$|
|-e|$service.name$|
|-l|$host.name$|
|-n|$host.display_name$|
|-o|$service.output$|
|-r|$user.email$|
|-s|$service.state$|
|-t|$notification.type$|
|-u|$service.display_name$|

### CLI

TODO

*Based on the Slack script from : [jjethwa/icinga2-slack-notification](https://github.com/jjethwa/icinga2-slack-notification)*