# This script releases a new version of the NBA documenation.
# The versioning follows this pattern:
#     <NBA_TAG>-docs-V<DOCS_VERSION>-YYYY-MM-DD
# The date will be appended in this script.

TAGVERSION=$1
if [ -z "$1" ]; then 
	echo "Need varsion tag as argument, tag format: \
<NBA_TAG>-docs-V<DOCS_VERSION>, example: V2.11.3-docsV1";
	exit 0;
fi

# get current tag
CURRENT_TAG=`git describe --abbrev=0`

# get current live NBA version
# NBA_VERSION=`curl -XGET -s \
#             http://api.biodiversitydata.nl/v2 | grep Tag | perl -ne \
#             '$_=~s/.*(V\d+\.\d+\.\d+)<.*/$1/g; print $_;'`


# append date
DATE=`date +%Y-%m-%d`
TAG=${TAGVERSION}-${DATE}

if [ "$TAG" == "$CURRENT_TAG" ]; then
	echo "Version $TAGVERSION already exists.";
	exit 0;
fi

# set tag as travis environment variable
travis env set TRAVIS_TAG $TAG

# make git tag and push
git tag -a $TAG -m "Release v$TAG"
git push --tags

# unset environment variable
travis env unset TRAVIS_TAG
