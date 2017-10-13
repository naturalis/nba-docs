## use hugo image based on alpine linux
FROM jojomi/hugo:latest

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

## install theme	
RUN git clone https://github.com/digitalcraftsman/hugo-material-docs.git \
	themes/hugo-material-docs		

## build static site 
RUN hugo

## expose port; caution: still need to publish when running!
EXPOSE $NBADOCS_PORT
	
# by default, serve site
CMD hugo server -b http://${NBADOCS_HOST}:${NBADOCS_PORT} \
	 --bind=0.0.0.0 -p $NBADOCS_PORT
