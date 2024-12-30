#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

# Versioning
NEXUS_URL="http://nexus.criteo.prod/content/repositories/criteo.thirdparty/com/cloudera/hue"
VERSION="DUMMY-FOR-CI"
source VERSION
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LAST_COMMIT_ID=$(git rev-parse --short HEAD)
DATE=$(date -u +%Y%m%d%H%M%S)
CRITEO_VERSION=$VERSION+$DATE.$LAST_COMMIT_ID

# Build release environment Docker image
docker build . -t hue-dev -f tools/docker/dev/Dockerfile

# Build Hue artifact
docker run --rm --volume $PWD:/data --workdir /data --user $(id -u):$(id -g) hue-dev make prod

# Build static files
pushd build
tar czf hue-static-"$VERSION".tgz static/
popd

# Release to Nexus
if [ ! -z $MAVEN_PASSWORD ]; then
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" --upload-file build/release/prod/hue-*.tgz ${NEXUS_URL}/hue/$CRITEO_VERSION/hue-$CRITEO_VERSION.tgz
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" --upload-file build/static/hue-static*.tgz ${NEXUS_URL}/hue-static/$CRITEO_VERSION/hue-static-$CRITEO_VERSION.tgz
    cat << EOF > maven-metadata-hue.xml
<?xml version="1.0" encoding="UTF-8"?>
<metadata>
  <groupId>com.cloudera.hue</groupId>
  <artifactId>hue</artifactId>
  <versioning>
    <latest>$CRITEO_VERSION</latest>
    <release>$CRITEO_VERSION</release>
    <versions>
      <version>$CRITEO_VERSION</version>
    </versions>
    <lastUpdated>$DATE</lastUpdated>
  </versioning>
</metadata>
EOF
    cat << EOF > maven-metadata-hue-static.xml
<?xml version="1.0" encoding="UTF-8"?>
<metadata>
  <groupId>com.cloudera.hue</groupId>
  <artifactId>hue-static</artifactId>
  <versioning>
    <latest>$CRITEO_VERSION</latest>
    <release>$CRITEO_VERSION</release>
    <versions>
      <version>$CRITEO_VERSION</version>
    </versions>
    <lastUpdated>$DATE</lastUpdated>
  </versioning>
</metadata>
EOF
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" -X DELETE ${NEXUS_URL}/hue/maven-metadata.xml
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" -X DELETE ${NEXUS_URL}/hue/maven-metadata.xml.md5
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" -X DELETE ${NEXUS_URL}/hue/maven-metadata.xml.sha1
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" --upload-file maven-metadata-hue.xml ${NEXUS_URL}/hue/maven-metadata.xml
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" -X DELETE ${NEXUS_URL}/hue-static/maven-metadata.xml
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" -X DELETE ${NEXUS_URL}/hue-static/maven-metadata.xml.md5
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" -X DELETE ${NEXUS_URL}/hue-static/maven-metadata.xml.sha1
    curl -v -u "$MAVEN_USER:$MAVEN_PASSWORD" --upload-file maven-metadata-hue-static.xml ${NEXUS_URL}/hue-static/maven-metadata.xml
fi
