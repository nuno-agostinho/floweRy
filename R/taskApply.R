#' @importFrom httr POST content
runTask <- function(type="apply", task=NULL,
                    args=NULL, kwargs=NULL, options=NULL, url=getFlowerURL()) {
    url <- file.path(url, "api/task", type, task)
    body <- list(args=list(args))
    print(body)
    post <- POST(url, body=body, encode="json")
    print(post)
    res <- content(post)
    return(res)
}

#' Execute a task
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
    runTask(type="apply", task=task, args=args, kwargs=kwargs, url=url)
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
    runTask(type="asyncApply", task=task,
            args=args, kwargs=kwargs, options=options, url=url)
}
