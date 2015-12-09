#!/bin/bash

ip_address="$1"

x=0

rsync -azhu --timeout=5 -e "ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o ConnectTimeout=3" root@$ip_address:/usr/local/lib/dtss/webapp/text/pw /usr/local/lib/dtss/webapp/text/pw
x+=$?
rsync -azhu --timeout=5 -e "ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o ConnectTimeout=3" /usr/local/lib/dtss/webapp/text/pw root@$ip_address:/usr/local/lib/dtss/webapp/text/pw
x+=$?
exit $x