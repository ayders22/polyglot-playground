---
name: review-playground-test-names
description: "Review test function names under playground/ so they clearly teach the verified technical concepts, while avoiding vague, misleading, or inconsistent names; propose concise replacements."
---

# Review Playground Test Names

Review test function names in the repository's `playground/` directory. These tests are teaching material: names should help readers understand the technical concepts demonstrated as well as what the test verifies. Propose concise replacements in a consistent style. Do not rename tests unless the user selects the proposed changes.

## Naming Convention

- Use concise `snake_case` names that communicate the verified behavior and the programming-language concept being taught.
- Preserve specific concepts the project teaches, even when the concept is also visible in the project path. Do not reduce a name to a generic result if that hides the lesson, such as changing a name about static string fields to one that only says the value is stored.
- Prefer language-level concepts over domain data or generic outcomes. For Rust struct tests, name concepts such as scalar-valued fields, `&'static str` fields, borrowed versus static fields, and `static` items.
- Keep the language construct explicit when it helps readers recognize what the test teaches, even if it repeats a term from the path. For example, prefer `struct_has_scalar_value_members` to `point_stores_coordinates`, and `struct_has_static_str_members` to a name that only says values are stored.
- Describe what the test proves, not merely its setup or test mechanics. Read the implementation when necessary to confirm the technical concept, and ensure the assertions support the behavior claimed by the name.
- Keep names within the same test file coherent in grammar and level of detail.
- Preserve any prefix or naming shape required by the language's test runner, such as Python's `test_` prefix. The descriptive part must still follow the convention above.
- Do not alter test behavior, assertions, or unrelated code as part of a naming review.

## Procedure

1. Limit discovery to `playground/`. Find test files using the repository's language-specific conventions and skip generated files, caches, and build output.
2. Read each relevant test and its corresponding implementation to identify both its assertions and the specific programming-language concept it teaches.
3. Assess names for vagueness, misleading claims, omission of the language concept, irrelevant domain details, inconsistent style, and mismatch with assertions. The project path is not a substitute for explicitly naming the technical concept.
4. Report only names with a meaningful issue. For each, show the file, current name, proposed name, and a brief reason. Keep proposals concise and ensure each describes the test's actual assertions.
5. Do not edit files in the review phase. Ask the user which proposals they want applied, unless they already selected specific names or explicitly asked to rename them.
6. If the user selects changes, rename only those test functions, preserving test-runner discovery conventions and leaving test logic untouched. Check for duplicate names in the same scope and update references only when required.
7. Run the narrowest relevant test command for the changed files when renames are applied. Report the proposals, applied names, and validation result separately.
