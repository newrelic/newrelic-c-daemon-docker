#!/usr/bin/env bash
set -ex

if [[ ! "$1" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]; then
  echo "ERROR: A version string must be passed in"
  exit 1
fi

version=$1
version_short=$(echo $1 | awk -F "." '{print $1 "." $2 "." $3}')

mkdir $version_short

cp docker-entrypoint-template $version_short/docker-entrypoint.sh
cd $version_short

sed s/"ENV[[:space:]]NEWRELIC_VERSION/ENV NEWRELIC_VERSION v${version}"/ ../Dockerfile-template > Dockerfile

git checkout -b $version_short
git add .
git commit -m "version bump to ${version_short}"
