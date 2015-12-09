#!/bin/bash

ip_address="$1"

#sudo rsync -azhu --delete --timeout=5 -e "ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o ConnectTimeout=3" /usr/local/lib/dtss/webapp/productions/ root@$ip_address:/usr/local/lib/dtss/webapp/productions/

sudo rsync -azhu --timeout=5 -e "ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o ConnectTimeout=3" /usr/local/lib/dtss/webapp/productions/ root@$ip_address:/usr/local/lib/dtss/webapp/productions/

exit $?
