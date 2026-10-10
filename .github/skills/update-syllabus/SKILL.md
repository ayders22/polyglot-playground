---
name: update-syllabus
description: "Scan playground implementations against language syllabus files and add missing topics. Use to synchronize or update the syllabi from implemented algorithms and concepts; no language or topic needs to be specified."
---

# Synchronize Language Syllabi

Scan the repository and update every language syllabus with implemented playground topics that are not yet listed. Do not ask the user to specify a language or topic.

## Procedure

1. Inspect project directories under `playground/algorithms/` and `playground/concepts/`. Projects follow `playground/<category>/<topic>/<language>/`; derive candidate languages from these directories and match each to `syllabus/<language>.md`.
2. For each candidate project, inspect its source and tests to confirm it contains an implemented topic. Ignore empty directories and generated files such as caches or build output.
3. Read each matching syllabus and use its existing bullet and link format. Treat the project directory link (for example, `../playground/concepts/iterators/rust`) as the canonical identity of an entry; do not add a duplicate when that path is already linked.
4. Add one concise bullet for each implemented project path missing from its language syllabus. Use a clear topic title and a short summary grounded in the implementation or tests. Link to the language-specific project directory, not an individual file.
5. Preserve existing entries and their order. Append new entries grouped by category (`algorithms`, then `concepts`) and alphabetically by topic within each category, so repeated runs produce stable ordering.
6. Do not create a syllabus for a language if its corresponding file does not exist. Do not guess when a project's topic or language cannot be identified; leave it unchanged and report it as skipped.
7. Report which syllabus files were changed, the topics added, and any projects skipped. If nothing is missing, report that all implemented topics are already listed.
