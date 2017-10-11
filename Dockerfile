FROM jojomi/hugo:latest

MAINTAINER hettling <hannes.hettling@naturalis.nl>
	
## site will ge installed in /nba-docs
RUN mkdir /nba-docs

## add all files in repository	
ADD . /nba-docs/
WORKDIR /nba-docs

RUN apk --update add git openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

## install theme	
RUN git clone https://github.com/digitalcraftsman/hugo-material-docs.git \
	themes/hugo-material-docs		

## make static site 
RUN hugo

## expose port, still needs to be published!
EXPOSE 1313	

# XXX it seems to necessary to give base URL to hugo!
ENV HUGO_BASE_URL http://localhost:1313

# By default, serve site
CMD hugo server -b ${HUGO_BASE_URL} --bind=0.0.0.0
