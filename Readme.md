# Naturalis Biodiversity API (NBA) docs V2
This is the documentation website for the
NBA V2. The website is based on the
static site generator [hugo](https://gohugo.io/). 
Documentation files in markdown format can be found
in the [content/](https://github.com/naturalis/nba-docs/tree/V2_master/content)
subdirectory.

## Running with Docker
A docker container with this site and a hugo server is regularly 
pushed to [docker-hub](https://hub.docker.com/r/naturalis/nba-docs/).
Run with:

`docker run -p 1313:1313 naturalis/nba-docs`

and the site should be available at http://localhost:1313

## Local installation
Building the docs and running a small web server hosting the docs
requires the installation of [hugo](https://gohugo.io/). From the 
top-level directorym issue

`hugo -v -t docuapi`

`hugo server -D`

The site should now be available at http://localhost:1313
