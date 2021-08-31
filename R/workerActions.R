#' Worker operations
#'
#' @inheritParams workerList
#'
#' @return Flower response
#' @export
#'
#' @examples
#' worker <- names(workerList())[[1]]
#' workerShutdown(worker)
workerShutdown <- function(workername, url=getFlowerURL()) {
    errors <- list("404"="unknown worker")
    postAction(url=url, "worker", "shutdown", workername, errors=errors)
}

#' @rdname workerShutdown
#' @export
#' @examples
#' workerPoolRestart(worker)
workerPoolRestart <- function(workername, url=getFlowerURL()) {
    errors <- list(
        "403"="pool restart is not enabled (see CELERYD_POOL_RESTARTS)",
        "404"="unknown worker")
    postAction(url=url, "worker/pool", "restart", workername, errors=errors)
}

#' @rdname workerShutdown
#'
#' @param n Integer: number of pool processes to grow/shrink
#'
#' @export
#' @examples
#' workerPoolGrow(worker, 4)
workerPoolGrow <- function(workername, n=1, url=getFlowerURL()) {
    errors <- list("403"="failed to grow", "404"="unknown worker")
    postAction(url=url, "worker/pool", "grow", workername, n=n, errors=errors)
}

#' @rdname workerShutdown
#'
#' @export
#' @examples
#' workerPoolShrink(worker, 4)
workerPoolShrink <- function(workername, n=1, url=getFlowerURL()) {
    errors <- list("403"="failed to shrink", "404"="unknown worker")
    postAction(url=url, "worker/pool", "shrink", workername, n=n, errors=errors)
}

#' @rdname workerShutdown
#'
#' @param min Integer: minimum number of pool processes
#' @param max Integer: maximum number of pool processes
#'
#' @export
#' @examples
#' workerPoolAutoscale(worker, 4)
workerPoolAutoscale <- function(workername, min, max, url=getFlowerURL()) {
    errors <- list(
        "403"="autoscaling is not enabled (see CELERYD_AUTOSCALER)",
        "404"="unknown worker")
    postAction(url=url, "worker/pool", "autoscale", workername,
               min=min, max=max, errors=errors)
}

#' @rdname workerShutdown
#'
#' @param queue Character: queue name
#'
#' @export
#' @examples
#' workerQueueAddConsumer(worker, "sample-queue")
workerQueueAddConsumer <- function(workername, queue, url=getFlowerURL()) {
    errors <- list("403"="failed to add consumer", "404"="unknown worker")
    postAction(url=url, "worker/queue", "add-consumer", workername,
               queue=queue, errors=errors)
}

#' @rdname workerShutdown
#'
#' @export
#' @examples
#' workerQueueCancelConsumer(worker, "sample-queue")
workerQueueCancelConsumer <- function(workername, queue, url=getFlowerURL()) {
    errors <- list("403"="failed to cancel consumer", "404"="unknown worker")
    postAction(url=url, "worker/queue", "cancel-consumer", workername,
               queue=queue, errors=errors)
}
