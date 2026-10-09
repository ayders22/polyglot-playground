---
name: create-project-template
description: "Create a language-specific project skeleton for a new algorithm or concept in this repository. Use when asked to scaffold, start, or create a playground project."
---

# Create a Playground Project

Create a new language-specific project skeleton under the repository's algorithm or concept playgrounds.

## Required Information

1. Identify the requested topic and programming language from the user's prompt.
2. If the language is missing, do not inspect or modify the project; ask the user which language to use, then wait.
3. If the topic is missing, ask what topic to create, then wait.
4. Classify the topic as an algorithm or a concept. If the distinction is unclear, ask the user rather than guessing.
5. Once topic and language are known, ask whether the user wants a benchmarking directory before creating files. Do not start scaffolding until they answer.

## Procedure

1. Use the repository's existing directory names: algorithms go under `playground/algorithms/<topic>/<language>/`, and concepts go under `playground/concepts/<topic>/<language>/`. The repository uses plural `algorithms` and `concepts`; do not create singular alternatives.
2. Normalize the topic directory name to the repository's existing kebab-case convention, preserving the user's intended topic. Use the language directory name exactly as used in the repository.
3. Inspect `playground/concepts/hello-world/<language>/` for the language-specific project layout and conventions. Read the relevant source, test, and project configuration files. If that language has no hello-world example, look for the closest existing project in the same language; if none exists, ask the user how they want the project initialized.
4. Check whether the destination already exists. If it does, do not overwrite or merge files; ask the user how to proceed.
5. Create the new language project by following the inspected example's conventions and adapting names, paths, and test identifiers to the requested topic. Create a starter skeleton, not a copy of the hello-world behavior.
6. Include or omit benchmarking files according to the user's answer:
   - If yes, include the benchmark directory and any required language-specific benchmark registration or configuration used by the repository.
   - If no, omit benchmark files and benchmark-only configuration or dependencies.
   - If the reference project has no benchmark convention for that language, inspect another project in the language; if no precedent exists, ask before inventing one.
7. Do not copy generated files, caches, build outputs, or unrelated language directories.
8. Verify that the resulting files and directory structure match the repository's conventions, and run the smallest relevant formatting, build, or test check if the new skeleton supports one.
9. Report the created path and whether benchmarking files were included.
