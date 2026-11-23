# Lab 4 - Create and use an Azure Terraform review skill

Feature: **Agent Skills**

## Objective

Package a repeatable, read-only review workflow that applies the platform rules.

## Step 1 - Create the skill

In **Agent** mode, submit:

```text
Create a reusable GitHub Copilot Agent Skill named azure-terraform-review at
.github/skills/azure-terraform-review/SKILL.md.

Use standard SKILL.md YAML frontmatter with name and a description that explains
when to use the skill.

The skill must:
1. Inspect relevant Terraform module files, calling examples, and repository
   instructions, not just the module in isolation.
2. Check formatting with terraform fmt -check -recursive.
3. If Terraform is installed, initialize with -backend=false -input=false and
   validate the module and example separately.
4. Review HTTPS-only traffic, minimum TLS 1.2, account-level anonymous Blob
   access restrictions, private container access, and network access controls.
5. Check non-empty Environment, Owner, and Project tags on taggable resources
   and in example inputs. Do not require tags on unsupported resource types.
6. Report severity (High/Medium/Low), file and line, resource or module call,
   explanation, evidence, and recommended fix.
7. Distinguish static findings, issues confirmed by commands, and skipped checks.
   Never invent successful check results.

Never deploy or modify Azure infrastructure. Never run plan, apply, or destroy.
Do not automatically fix issues or modify source files. Explain that init may
write .terraform directories and dependency lock files, so execution is not
strictly filesystem-read-only. If the user forbids all file writes, skip init
and report validation as skipped unless initialization is already available.
Create only the skill file now; do not execute the review yet.
```

## Step 2 - Inspect and invoke

Open the generated `SKILL.md`. Its frontmatter should resemble:

```yaml
---
name: azure-terraform-review
description: Review Azure Terraform modules and examples for formatting, validation, Storage security, and mandatory tags. Use when asked to audit or review Azure Terraform code.
---
```

Confirm the workflow includes the no-fix rule and clearly scopes permitted
metadata writes. In Copilot Chat, type `/`, select the discovered skill, and submit:

```text
/azure-terraform-review
Review modules/azure-storage and its caller in examples/basic.
Check security, formatting, validation, naming, and tagging.
Provide findings and recommendations with evidence.
Do not modify source files. Local Terraform initialization metadata is allowed.
Do not run plan, apply, or destroy.
```

If the slash command is missing, verify the workspace root, frontmatter, and
organization settings, then start a new chat or reload VS Code. Alternatively
ask Copilot to use the `azure-terraform-review` skill by name and reference the
skill file explicitly. Verify that it actually loads; pasting a name alone is
not proof that the skill was used.


## Step 3 - Make the review observable

Manually remove only `Owner` from the `tags` map passed by the module call in
`examples/basic/main.tf`. Do not remove the module's required-tag validation.
Invoke the skill again with the same scope.

The report should identify the missing tag in the **example**, rather than claim
the module's guard is absent. `terraform validate` is not a general evaluator
of caller input policies: the missing-tag observation may be a static finding
even when configuration validation succeeds.


Confirm the skill recommends a fix **without changing files**. Manually restore
`Owner` and rerun the review to show the finding disappear. Do not commit the
intentional defect.

## Wrap-up

| Custom Instructions (Lab 1) | Agent Skill (Lab 4) |
| --- | --- |
| Define how Copilot should write Terraform | Define how Copilot should perform a review |
| Shared platform rules across tasks | Task-specific steps loaded when relevant |
| Require mandatory tags | Inspect callers and report missing tags |

**Key message:** Instructions establish the rules; skills package a repeatable
workflow for checking them. Neither is a deterministic policy engine. For
enforceable controls, use approved policy-as-code checks such Azure Policy alongside human review.

**Expected output:** `.github/skills/azure-terraform-review/SKILL.md` and an
evidence-backed findings report. Save the skill after restoring the example.

