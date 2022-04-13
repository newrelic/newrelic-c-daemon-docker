#------------------------------------------------------------------------------
# Copyright [2019] New Relic Corporation. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#------------------------------------------------------------------------------

FROM alpine:3.12.12 AS build

# install the dependencies needed to build the daemon
RUN apk add --no-cache \
                bash \
                git \
                go \
                libc-dev \
                make

ENV NEWRELIC_C_SDK_REPO https://github.com/newrelic/c-sdk.git
ENV NEWRELIC_VERSION v1.3.0

RUN set -ex; \
        git clone ${NEWRELIC_C_SDK_REPO}; \
        cd c-sdk; \
        git checkout ${NEWRELIC_VERSION}; \
        make newrelic-daemon; \
        mv newrelic-daemon /usr/bin/newrelic-daemon; \
        cd; \
        chown root:root /usr/bin/newrelic-daemon; \
        chmod 777 /usr/bin/newrelic-daemon

FROM alpine:3.12.12

RUN apk add --no-cache \
                ca-certificates

RUN set -ex; \
        mkdir /var/log/newrelic

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
COPY --from=build /usr/bin/newrelic-daemon /usr/bin/newrelic-daemon

EXPOSE 31339

ENTRYPOINT ["sh","/usr/bin/docker-entrypoint.sh"]

CMD ["/usr/bin/newrelic-daemon"]
