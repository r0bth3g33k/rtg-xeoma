#!/bin/sh

if [ ! -f "/usr/local/Xeoma/.firstrun" ]
then
	ls -al /usr/local/Xeoma/.firstrun
	/root/xeoma.app -setpassword 'ChangeMe!'
	touch /usr/local/Xeoma/.firstrun
fi

/root/bin/Xeoma/xeoma -showpassword
/root/bin/Xeoma/xeoma -- -service -log -startdelay 5
