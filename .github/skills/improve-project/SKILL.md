---
name: improve-project
description: "Use only to extend an existing language-specific project in this repository with a requested topic or example, such as adding a Rust iterator technique to the existing iterators project. Do not use to create a new project."
---

# Improve an Existing Playground Project

Extend an existing algorithm or concept project with the user's requested topic, while preserving the project's conventions and behavior.

## Required Information

1. Identify the existing project, its programming language, and the requested topic or improvement from the user's prompt.
2. If the project, language, or requested change cannot be identified unambiguously, ask a focused question before editing.

## Procedure

1. Resolve the project to its language-specific directory under `playground/algorithms/<project>/<language>/` or `playground/concepts/<project>/<language>/`.
2. Confirm that the exact project directory already exists before reading it for changes. If it does not exist, make no changes: do not scaffold it, create a substitute, or edit a similarly named project. Tell the user that the requested project was not found and report the expected path.
3. Inspect the existing source, tests, and relevant project configuration or documentation. Follow the established language, naming, formatting, testing, and documentation conventions; do not assume conventions from another language version of the project.
4. Check whether the requested topic or behavior is already covered. Extend or correct the existing example rather than adding a duplicate.
5. Make the smallest complete change within the existing project. Add or update focused tests for the new behavior, and update directly related documentation when needed. Do not change the syllabus or unrelated projects unless the user explicitly asks.
6. Run the narrowest relevant test, build, or formatting check supported by the project. Report any check that could not be run or that failed; do not imply success without verification.
7. Summarize the change and identify the exact project files changed.
