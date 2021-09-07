# floweRy
R package to manage Celery task queues via Flower's
[REST API](https://flower.readthedocs.io/en/latest/api.html).

## Install

```R
install.packages("remotes")
remotes::install_github("nuno-agostinho/floweRy")
```

## Setup

By default, flower runs in http://localhost:5555. If this is not the case,
change the default URL:

```R
options(flowerURL="http://flower:5555")
```

## Run and manage tasks

Tasks can be run in two ways:
- Apply: run task and wait for result
- Async-apply: run task in background (do not wait for result)

```R
# Add two numbers using tasks.add
taskApply <- taskApply("tasks.add", 3, 4)
taskAsync <- taskAsyncApply("tasks.add", 20, 53)

taskResult(taskAsync) # get task result
taskInfo(taskAsync)   # get task info (including state)

# List all tasks
taskList()
```

|uuid                                 |name      |state   |received            |sent |started             |rejected |succeeded           |failed |retried |revoked |args     |kwargs |eta |expires | retries|result |exception |timestamp           |   runtime|traceback |exchange |routing_key | clock|client |root                                 |root_id                              |parent |parent_id |children |worker              |
|:------------------------------------|:---------|:-------|:-------------------|:----|:-------------------|:--------|:-------------------|:------|:-------|:-------|:--------|:------|:---|:-------|-------:|:------|:---------|:-------------------|---------:|:---------|:--------|:-----------|-----:|:------|:------------------------------------|:------------------------------------|:------|:---------|:--------|:-------------------|
|a7a67c47-d373-4e77-9445-9679a7f1c9cf |tasks.add |SUCCESS |2021-09-07 18:38:34 |NA   |2021-09-07 18:38:34 |NA       |2021-09-07 18:38:34 |NA     |NA      |NA      |[20, 53] |{}     |NA  |NA      |       0|73     |NA        |2021-09-07 18:38:34 | 0.0015033|NA        |NA       |NA          |    16|NA     |a7a67c47-d373-4e77-9445-9679a7f1c9cf |a7a67c47-d373-4e77-9445-9679a7f1c9cf |NA     |NA        |NULL     |celery@2d5665fb19f4 |
|e694adc8-3d4d-43f0-a9d6-c6553139dbc9 |tasks.add |SUCCESS |2021-09-07 18:38:34 |NA   |2021-09-07 18:38:34 |NA       |2021-09-07 18:38:34 |NA     |NA      |NA      |[3, 4]   |{}     |NA  |NA      |       0|7      |NA        |2021-09-07 18:38:34 | 0.0049620|NA        |NA       |NA          |    13|NA     |e694adc8-3d4d-43f0-a9d6-c6553139dbc9 |e694adc8-3d4d-43f0-a9d6-c6553139dbc9 |NA     |NA        |NULL     |celery@2d5665fb19f4 |

```R
# Revoke task
task <- taskAsyncApply("tasks.add", 3, 4)
taskRevoke(task)
```

## Manage workers

```R
# List all workers
workerList()
worker <- names(workerList())[[1]]

# Manage worker's pool
workerPoolGrow(worker, 5)
workerPoolShrink(worker, 3)
workerPoolAutoscale(worker, 3, 7)
workerPoolRestart(worker)

# Shutdown worker
workerShutdown(worker)
```
