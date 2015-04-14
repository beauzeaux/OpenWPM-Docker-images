#!/bin/bash
# Shamelessly stolen from amplab's dockerscripts
# https://github.com/amplab/docker-scripts/blob/master/spark-1.0.0/spark-master/files/run_spark_master.sh

j2 /opt/setup/templates/core-sites.jinja.xml > /opt/spark/conf/core-sites.xml
export SPARK_MASTER_IP=$(hostname)
/opt/spark/sbin/start-master.sh

while [ 1 ];
do
	#should only be the one log file
	tail -f /opt/spark/logs/$(ls /opt/spark/logs) 
	sleep 1 
done
