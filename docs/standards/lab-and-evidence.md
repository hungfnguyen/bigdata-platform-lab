# Lab and Evidence Standard

Each lab must make a technical claim, provide a reproducible experiment, and
record evidence. A successful startup alone is insufficient.

## Lab contract

Every setup must include:

- Purpose and the system behavior being studied
- Architecture and process placement
- Version and compatibility information
- Configuration with rationale for non-default values
- Reproducible lifecycle and inspection commands
- A deterministic smoke test with expected output
- At least one relevant failure or degraded-mode exercise
- Known limitations and differences from production

Required information may be combined or split according to lab complexity.
Empty files, TODO-only scaffolds, and unverified manifests are not acceptable.

## Evidence contract

Keep these sections distinct:

```text
Expected
Observed
Evidence
Explanation
```

Observations must come from executed commands or evidence supplied by the user.
Do not convert theory or generated expectations into claimed results. If a check
was not run, state that clearly.

Prefer command output, logs, metrics, and versioned results over screenshots.

## Benchmark contract

Keep these variables fixed where possible:

- Spark version and application image
- Application code and parameters
- Input snapshot and checksum
- Driver and executor resources
- Relevant Spark configuration
- Number of measured runs and warm-up policy

Record:

- Runtime and deployment mode
- Host or cluster hardware
- Wall-clock duration
- Input and output row counts and bytes
- Stage/task counts, shuffle, spill, memory, and garbage collection
- Failures, retries, and excluded runs

Results from different storage paths or materially different hardware must not be
presented as a pure cluster-manager comparison.

## Data contract

Small fixtures may be committed when their source and expected output are clear.
Larger inputs belong in ignored runtime directories and require a manifest with:

- Source and extraction query or generator
- Immutable range and schema version
- Row count, size, file count, and format
- Checksums

BigQuery or another external system may prepare a snapshot, but Spark jobs should
consume the resulting files so that external credentials and network variability
do not become runtime dependencies.
