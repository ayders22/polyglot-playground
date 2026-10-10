---
name: audit-skills
description: "Audit agent skills for clarity, simplicity, consistency, completeness, and actionable instructions. Use when reviewing or tightening one or more SKILL.md files for ambiguity, duplication, irrelevant content, or verbose AI-style prose."
---

# Audit Agent Skills

Review requested skills against the criteria below. Do not include this skill in its own audit unless the user asks.

## Audit Criteria

- **Clear:** Each instruction identifies its action and, when relevant, the triggering condition and expected outcome. Flag wording that permits conflicting actions or leaves a required choice unspecified.
- **Concise:** Keep necessary constraints; remove repeated, irrelevant, ornamental, or generic AI-style wording.
- **Consistent:** Check for conflicting instructions, terminology, format, and conventions within each skill and across the requested set.
- **Complete:** Confirm the skill identifies when it applies and gives enough ordered steps to achieve its stated purpose, including important stop or error conditions.
- **Actionable:** Prefer observable requirements over subjective goals. Replace vague terms with explicit criteria or flag them for clarification.

Do not remove useful safeguards or details merely to shorten a skill. Do not invent behavior, broaden scope, or rewrite content that has no actionable issue. Treat wording as a defect only when it creates ambiguity, redundancy, irrelevance, or unnecessary length.

## Procedure

1. Identify the requested skill or skills. If the target cannot be determined, ask one focused question before auditing.
2. Read each target `SKILL.md` and inspect referenced resources only when needed to verify an instruction or detect duplication.
3. Record only concrete issues. For each, cite the file and quote or locate the relevant text; explain the impact and give a concise correction.
4. Report results by skill. A material defect changes intended behavior, leaves a required step or decision unspecified, creates conflicting instructions, or prevents the skill from being invoked or completed. Separate these defects from optional wording improvements. If none remain, say the skill passes.
5. Do not edit skills unless the user asks for fixes. When asked, make the smallest complete changes and preserve intended behavior.
6. After edits, verify the frontmatter, resource links, and affected instructions once. Report any unresolved issue; do not continue polishing already-satisfied criteria.

## Stop Rule

Complete one audit pass. If fixes are requested, make one revision pass and one verification pass, then stop. Do not repeat audits for subjective polish, add or revise tests just to continue iteration, or pursue improvements after all material defects are resolved.
