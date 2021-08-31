#' Execute a task
#'
#' Tasks can be executed using:
#' - `taskApply()`: execute a task and wait for result (better for quick tasks)
#' - `taskAsyncApply()`: execute a task and immediately return task info without
#' result (better for long-running tasks)
#' - `taskSend()`: execute a task (doesn't require task sources)
#'
#' @param task Character: task to run
#' @param args List of arguments
#' @param kwargs Dictionary of arguments
#'
#' @return Task information:
#'  - Status
#'  - Identifier
#'  - Result (in case of `taskApply()` only)
#' @export
#'
#' @examples
#' taskApply("tasks.add")
taskApply <- function(task, args=NULL, kwargs=NULL, url=getFlowerURL()) {
    errors <- list("404"="unknown task")
    runTask(type="apply", task=task, args=args, kwargs=kwargs, url=url,
            errors=errors)
}

#' @rdname taskApply
#'
#' @param options Dictionary of *apply_async* keyword arguments
#' @export
#'
#' @examples
#' taskAsyncApply("tasks.add", args=list(a=1, b=2))
taskAsyncApply <- function(task, args=NULL, kwargs=NULL, options=NULL,
                           url=getFlowerURL()) {
    errors <- list("404"="unknown task")
    runTask(type="async-apply", task=task,
            args=args, kwargs=kwargs, options=options, url=url, errors=errors)
}

#' @rdname taskApply
#' @export
#'
#' @examples
#' taskSend("tasks.add", args=list(a=1, b=2))
taskSend <- function(task, args=NULL, kwargs=NULL, url=getFlowerURL()) {
    errors <- list("404"="unknown task")
    runTask(type="send-task", task=task, args=args, kwargs=kwargs, url=url,
            errors=errors)
}
