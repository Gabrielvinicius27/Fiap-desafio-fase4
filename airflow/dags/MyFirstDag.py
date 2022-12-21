from airflow.decorators import task, dag
from datetime import datetime, timedelta
from airflow.utils.task_group import TaskGroup

# catchup False: não permite rodar Dags que não foram triggadas 
# automaticamente

# start date, data em que a DAG começa a ser schedulada
# schedule_interval, intervalo de tempo a partir da 
# start_date em que a DAG vai ser triggada

# CRON is stateless, Timedelta is stateful or relative


@task.python(do_xcom_push=False)
def hello_world(name):
    print(f'hello world! {name}')
    return name

@task.python(do_xcom_push=False, multiple_outputs=True)
def hello_world_part2(name):
    print(f"{name}, meu bom!")
    x1 = "x1"
    x2 = "x2"
    x3 = "x3"
    return {"var":x1, "var2":x2, "var3":x3}

@task.python
def print_task1(x):
    print(x)

@task.python
def print_task2(x):
    print(x)

@task.python
def print_task3(x):
    print(x)

@dag(dag_id="my_dag", 
    description="My First Dag",
    start_date=datetime(2021,1,1,18), 
    schedule_interval="*/10 * * * *",
    dagrun_timeout=timedelta(minutes=10),
    tags=["data_engineering_team"],
    catchup=False)
def my_dag():
    name = hello_world("Gabriel") 
    prints = hello_world_part2(name)
    print(prints)
    with TaskGroup(group_id='taskgroup1') as tasks_prints:
        print_task1(prints['var'])
        print_task2(prints['var2'])
        print_task3(prints['var3'])

my_dag()
    



