# Learning Method

This repository is for building system understanding, not collecting generated
setups.

## Learning loop

```text
Understand -> Design -> Predict -> Build -> Observe
           -> Break -> Recover -> Explain -> Write
```

Before implementation, define:

- The behavior being studied
- Component responsibilities
- State and communication paths
- Expected failure behavior
- Evidence that would confirm the explanation

AI may generate boilerplate, review designs, suggest experiments, and critique
reasoning. The author remains responsible for architecture, configuration,
predictions, verification, and conclusions.

## Experiment rule

Write the expected result before running an experiment. After execution, record:

```text
Expected
Observed
Evidence
Explanation
```

Expected behavior must never be rewritten as an observation.

## Debugging rule

Before asking AI for a root cause:

1. Read the error and relevant logs.
2. Write one or more hypotheses.
3. Gather evidence that supports or rejects each hypothesis.
4. Ask AI to review the reasoning or suggest the next diagnostic check.

## Ownership test

A lab is understood when the author can:

- Draw and explain its architecture without reading the setup
- Explain important configuration and trade-offs
- Predict and diagnose a component failure
- Recover the system and verify recovery
- Change the topology or resources intentionally
- Teach the result using personal observations

Learning notes and blog drafts should be written by the author first. AI may
review clarity and accuracy, but should not replace the reflection.
