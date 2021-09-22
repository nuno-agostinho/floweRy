getFlowerURL <- function() {
    getOption("flowerURL", "http://localhost:5555")
}

#' @importFrom httr status_code stop_for_status
simplifyAPIerror <- function(res, errors) {
    msg <- errors[[as.character(status_code(res))]]
    if (!is.null(msg)) {
        stop(msg)
    } else {
        stop_for_status(res)
    }
}

#' @importFrom httr GET content stop_for_status
getInfo <- function(type, ..., url=getFlowerURL(), errors=NULL) {
    res <- GET(url=url, path=file.path("api", type), query=list(...))
    simplifyAPIerror(res, errors)
    return(content(res))
}

#' @importFrom httr POST stop_for_status content
postAction <- function(type, action, id, ..., url=getFlowerURL(), errors=NULL) {
    url <- file.path(url, "api", type, action, id)
    res <- POST(url, query=list(...))

    simplifyAPIerror(res, errors)
    return(content(res))
}

#' @importFrom httr POST content
runTask <- function(type="apply", task=NULL,
                    args=NULL, kwargs=NULL, options=NULL, url=getFlowerURL(),
                    errors=NULL) {
    path <- file.path("api/task", type, task)

    convert2list <- function (x) if (!is.null(x) && !is.list(x)) list(x) else x
    args    <- convert2list(args)
    kwargs  <- convert2list(kwargs)
    options <- convert2list(options)

    body <- list(args=args, kwargs=kwargs, options=options)
    res  <- POST(url=url, path=path, body=body, encode="json")
    simplifyAPIerror(res, errors)
    return(content(res))
}

getTaskId <- function(id, attr=c("task-id", "uuid")) {
    res <- id
    if (is.list(id)) {
        available <- attr %in% names(id)
        if (any(available)) {
            # Select only the first match
            attr <- attr[available][[1]]
            res  <- id[[attr]]
        }
    }
    return(res)
}
