#!/bin/bash

stopServices() {
        service apache2 stop
}
trap stopServices TERM

service apache2 start

# fork a process and wait for it
tail -f /var/log/postgresql/postgresql-11-main.log &
wait
