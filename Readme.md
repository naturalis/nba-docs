# Naturalis Biodiversity API (NBA) docs V2 
This is the documentation
website for the NBA V2. The website is based on the static site
generator [hugo](https://gohugo.io/).  Documentation files in markdown
format can be found in the
[content/](https://github.com/naturalis/nba-docs/tree/V2_master/content)
subdirectory.

## Running with Docker 
A docker container with this site and a hugo
server is regularly pushed to
[docker-hub](https://hub.docker.com/r/naturalis/nba-docs/).  Pass the
following variables to `docker run`:

* `NBADOCS_HOST`: ip of host to run website
* `NBADOCS_PORT`: port where website can be reached
* `SWAGGER_UI_URL`: URL of swagger API endpoint reference documentation (see [here](https://github.com/naturalis/swagger-ui))
* `NBA_BASE_URL`: Base URL of NBA

The port must be published with the `-p` option. Example: Running
with

`docker run -p 8098:8098 -e NBADOCS_HOST=145.136.242.164 -e NBADOCS_PORT=8098 -e SWAGGER_UI_URL=http://145.136.242.164 -e NBA_BASE_URL=http://145.136.242.164:8080 naturalis/nba-docs`

should make the site available at http://145.136.242.164:8098. Note
that in this example, the NBA, swagger-ui and the nba-docs are all
running on the same server.

## Docker-compose for complete NBA documentation 
A `docker-compose.yml` file is available in the top-level directory.
This orchestrates running containers of naturalis/nba-docs and
[naturalis/swagger-ui](https://github.com/naturalis/swagger-ui).  All
hosts and ports that docker-compose needs to know are specified in the
file `.env` and need to be adjusted accordingly.  The whole
documentation can then be set up with

`docker-compose up` 

from the top-level directory of this repo.

## Local installation 
Building the docs and running a small web server
hosting the docs requires the installation of
[hugo](https://gohugo.io/). From the top-level directory issue

`hugo`

`hugo server -D`

The site should now be available at http://localhost:1313. 
