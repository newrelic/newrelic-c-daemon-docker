# Daemon Docker Image

[![Build Status](https://travis-ci.org/newrelic/newrelic-c-daemon-docker.svg?branch=master)](https://travis-ci.org/newrelic/newrelic-c-daemon-docker)

This is a repository of base images for the New Relic Daemon. The New Relic Daemon is part of the New Relic [C-SDK](https://github.com/newrelic/c-sdk). The Dockerfile in this repo is meant to make it easy to run the daemon in a separate container from the SDK.

## Running the Image
To run this image, use the commands docker build and docker run:
```
docker build -t newrelic-daemon .
docker run --name some-daemon newrelic-daemon
```

The daemon will listen on port 31339.

## Accessing logs

The daemon logs are available by accessing the docker logs:

```
docker logs some-daemon
```

## Using a custom config file

You may want to run the daemon using a custom config. The `-c` daemon flag must
be set to the location of the config file. The `-v` flag will copy a local
config file into the container. An absolute path is required when using the `-v`
flag.
```
docker run --name some-daemon -v $PWD/newrelic.cfg:/etc/newrelic/newrelic.cfg newrelic-daemon -c /etc/newrelic/newrelic.cfg
```

## Passing in flags
Additional configuration can be passed in as flags. If you' like to
change the log level, use the following command:
```
docker run newrelic-daemon --loglevel debug
```
To find out more about what flags are possible, execute the following command:
```
docker run newrelic-daemon --help
```


More information about how to setup an agent container can be found on the
[docs site](https://docs.newrelic.com/docs/agents/c-sdk/install-configure/docker-other-container-environments-install-c-sdk).
