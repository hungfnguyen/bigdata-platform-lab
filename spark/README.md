# Apache Spark

Spark is the primary engineering subject of this repository. Work progresses
from execution internals to deployment and production-style debugging.

Planned runtime modes:

1. Local
2. Standalone
3. YARN
4. Kubernetes native submit
5. Spark Operator

The same application contract will be reused across runtime modes. Word count or
Spark Pi may be used as smoke tests; a relational Ethereum snapshot will support
ETL and tuning experiments.
