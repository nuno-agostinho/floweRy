FROM rocker/rstudio

RUN apt-get update && apt-get install -y libxml2

RUN R -e 'install.packages("devtools")'
RUN R -e 'install.packages("roxygen")'

Run apt-get install -y libgit2-dev
