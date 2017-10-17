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
Pass the following variables to `docker run`: 

* `NBADOCS_HOST`: ip of host 
* `NBADOCS_PORT`: port where website can be reached
* `SWAGGER_UI_URL`: URL of swagger API endpoint reference documentation (see [here](https://github.com/naturalis/swagger-ui))

The port must be published with the `-p` option.
Example: Running with

`docker run -p 8098:8098 -e NBADOCS_HOST=145.136.242.164 -e NBADOCS_PORT=8098 -e SWAGGER_UI_URL=http://145.136.242.164 naturalis/nba-docs`

should make the site available at http://145.136.242.164:8098.

## Local installation
Building the docs and running a small web server hosting the docs
requires the installation of [hugo](https://gohugo.io/). From the 
top-level directorym issue

`hugo`

`hugo server -D`

The site should now be available at http://localhost:1313. 
