#' Task operations
#'
#' @param id Character: task identifier
#' @inheritParams workerList
#'
#' @return Flower response
#' @export
#'
#' @examples
#' task <- rownames(taskList())[[1]]
#' taskAbort(task)
taskAbort <- function(id, url=getFlowerURL()) {
    id <- getTaskId(id)
    errors <- list("503"="result backedn is not configured")
    postAction(url=url, "task", "abort", id, errors=errors)
}

#' @rdname taskAbort
#' @param terminate Boolean: terminate task if running?
#' @param signal Character: signal to send when terminating task
#'
#' @export
#' @examples
#' taskRevoke(task)
taskRevoke <- function(id, terminate=TRUE, signal="SIGTERM",
                       url=getFlowerURL()) {
    id <- getTaskId(id)
    postAction(url=url, "task", "revoke", id, terminate=terminate,
               signal=signal)
}

#' @rdname taskAbort
#' @param workername Character: worker name
#' @param softLimit Integer: soft limit
#' @param hardLimit Integer: hard limit
#'
#' @examples
#' worker <- names(workerList())[[1]]
#' taskTimeout(worker, "tasks.add", softLimit=60)
taskTimeout <- function(workername, task, softLimit=30, hardLimit=100,
                        url=getFlowerURL()) {
    errors <- list("404"="unknown task/worker")
    postAction(url=url, "task", "timeout", task, workername=workername,
               softLimit=softLimit, hardLimit=hardLimit, errors=errors)
}

#' @rdname taskAbort
#' @param ratelimit Integer: rate limit
#'
#' @export
#' @examples
#' taskRateLimit(worker, "tasks.add", 200)
taskRateLimit <- function(workername, task, ratelimit, url=getFlowerURL()) {
    errors <- list("404"="unknown task/worker")
    postAction(url=url, "task", "rate-limit", task,
               ratelimit=ratelimit, workername=workername, errors=errors)
}
