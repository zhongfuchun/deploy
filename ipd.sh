#!/bin/bash

MONGO_PORT=27017
MYSQL_PORT=3306
CONSULUI_PORT=8500
NETDATA_PORT=19999
NETWORK=172.0.0.0/8

IPT_MONGO=`iptables -t nat -S|grep $MONGO_PORT|grep DOCKER|awk '{for (i=3 ;i<=NF;i++) printf $i " "; printf "\n" }'`
IPT_MYSQL=`iptables -t nat -S|grep $MYSQL_PORT|grep DOCKER|awk '{for (i=3 ;i<=NF;i++) printf $i " "; printf "\n" }'`
IPT_CONSULUI=`iptables -t nat -S|grep $CONSULUI_PORT|grep DOCKER|awk '{for (i=3 ;i<=NF;i++) printf $i " "; printf "\n" }'`
IPT_NETDATA=`iptables -t nat -S|grep $NETDATA_PORT|grep DOCKER|awk '{for (i=3 ;i<=NF;i++) printf $i " "; printf "\n" }'`

NUM_MONGO=`iptables -t nat -nL --line-number|grep $MONGO_PORT|grep DNAT|awk '{print $1}'`
NUM_MYSQL=`iptables -t nat -nL --line-number|grep $MYSQL_PORT|grep DNAT|awk '{print $1}'`
NUM_CONSULUI=`iptables -t nat -nL --line-number|grep $CONSULUI_PORT|grep DNAT|awk '{print $1}'`
NUM_NETDATA=`iptables -t nat -nL --line-number|grep $NETDATA_PORT|grep DNAT|awk '{print $1}'`

#echo "$IPT_MONGO"
#echo "$IPT_MYSQL"
#echo "$IPT_CONSULUI"
#echo "$NUM_MONGO"
#echo "$NUM_MYSQL"
#echo "$NUM_CONSULUI"

if [ $? == 0 ];then
	iptables -t nat -R DOCKER $NUM_MONGO -s $NETWORK $IPT_MONGO
	iptables -t nat -R DOCKER $NUM_MYSQL -s $NETWORK $IPT_MYSQL
	iptables -t nat -R DOCKER $NUM_CONSULUI -s $NETWORK $IPT_CONSULUI
	iptables -t nat -R DOCKER $NUM_NETDATA -s $NETWORK $IPT_NETDATA
fi
