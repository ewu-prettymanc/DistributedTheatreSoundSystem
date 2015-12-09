#!/bin/bash

ip_address="$1"

rsync -azhu --timeout=5 -e "ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o ConnectTimeout=3" root@$ip_address:/usr/local/lib/dtss/webapp/productions/ /usr/local/lib/dtss/webapp/productions/

exit $?
    