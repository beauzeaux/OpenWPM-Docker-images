#!/bin/bash
j2 /opt/setup/templates/core-sites.jinja.xml > /opt/spark/conf/core-sites.xml
bash /notebook.sh