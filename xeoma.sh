#!/bin/sh

if [ ! -f "/usr/local/Xeoma/.firstrun" ]
then
	ls -al /usr/local/Xeoma/.firstrun
	/root/xeoma.app -setpassword `tr -dc 'ChangeMe!' | xargs`
	touch /usr/local/Xeoma/.firstrun
fi

/root/bin/Xeoma/xeoma -showpassword
/root/bin/Xeoma/xeoma -- -service -log -startdelay 5
