#!/usr/bin/env bash
service cron restart
exec /usr/sbin/apachectl -DNO_DETACH -k start

