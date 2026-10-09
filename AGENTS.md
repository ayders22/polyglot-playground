# Repository agent guidance

## 1. Clarify before acting

- If a requirement, intent, or implementation detail is unclear, ask for clarification before proceeding.
- Do not assume missing behavior, APIs, constraints, or user preferences.
- When ambiguity exists, prefer a single targeted question over a guess.
- Proceed only when there is enough information to make the correct, minimal, well-scoped change.

## 2. Work efficiently

- Before each tool call, ask: "What is the minimum evidence needed to proceed?"
- Start with the smallest likely search or symbol lookup; avoid broad exploration unless it is required.
- Read only the exact file ranges needed to answer the question or fix the issue.
- Batch related reads and edits together instead of making many tiny, repetitive steps.
- Do not re-read the same file unnecessarily or explore unrelated files without a clear reason.

## 3. Prefer surgical, high-signal execution

- Reuse existing code patterns before introducing new abstractions or refactors.
- Prefer surgical fixes over broad rewrites or unrelated cleanup.
- Do not perform speculative refactors, broad cleanups, or unrelated improvements while working on a task.
- Once the root cause is identified, patch directly instead of exploring adjacent areas unless validation requires it.
- Validate with the smallest relevant command or test that checks the changed behavior.

## 4. Keep output concise and useful

- Optimize for signal, not verbosity: prefer the shortest response that preserves correctness, clarity, and actionability.
- Keep plans, summaries, and final answers concise, structured, and action-oriented.
- Include only the information needed to move the task forward.
- Prefer direct action over long discussion when the next step is clear.
