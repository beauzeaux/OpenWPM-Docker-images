#!/bin/bash
# Shamelessly stolen from amplab's dockerscripts
# https://github.com/amplab/docker-scripts/blob/master/spark-1.0.0/spark-master/files/run_spark_master.sh

# TODO: add defaults for the environment variables
/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://$SPARK_MASTER_IP:$SPARK_MASTER_PORT

while [ 1 ];
do
	#should only be the one log file
	tail -f /opt/spark/logs/$(ls /opt/spark/logs) 
	sleep 1 
done
