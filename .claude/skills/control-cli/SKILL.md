---
name: control-cli
description: "pstack's control-cli step (Shipping step 1, Feature step 5) in common_widgets_flutter (cursor-team-kit's control-cli does not exist in Claude Code), for a change where nothing renders differently: a model, a dependency range, agent tooling or CI. Runs the independent-verdict procedure in .claude/extensions/review/gates.md and gives PASS, PASS+NOTES or FAIL. Use when a pstack playbook says control-cli; a change that renders goes to control-ui."
---

# control-cli: the independent verdict without a render

pstack's Shipping step 1 and Feature step 5 call `control-ui` or
`control-cli`. In this repo both are the **Independent verdict** gate
(`.claude/extensions/review/gates.md` → *Independent verdict* and
*Re-verdicts*). A change that renders differently goes to the `control-ui`
skill. This one covers the rest; read gates.md and follow it.

1. **Who.** A fresh agent that did not write the code.
2. **The run.** A model or dependency change: a scratch Dart test that
   depends on this checkout by path and uses the changed symbol the way
   the call sites from Consumer impact do (for a model, decode, encode and
   compare it), at the merge base and at the head. Tooling or CI
   (`.claude/`, `.codex/`, `.github/`, `CLAUDE.md`, `AGENTS.md`): run each changed hook, script or
   workflow step the way its caller does, parent against head, as gates.md
   says. First ask whether the run can tell fixed from broken; if it
   cannot, the verdict is `PASS+NOTES (partial: <why>)` at best.
3. **What it cannot run:** the **Verification-blocked** line, never clean.
4. **The verdict.** Post `PASS`, `PASS+NOTES` or `FAIL` as a PR comment
   with the full 40-character head SHA, then put the same on the PR body's
   Independent verdict line: `PASS · <comment link> · covers <sha>`. A
   newer head needs a re-verdict.

Nothing from the scratch run is committed.
