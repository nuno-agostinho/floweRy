% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getters.R
\name{workerList}
\alias{workerList}
\title{List workers}
\usage{
workerList(
  refresh = TRUE,
  workername = NULL,
  status = FALSE,
  url = getFlowerURL()
)
}
\arguments{
\item{refresh}{Boolean: update list of workers}

\item{workername}{Character: filter info by worker's name}

\item{status}{Boolean: only get information on worker status}

\item{url}{Character: Flower URL}
}
\value{
List of workers containing worker information
}
\description{
List workers
}
\examples{
workerList()
workerList(refresh=FALSE)
workerList(status=TRUE) # only print worker status
workerList(workername="celery@d2b3d2b64077")
}
