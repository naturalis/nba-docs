# This script releases a new version of the NBA documenation.
# Version numbering is done automatically in this script.
# The versioning follows this pattern:
#     <NBA_TAG>-docs-V<DOCS_VERSION>-YYYY-MM-DD
# If the NBA release version changed, the DOCS_VERSION
# will be reset to 0. Otherwise DOCS_VERSION
# wil be increased by 1.

# get current tag and parse current docs version
CURRENT_TAG=`git describe --abbrev=0`
CURRENT_DOCS_VERSION=`echo $CURRENT_TAG | \
                      perl -ne '$_=~s/.*docsV(\d+).*/$1/g; print $_'`


# parse current NBA version from tag
CURRENT_NBA_VERSION=`echo $CURRENT_TAG | \
                 perl -ne '$_=~ s/-.*//g; print $_'`

# get live NBA version
NEW_NBA_VERSION=`curl -XGET -s \
             http://api.biodiversitydata.nl/v2 | grep Tag | perl -ne \
             '$_=~s/.*(V.*?)<.*/$1/g; print $_;'`

# if there is a new NBA version, reset docs version counter to 0,
#  otherwise increase
if [ "$CURRENT_NBA_VERSION" == "$NEW_NBA_VERSION" ]; then
	NEW_DOCS_VERSION=$((CURRENT_DOCS_VERSION +1))
else
	NEW_DOCS_VERSION=0
fi

# compile new tag
DATE=`date +%Y-%m-%d`
NEW_TAG=${NEW_NBA_VERSION}-docsV${NEW_DOCS_VERSION}-${DATE}

# Print tag to user and ask if it's ok
echo -e "Change release version \033[31m $CURRENT_TAG \033[0m to \033[31m $NEW_TAG\033[0m ? (y/n) [y]"
read OK
if [ "$OK" != "y" ] && [ "$OK" != "" ]; then
	echo "Exiting."
	exit 0;
fi

# substitute release in config file
sed -i -e  "s|$CURRENT_TAG|$NEW_TAG|g" config.toml
sed -i -e  "s|$CURRENT_NBA_VERSION|$NEW_NBA_VERSION|g" config.toml

# commit config file
git commit -m "Release $NEW_TAG" config.toml

# set tag as travis environment variable
travis env set TRAVIS_TAG $NEW_TAG

# make git tag and push
git tag -a $NEW_TAG -m "Release v$NEW_TAG"
git push && git push --tags
 
# unset environment variable
travis env unset TRAVIS_TAG
