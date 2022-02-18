#!/bin/bash

# install the packages to run the python scripts

cd app
. env/bin/activate
airflow db init
airflow users create -u admin -p admin -r Admin -e email@email.com -f Robin -l CHESNE
airflow webserver & airflow scheduler
tail -f /dev/null