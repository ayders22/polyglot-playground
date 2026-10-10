---
name: update-syllabus
description: "Scan playground implementations against language syllabus files and add missing topics. Use to synchronize or update the syllabi from implemented algorithms and concepts; no language or topic needs to be specified."
---

# Synchronize Language Syllabi

Scan the repository and update every language syllabus with implemented playground topics that are not yet listed. Do not ask the user to specify a language or topic.

## Procedure

1. Enumerate every project directory under `playground/algorithms/` and `playground/concepts/` that contains implementation source or tests. Projects follow `playground/<category>/<topic>/<language>/`; ignore generated files such as caches and build output. Derive the language and topic from each directory path.
2. Inspect source and tests for every enumerated project to confirm it implements the topic and to ground the syllabus summary. Do not stop after finding the first missing topic or rely on a partial scan.
3. Read every corresponding `syllabus/<language>.md` that exists. For each confirmed project, compare its exact project-directory link (for example, `../playground/concepts/iterators/rust`) against the links in that language's syllabus. Track every project as already listed, missing, or skipped; complete this comparison for all projects before editing.
4. Add one concise bullet for every missing project. Use a clear topic title and a short summary grounded in the implementation or tests. Link to the language-specific project directory, not an individual file.
5. Preserve existing entries and their order. Append new entries grouped by category (`algorithms`, then `concepts`) and alphabetically by topic within each category, so repeated runs produce stable ordering.
6. Do not create a syllabus for a language if its corresponding file does not exist. Do not guess when a project's topic or language cannot be identified; leave it unchanged, mark it skipped, and report why.
7. Before finishing, verify that every confirmed project was listed initially or added, and that no project link appears more than once in its syllabus. Report which files changed, the topics added, and any skipped projects. If nothing is missing, report that all implemented topics are already listed.
