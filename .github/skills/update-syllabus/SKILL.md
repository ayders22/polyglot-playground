---
name: update-syllabus
description: "Use when asked to add a topic to a language syllabus file, for example: 'add iterators to the Rust syllabus'."
---

# Update a Language Syllabus

When asked to add or update a topic, follow this order and keep each step consistent with the repository's existing syllabus format.

1. Identify the target language and topic before editing anything; e.g., "add iterators to the Rust syllabus" means the language is Rust and the topic is iterators.
2. Find the matching example in the repository for that topic and language; e.g., look for a Rust example named `iterators` or a Rust file that demonstrates iteration.
3. Find the corresponding `syllabus/<language>.md` file for that language; e.g., `syllabus/rust.md` for Rust.
4. Inspect the existing syllabus format first and mirror it exactly; e.g., if the file uses a numbered list or bullet list, keep that structure instead of inventing a new one.
5. Check for an existing entry before adding a new one; e.g., if `iterators` is already listed, update that entry instead of appending a duplicate.
6. Add a concise, coherent entry in the correct place using the same wording and style as nearby items; e.g., a single bullet like `- [Iterators](../playground/concepts/iterators/rust) — implementing a custom iterator`.
7. Keep entries in a sensible learning order by complexity and progression; e.g., place `ownership` before `iterators` when the syllabus is sequenced by foundational concepts.
8. Link the entry to the relevant language-specific concept project directory, not an individual source file; e.g., link Rust iterators to `../playground/concepts/iterators/rust`.
9. Report the exact file that changed; e.g., "Updated `syllabus/rust.md`".
10. If the topic or syllabus file cannot be identified, stop and ask for clarification instead of guessing; e.g., "I could not find a Rust iterator example or `syllabus/rust.md`; which source should I use?"
