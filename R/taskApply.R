prepareArgs <- function(...) {
    args <- list(...)
    if (is.character(names(args))) stop("Arguments in '...' cannot have names.")
    if (length(args) == 0) args <- NULL
    return(args)
}

#' Execute a task
#'
#' Tasks can be executed using:
#' - `taskApply()`: execute a task and wait for result (better for quick tasks)
#' - `taskAsyncApply()`: execute a task and immediately return task info without
#' result (better for long-running tasks)
#' - `taskSend()`: execute a task (doesn't require task sources)
#'
#' @param task Character: task to run
#' @param ... List of arguments
#' @param kwargs Dictionary of arguments
#'
#' @return Task information:
#'  - Status
#'  - Identifier
#'  - Result (in case of `taskApply()` only)
#' @export
#'
#' @examples
#' taskApply("tasks.add", 3, 8)
taskApply <- function(task, ..., kwargs=NULL, url=getFlowerURL()) {
    errors <- list("404"="unknown task")
    runTask(type="apply", task=task, args=prepareArgs(...), kwargs=kwargs,
            url=url, errors=errors)
}

#' @rdname taskApply
#'
#' @param options Dictionary of *apply_async* keyword arguments
#' @export
#'
#' @examples
#' taskAsyncApply("tasks.add", 5, 7)
taskAsyncApply <- function(task, ..., kwargs=NULL, options=NULL,
                           url=getFlowerURL()) {
    args <- list(...)
    if (length(args) == 0) args <- NULL
    
    errors <- list("404"="unknown task")
    runTask(type="async-apply", task=task, args=prepareArgs(...), kwargs=kwargs,
            options=options, url=url, errors=errors)
}

#' @rdname taskApply
#' @export
#'
#' @examples
#' taskSend("tasks.add", 1, 2)
taskSend <- function(task, ..., kwargs=NULL, url=getFlowerURL()) {
    args <- list(...)
    if (length(args) == 0) args <- NULL
    
    errors <- list("404"="unknown task")
    runTask(type="send-task", task=task, args=prepareArgs(...), kwargs=kwargs,
            url=url, errors=errors)
}
