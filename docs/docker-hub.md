# What is the New Relic C daemon?

The New Relic C daemon acts as a proxy between the C-SDK and the New Relic collector to reduce network traffic and to improve response time for instrumented applications. If the daemon is not running, no data is reported to New Relic.

This image only contains the daemon and is not intended to be a one-container solution. If you would like your application and daemon installed in the same container, follow the documentation on our [GitHub](https://github.com/newrelic/c-sdk).

*Data transmitted the daemon is not encrypted. We recommend only using a private network when connecting to the daemon.*

-	You can read more about the daemon: [New Relic daemon processes](https://docs.newrelic.com/docs/agents/c-sdk/get-started/introduction-c-sdk).
-	Learn more about deploying the C-SDK and daemon in Docker: [Docker and other container environments: Install C SDK](https://docs.newrelic.com/docs/agents/c-sdk/install-configure/docker-other-container-environments-install-c-sdk)

# How to use this image

## Start a newrelic/c-daemon instance

An additional application container, with the C-SDK installed, is required. The C-SDK will send data over TCP to the daemon. The default port for this image is 31339. The daemon will then send up the collected data to New Relic.

Once you've pulled the image, running the daemon container is as simple as:

`$ docker run --name some-daemon -d newrelic/c-daemon`

`some-daemon` should be replaced with the name that you want assigned to the running container.

## Setting up your application container

Requirements:

-	Meet [C-SDK requirements](https://docs.newrelic.com/docs/agents/c-sdk/get-started/c-sdk-compatibility-requirements).
-	C-SDK version 1.2.0 or higher.

## Shell and daemon log access

Using the `docker exec` command will give you access to a shell inside the docker container.

`$ docker exec -it some-daemon sh`

You can use the `docker logs` command to access the daemon logs.

`$ docker logs some-daemon`

## Passing a custom configuration file

You may want to run the daemon using a custom config. The `-c` flag, passed to the daemon, must be set to the location of the config file. The `-v` flag, passed to docker, will copy a local config file into the container. An absolute path is required when using the `-v` flag.

`docker run --name some-daemon -v $PWD/newrelic.cfg:/etc/newrelic/newrelic.cfg newrelic-daemon -c /etc/newrelic/newrelic.cfg`

## Caveats

If the daemon container is not started before the SDK starts sending data, the SDK will not connect to the daemon. This may cause loss of data.
