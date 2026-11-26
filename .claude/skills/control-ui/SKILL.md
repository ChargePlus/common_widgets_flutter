---
name: control-ui
description: "pstack's control-ui step (Shipping step 1, Feature step 5) in common_widgets_flutter (cursor-team-kit's control-ui does not exist in Claude Code): pump and drive the changed widgets the way the apps use them, compare base and head images, and give PASS, PASS+NOTES or FAIL. Runs the visual check and the independent-verdict procedure in .claude/extensions/review/gates.md. Use when a pstack playbook says control-ui, or for the Independent verdict line of the PR's Review gates section."
---

# control-ui: the independent verdict for a widget

pstack's Shipping step 1 and Feature step 5 call `control-ui`. In this
repo it is the **Independent verdict** gate, with the **Visual check**'s
images for anything that renders. Both procedures are in
`.claude/extensions/review/gates.md` (*Visual check*, *Independent
verdict*, *Re-verdicts*): read them and follow them. This skill adds
nothing to them. A diff where nothing renders differently (a model, a
dependency range, `.claude/`, `.github/`) uses the `control-cli` skill.

1. **Who.** A fresh agent that did not write the code. The author never
   gives its own verdict.
2. **The run.** The scratch consumer: a widget test in the scratchpad that
   depends on this checkout by path, pumps the changed widget the way the
   call sites from Consumer impact use it (a `MaterialApp` with a
   consumer-like theme, their parent widgets, a `GoRouter` where they have
   one) and drives it, at the merge base and at the head. Add the visual
   check's goldens across the matrix the diff reaches. First ask whether
   the run can tell fixed from broken; if it cannot, the verdict is
   `PASS+NOTES (partial: <why>)` at best.
3. **What it cannot run.** A behavior that only shows on a device, in a
   browser or inside one app's screen: list it on the
   **Verification-blocked** line, never as clean.
4. **The verdict.** Post `PASS`, `PASS+NOTES` or `FAIL` as a PR comment
   with the full 40-character head SHA it covers, the quoted difference
   and the before and after images, then put the same on the PR body's
   Independent verdict line: `PASS · <comment link> · covers <sha>`. A
   newer head needs a re-verdict (gates.md, *Re-verdicts*), or the Review
   gates check stays red.

Nothing from the scratch consumer is committed, goldens included. This
repo is public: no screenshot taken from an app, and no customer data.
