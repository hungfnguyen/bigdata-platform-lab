FROM eclipse-temurin:17-jre-jammy@sha256:475d8e96b4b2bfe08999e5e854755c773af1581acdf959a4545d88f0696a2339

ARG HADOOP_VERSION=3.5.0
ARG HADOOP_SHA512=04ab94496cc00c8b7a28d03f6308eff8d2a4e7f37a9da5e8e086e4d6fc990e7a94d661908f6a6136039536efb362614b8aecdef185b5fb8ed588f0b152c7aa16

ENV HADOOP_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    HADOOP_LOG_DIR=/var/log/hadoop \
    PATH=/opt/hadoop/bin:/opt/hadoop/sbin:$PATH

RUN apt-get update \
    && apt-get install --yes --no-install-recommends ca-certificates curl procps tini \
    && (curl --fail --location --retry 3 \
          "https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" \
          --output /tmp/hadoop.tar.gz \
        || curl --fail --location --retry 3 \
          "https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" \
          --output /tmp/hadoop.tar.gz) \
    && test -s /tmp/hadoop.tar.gz \
    && echo "${HADOOP_SHA512}  /tmp/hadoop.tar.gz" | sha512sum --check --strict \
    && tar --extract --gzip --file /tmp/hadoop.tar.gz --directory /opt \
    && mv "/opt/hadoop-${HADOOP_VERSION}" "${HADOOP_HOME}" \
    && groupadd --gid 1000 hadoop \
    && useradd --uid 1000 --gid hadoop --create-home --shell /bin/bash hadoop \
    && mkdir -p \
        /var/lib/hadoop/tmp \
        /var/lib/hadoop-hdfs/namenode \
        /var/lib/hadoop-hdfs/datanode \
        /var/lib/hadoop-yarn/local \
        /var/lib/hadoop-yarn/logs \
        "${HADOOP_LOG_DIR}" \
    && chown -R hadoop:hadoop \
        "${HADOOP_HOME}" \
        /var/lib/hadoop \
        /var/lib/hadoop-hdfs \
        /var/lib/hadoop-yarn \
        "${HADOOP_LOG_DIR}" \
    && rm -rf /var/lib/apt/lists/* /tmp/hadoop.tar.gz

COPY --chown=hadoop:hadoop conf/ ${HADOOP_CONF_DIR}/
COPY --chown=hadoop:hadoop container-scripts/ /opt/hadoop-lab/bin/

USER hadoop
WORKDIR /home/hadoop

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["hadoop", "version"]
