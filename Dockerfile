FROM rocker/rstudio

RUN export ADD=shiny && bash /etc/cont-init.d/add

