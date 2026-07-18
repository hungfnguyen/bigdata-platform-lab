# Data

Data supports Spark execution and tuning; it is not a separate platform domain.

Small deterministic fixtures may be committed for smoke tests. Larger snapshots
must be generated or downloaded into ignored runtime directories and described
by a versioned manifest containing source, schema, date range, row counts, size,
and checksums.

The planned domain workload uses a curated snapshot of Google's public Ethereum
dataset. Spark runtimes will consume the resulting files rather than query
BigQuery directly.
