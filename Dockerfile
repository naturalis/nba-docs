FROM jojomi/hugo:latest

MAINTAINER hettling
	
## add all files in repository
ADD . /src/
		
## make static site 
RUN hugo

EXPOSE 1313	

# XXX it seems to necessary to give base URL to hugo!
ENV HUGO_BASE_URL http://localhost:1313
# By default, serve site
CMD hugo server -b ${HUGO_BASE_URL} --bind=0.0.0.0
