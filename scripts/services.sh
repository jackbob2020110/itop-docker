#!/usr/bin/env bash
service cron start
exec /usr/sbin/apachectl -DNO_DETACH -k start

