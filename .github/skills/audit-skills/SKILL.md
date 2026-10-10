---
name: audit-skills
description: "Audit agent skills for clarity, simplicity, consistency, completeness, and actionable instructions. With no target specified, audit all skills under .github/skills except audit-skills itself. Use when reviewing or tightening SKILL.md files for ambiguity, duplication, inconsistent structure, or verbose AI-style prose."
---

# Audit Agent Skills

Review the requested skills against the criteria below. If the user gives no target, audit every `SKILL.md` under `.github/skills`, excluding `.github/skills/audit-skills/SKILL.md`. Include this skill only when the user explicitly asks to audit it.

## Audit Criteria

- **Clear:** Each instruction identifies its action and, when relevant, the triggering condition and expected outcome. Flag wording that permits conflicting actions or leaves a required choice unspecified.
- **Concise:** Keep necessary constraints; remove repeated, irrelevant, ornamental, or generic AI-style wording.
- **Consistent:** Check each skill internally and compare the requested skills with one another for consistent language and voice, grammar, organization, section names and order, instruction formats, terminology, and wording. Flag AI-like slop concretely, such as generic filler, canned phrases, repeated points, ornamental transitions, or needless meta-commentary. Do not require identical structures where the skills' different purposes justify different sections or detail.
- **Complete:** Confirm the skill identifies when it applies and gives enough ordered steps to achieve its stated purpose, including important stop or error conditions.
- **Actionable:** Prefer observable requirements over subjective goals. Replace vague terms with explicit criteria or flag them for clarification.

Do not remove useful safeguards or details merely to shorten a skill. Do not invent behavior, broaden scope, or rewrite content that has no actionable issue. Treat wording as a defect only when it creates ambiguity, redundancy, irrelevance, or unnecessary length.

## Procedure

1. Use the skills named by the user as the audit targets. If none are named, find and audit every `SKILL.md` under `.github/skills`, excluding this skill. If a requested target cannot be identified or accessed, ask one focused question before auditing.
2. Read each target `SKILL.md`. For multi-skill audits, compare them as a set; inspect referenced resources only when needed to verify an instruction or detect duplication.
3. Record only concrete issues. For each, cite the file and quote or locate the relevant text; explain the impact and give a concise correction.
4. Report results by skill. A material defect changes intended behavior, leaves a required step or decision unspecified, creates conflicting instructions, or prevents the skill from being invoked or completed. Separate these defects from optional wording improvements. If none remain, say the skill passes.
5. Do not edit skills unless the user asks for fixes. When asked, make the smallest complete changes and preserve intended behavior.
6. After edits, verify the frontmatter, resource links, and affected instructions once. Report any unresolved issue; do not continue polishing already-satisfied criteria.

## Stop Rule

Complete one audit pass. If fixes are requested, make one revision pass and one verification pass, then stop. Do not repeat audits for subjective polish, add or revise tests just to continue iteration, or pursue improvements after all material defects are resolved.
