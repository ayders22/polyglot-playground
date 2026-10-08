# Repository agent guidance

## Clarification and correctness

- If a requirement, intent, or implementation detail is unclear, ask for clarification before proceeding.
- Do not assume missing behavior, APIs, constraints, or user preferences.
- When ambiguity exists, prefer a targeted question over guessing.
- Only proceed once the agent has enough information to make a correct, well-scoped change.

## Token efficiency and focused work

- Optimize for signal, not verbosity: prefer the shortest response that still preserves correctness, clarity, and actionability.
- Start with the smallest likely search and the narrowest relevant read; avoid broad exploration unless necessary.
- Read only the exact file ranges needed to answer the question or patch the bug.
- Batch related reads and edits together instead of doing many tiny, repetitive steps.
- Avoid speculative or redundant work: do not guess, do not re-read the same file repeatedly, and do not explore unrelated files without a clear reason.
- Prefer targeted clarifying questions over broad, low-value exploration when the requirement is ambiguous.
- Reuse existing patterns in the codebase before inventing new abstractions or refactors.
- Keep plans and summaries concise: use bullet points, clear steps, and direct next actions.
- Prefer surgical fixes over broad rewrites; do not make unrelated cleanups.
- Validate with the smallest relevant command or test that checks the changed behavior.
- If a decision depends on missing facts, ask a precise question instead of assuming.
- Keep final answers concise, structured, and action-oriented; include only the information needed to move the task forward.
