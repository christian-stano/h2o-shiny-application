FROM openanalytics/r-base

MAINTAINER Christian Stano "christian.p.stano@gmail.com"

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.1

# system library dependency for the app
RUN apt-get update && apt-get install -y \
    libmpfr-dev

# install java are for h2o
RUN apt-get update && apt-get install -y \
    openjdk-8-jre-headless

# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"


# copy the app to the image
RUN mkdir /root/h2o-app
COPY h2o-app /root/h2o-app

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/h2o-app', port=3838, host='0.0.0.0')"]
