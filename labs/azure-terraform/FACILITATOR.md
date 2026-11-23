# Facilitator guide

## Before the session

Budget **40 minutes of labs**, plus setup, provider downloads, and discussion.
Rehearse with the same VS Code/Copilot configuration participants will use.
Pre-initialize the reference configurations on the demo machine to check internet
access; an empty provider cache can consume much of Lab 4.

Use a separate learner repository opened at its root. Keep the reference solution
outside that workspace so Copilot does not simply reproduce an answer already in
context. Do not copy the workshop's `.git` directory into the learner repository.

The reference workflow is intentionally nested under `solution/.github/workflows`:
it does not run in this workshop repository. Copy it to the learner repository's
root `.github/workflows` only when recovering Lab 4.

## Demo timing and talk track

| Time | Demo | Key point |
| --- | --- | --- |
| 0-5 min | Generate instructions, inspect them, start a new chat | Shared rules persist across tasks |
| 5-10 min | Plan, challenge networking/naming, approve design | Reason before implementation |
| 10-20 min | Generate module and example, inspect diff | Security details need not be repeated |
| 20-30 min | Generate CI, introduce an unsupported argument, repair | Fast feedback without Azure credentials |
| 30-40 min | Create skill, remove Owner in example, review and restore | Repeatable review with evidence, not automatic fixes |

Keep security settings visible during Lab 3. Explain that the reference disables
public network access but does not create private endpoints or DNS. Do not call
it production-ready or demonstrate an Azure deployment.

## Optional start branches

The published workshop uses one delivery branch. These optional branches belong
in a **separate rehearsal/learner repository**; they are not required to consume
the lab guides.

| Branch | Contents before starting |
| --- | --- |
| `lab-1-start` | Initial `.gitignore` commit only |
| `lab-2-start` | Lab 1 instructions committed |
| `lab-3-start` | Same files as lab-2-start; approved plan retained separately |
| `lab-4-start` | Lab 3 module, example, and README committed |
| `lab-5-start` | Lab 4 workflow and lock files committed |

Create `lab-1-start` after committing the initial `.gitignore`. The lab guides
create the later checkpoints as work progresses. After Lab 2, also run
`git branch lab-3-start`; the plan is conversational, not a code change.

For recovery, first commit intentional work or stash it with `git stash push -u`.
Switch to a **new attempt branch** from a known checkpoint, for example:

```powershell
git switch -c retry-lab-4 lab-4-start
```

Do not overwrite attendees' changes or use destructive reset commands. Reuse
the saved plan for Lab 3; Git branches do not restore Copilot conversations.
To recover from the solution, copy only the artifacts appropriate to the lab
into the learner repository, including hidden `.github` content when needed.

## Common issues

| Symptom | Response |
| --- | --- |
| Copilot repeats unsafe defaults | Check the workspace root and instruction references; inspect generated code |
| Agent asks to sign in to Azure | Decline; no deployment or plan is needed |
| Provider download fails | Check proxy/network access; report checks as blocked rather than passed |
| Old AzureRM attribute names appear | Use documentation for the constrained provider, not an unrelated version |
| Skill slash command missing | Check frontmatter, workspace location, VS Code version, policy; start a new chat |
| Missing Owner is not a validate error | Require a static review of the example; validate is not policy-as-code |
| Skill changes source files | Reject the edits and reinforce the no-fix instruction |
| CI does not start | Confirm a real PR, enabled Actions, and workflow in the learner repo's root `.github/workflows` |

For production, evaluate Azure Verified Modules, narrowly scoped deployment
identities, private connectivity, RBAC, remote state protections, observability,
and enforced policy checks. Pin Actions to reviewed commit SHAs according to your
organization's policy; the training workflow uses readable release tags.
