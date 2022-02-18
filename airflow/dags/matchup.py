from datetime import datetime, timedelta
from textwrap import dedent

# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG

# Operators; we need this to operate!
from airflow.operators.bash import BashOperator
# These args will get passed on to each operator
# You can override them on a per-task basis during operator initialization
default_args = {
    'owner': 'Robin',
    'depends_on_past': False,
    'email': ['r.chesne@gmail.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=1),

}
with DAG(
    'matchup',
    default_args=default_args,
    description='A simple tutorial DAG',
    schedule_interval="0 */6 * * *", # Every 6 hours
    start_date=datetime(2021, 1, 1),
    catchup=False,
    tags=['6hrs'],
) as dag:


    t1 = BashOperator(
        task_id='enter_virtual_env',
        bash_command='. /app/env/bin/activate',
    )

    t2 = BashOperator(
        task_id='run_script',
        bash_command='python /app/scripts/main.py',
        retries=5,
    )



    t1 >> t2