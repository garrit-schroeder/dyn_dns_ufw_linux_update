#!/bin/bash
DNS_NAME=your_dns.de
LOGFILE=/var/log/dyn_dns_log.log
PORT=xx

Current_IP=$(dig +short ${DNS_NAME} | sed -n '2p')
Old_IP=$(cat ${LOGFILE})

if [ "$Current_IP" = "$Old_IP" ] ; then
  echo IP address has not changed
else
  /usr/sbin/ufw allow from ${Current_IP} to any port ${PORT}
  echo ${Current_IP} > ${LOGFILE}
  echo iptables have been updated
  /usr/sbin/ufw delete allow from ${Old_IP} to any port ${PORT}
fi
