## use hugo image based on alpine linux
FROM jojomi/hugo:0.31.1

MAINTAINER hettling <hannes.hettling@naturalis.nl>
	
## site will ge installed in /nba-docs
RUN mkdir /nba-docs

## add all files in repository	
ADD . /nba-docs/
WORKDIR /nba-docs

## install git to get the theme
RUN apk --update add git openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

## install theme (clean up before, it case theme already came with ADD)
RUN rm -rf themes/hugo-material-docs
RUN git clone https://github.com/digitalcraftsman/hugo-material-docs.git \
	themes/hugo-material-docs		

## build static site 
RUN hugo
	
# by default, serve site
CMD hugo server -b http://${NBADOCS_HOST}/${NBADOCS_PATH} \
	 --bind=0.0.0.0 -p $NBADOCS_PORT
