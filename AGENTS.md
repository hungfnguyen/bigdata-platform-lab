# Agent Instructions

## Repository purpose

`bigdata-platform-lab` is a focused learning lab for:

- Hadoop HDFS and YARN
- Apache Spark internals and runtime modes
- Spark on Kubernetes
- Terraform-provisioned EC2 with k3s
- Performance, failure, and operations analysis

Spark is the primary subject. Prefer depth over tool count.

## Scope

Do not add unrelated systems such as Kafka, Hive, Trino, Airflow, dbt,
ClickHouse, BI tools, or a general lakehouse stack unless explicitly requested.

Before implementing a lab, read:

- `docs/project/target-and-scope.md`
- `docs/standards/lab-and-evidence.md`
- The relevant domain document under `docs/`

Do not duplicate these standards in setup folders.

## Implementation rules

- Do not create code-only setups.
- Add a setup directory only when implementing and verifying that setup.
- Keep code, configuration, scripts, and documentation close to their owner.
- Prefer explicit configuration over hidden defaults or magic scripts.
- Explain every important non-default value.
- Do not hide destructive or stateful initialization.
- Never format an HDFS NameNode during an image build.
- Keep image construction separate from cluster runtime initialization.
- Pin versions and record compatibility assumptions.
- Avoid abstractions until more than one real use case needs them.
- Do not add tools outside repository scope to solve incidental problems.

## Documentation rules

- Keep Markdown concise, specific, and evidence-based.
- Organize documents by concept or responsibility, not development phases.
- Require useful information, not a fixed number of files.
- Small labs may keep details in `README.md` and one lab-notes document.
- Split documents only when each file has a clear independent purpose.
- Do not create empty documents or TODO-only scaffolding.
- Separate expected behavior from observed behavior.
- Never present theory, assumptions, or generated text as real observations.
- Record observations only from executed commands or user-provided evidence.
- Prefer official references and include only sources used by the lab.

Each setup must cover:

- Purpose and architecture
- Important configuration
- Reproducible commands
- Smoke verification
- At least one relevant failure exercise
- Observations and evidence
- Troubleshooting discovered during execution
- Lab limitations and production differences

## Scripts and safety

- Name scripts after the technology lifecycle; do not force generic names.
- Make scripts repeatable and expose the important commands they run.
- Require explicit confirmation or arguments for destructive operations.
- Keep credentials, private keys, state files, and generated data out of Git.
- Provide a clear cleanup path for created resources.

## Verification

Run the strongest checks available for the implemented scope:

1. Build or validate configuration.
2. Start or apply the setup.
3. Run the smoke test.
4. Inspect logs, status, UI, or metrics.
5. Run the relevant failure exercise.
6. Recover and clean up.

Do not invent successful results. Report commands that were not run and explain
the blocker.

## Definition of done

A setup is complete only when it can be started, tested, inspected, broken in a
controlled way, recovered, cleaned up, and explained with concise evidence.
