#!/bin/sh

	/root/xeoma.app -setpassword ChangeMe
	touch /usr/local/Xeoma/.firstrun

/root/bin/Xeoma/xeoma -showpassword
/root/bin/Xeoma/xeoma -- -service -log -startdelay 5
