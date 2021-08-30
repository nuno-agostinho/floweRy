#' @importFrom httr GET content accept_json http_error
getInfo <- function(type, ..., url=getFlowerURL()) {
    get <- GET(url=url, path=paste0("/api/", type), query=list(...))
    stop_for_status(get)
    return(content(get))
}

#' List workers
#'
#' @param refresh Boolean: update list of workers
#' @param workername Character: filter info by worker's name
#' @param status Boolean: only get information on worker status
#' @param url Character: Flower URL
#'
#' @return List of workers containing worker information
#' @export
#'
#' @examples
#' workerList()
#' workerList(refresh=TRUE)
#' workerList(status=TRUE) # only print worker status
#' workerList(workername="celery@d2b3d2b64077")
workerList <- function(refresh=FALSE, workername=NULL, status=FALSE,
                       url=getFlowerURL()) {
    getInfo(type="workers", refresh=refresh, workername=workername,
            status=status, url=url)
}

#' List information of tasks
#'
#' @param limit Integer: maximum number of tasks
#' @param offset Integer: skip first N tasks
#' @param sortBy Character: sort tasks by attribute (`name`, `state`,
#' `received`, `started`)
#' @param workername Character: filter task by workername
#' @param taskname Character: filter tasks by taskname
#' @param state Character: filter tasks by state
#' @param receivedStart Character: filter tasks by received date (must be
#' greater than) format %Y-%m-%d %H:%M
#' @param receivedEnd Character: filter tasks by received date (must be less
#' than) format %Y-%m-%d %H:%M
#' @param table Boolean: format response as table? If not, a list is returned
#' @inheritParams workerList
#'
#' @return Data frame or list of task information
#'
#' @export
#' @examples
#' taskList()
taskList <- function(limit=NULL, offset=NULL,
                     sort_by=c("name", "state", "received", "started"),
                     workername=NULL, taskname=NULL, state=NULL,
                     received_start=NULL, received_end=NULL, table=TRUE,
                     url=getFlowerURL()) {
    sort_by <- match.arg(sort_by)
    res <- getInfo(type="tasks", limit=limit, offset=offset, sort_by=sort_by,
                   workername=workername, taskname=taskname, state=state,
                   received_start=received_start, received_end=received_end,
                   url=url)
    if (table) res <- data.frame(do.call(rbind, res))
    return(res)
}

#' List (seen) task types
#'
#' @inheritParams workerList
#'
#' @return List of task types
#' @export
#'
#' @examples
#' taskTypesList()
taskTypesList <- function(url=getFlowerURL()) {
    getInfo(type="task/types", url=url)
}

#' List length of all active queues
#'
#' @inheritParams workerList
#'
#' @return List of active queues
#' @export
#'
#' @examples
#' queueLength()
queueLength <- function(url=getFlowerURL()) {
    getInfo(type="queues/length", url=url)
}

#' Get a task info
#'
#' @param id Character: task identifier
#' @inheritParams workerList
#'
#' @return List of active queues
#' @export
#'
#' @examples
#' task <- rownames(taskList())[[1]]
#' taskInfo(task)
taskInfo <- function(id, url=getFlowerURL()) {
    getInfo(type=paste0("task/info/", id), url=url)
}
