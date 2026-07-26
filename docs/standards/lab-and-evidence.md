# Lab and Evidence Standard

## Purpose

A working deployment is not sufficient evidence of platform knowledge. Each lab
must make a technical claim, provide a reproducible experiment, and record the
observed result.

## Minimum lab contract

Every setup must include:

- Purpose and the system behavior being studied
- Architecture and process placement
- Version and compatibility information
- Configuration with rationale for non-default values
- Reproducible start, submit, inspect, and cleanup commands
- A deterministic smoke test with expected output
- At least one relevant failure or degraded-mode exercise
- Logs, UI metrics, command output, or other evidence
- Known limitations and differences from production

Setup directories are added only when this contract can be met. Empty scaffolds
and unverified manifests are not part of the repository.

## Benchmark contract

Runtime comparisons must keep these variables fixed where possible:

- Spark version and application image
- Application code and parameters
- Input snapshot and checksum
- Output format and partitioning goal
- Driver and executor resources
- Relevant Spark SQL and shuffle configuration
- Number of measured runs and warm-up policy

Each result must record:

- Runtime and deployment mode
- Host or cluster hardware
- Wall-clock duration
- Input and output row counts and bytes
- Stage and task counts
- Shuffle read/write and spill
- Executor peak memory and garbage-collection time
- Failures, retries, and excluded runs

Results from different storage paths or materially different hardware must not be
presented as a pure cluster-manager comparison.

## Data contract

Small fixtures may be committed when their source and expected output are clear.
Larger inputs belong in ignored runtime directories and require a manifest with:

- Source and extraction query or generator version
- Immutable date or block range
- Schema version
- Row count and compressed size
- File count and format
- Checksums

BigQuery or another external system may prepare a snapshot, but Spark jobs should
consume the resulting files so that external credentials and network variability
do not become runtime dependencies.

## Evidence quality

Evidence should answer three questions:

1. What behavior was expected?
2. What was observed and where was it observed?
3. Why does the result support or reject the original explanation?

Screenshots alone are insufficient when the same fact can be captured through a
command, log, metric, or versioned benchmark result.
