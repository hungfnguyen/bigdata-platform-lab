# Spark Runtime Evolution

The repository uses one application contract across multiple cluster managers.
Runtime-specific code is limited to deployment configuration and input/output
locations.

```text
                    +--> local[*]
                    +--> Spark standalone
shared Spark job ---+--> YARN
                    +--> Kubernetes native submit
                    +--> Spark Operator
```

This structure makes runtime behavior comparable without changing business
logic between environments. Functional checks use a small deterministic sample;
performance experiments use an immutable benchmark snapshot.

Hadoop and cloud-native execution remain separate learning branches:

```text
HDFS + YARN --------> Spark on YARN
Kubernetes + k3s ---> Spark on Kubernetes
```

Running HDFS on Kubernetes is outside the current scope.
