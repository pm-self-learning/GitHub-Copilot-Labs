# Azure Terraform platform engineering labs

## Scenario and outcomes

A platform team wants developers to provision Azure Storage through a standard,
secure Terraform module instead of starting from scratch. Over 40 minutes, build
a module for one Storage Account and one private Blob container in an **existing**
Resource Group.

You will produce shared Copilot standards, an infrastructure plan, a reusable
module, a credential-free validation workflow, and a repeatable review skill.
These are authoring and validation exercises, not a deployment tutorial.

| Lab | Capability | Time |
| --- | --- | --- |
| [1. Define standards](01-custom-instructions.md) | Custom Instructions | 5 min |
| [2. Plan the module](02-plan-module.md) | Plan Mode | 5 min |
| [3. Build the module](03-build-module.md) | Agent Mode | 10 min |
| [4. Validate in CI](04-validation-pipeline.md) | Agent Mode | 10 min |
| [5. Package a review workflow](05-review-skill.md) | Agent Skills | 10 min |

## Prepare before the timer starts

- Install current VS Code, Git, and Terraform CLI 1.9 or later (below 2.0).
- Enable GitHub Copilot and Copilot Chat with access to Plan and Agent modes.
  UI labels and skill availability can vary by VS Code version and organization policy.
- Have internet access to download Terraform providers. To run CI, use a GitHub
  repository with Actions enabled and permission to push a branch/open a PR.
- No Azure sign-in, subscription, CLI, or credentials are needed. Example names
  are placeholders; the Resource Group does not need to exist for validation.
- Use a **separate, empty learner repository** named `azure-terraform-demo`.
  Open that folder as the VS Code workspace root, not this workshop repository.
  This ensures the instructions and skill you create are discovered at the right scope.

Example PowerShell setup in a location of your choosing:

```powershell
New-Item -ItemType Directory azure-terraform-demo
Set-Location azure-terraform-demo
git init
git switch -c workshop
code .
```

In that learner repository, add a `.gitignore` containing:

```gitignore
**/.terraform/*
*.tfstate
*.tfstate.*
*.tfplan
*.tfvars
*.tfvars.json
crash.log
```

Keep `.terraform.lock.hcl` files in version control after initialization. Do not
commit state, credentials, or secrets. Run `terraform version` and `git --version`
to check tools before starting.

## Working agreement

Review every proposed tool call. Allow file edits and the documented local checks;
do not approve `terraform plan`, `apply`, `destroy`, Azure sign-in, or deployment.
Do not grant blanket approval to arbitrary commands. Start a fresh chat after
Lab 1 to demonstrate repository instructions carrying across tasks. Keep the
Lab 2 plan in the conversation used for Lab 3.

The training module uses AzureRM resources directly to make the security settings
visible. In production, first evaluate the
[Azure Verified Storage Account Module](https://registry.terraform.io/modules/Azure/avm-res-storage-storageaccount/azurerm/latest)
and your organization's approved modules. This exercise is not an AVM contribution.

**Private Blob access and private networking are different.** A private container
requires authorization; it does not by itself disable the public endpoint. The
reference solution also disables public network access. Private endpoints, DNS,
RBAC, monitoring, and a deployment identity are deliberately outside these labs.
The result is not a ready-to-deploy, usable private-network architecture.

## Final learner repository

```text
azure-terraform-demo/
|-- .gitignore
|-- .github/
|   |-- copilot-instructions.md
|   |-- workflows/terraform-validate.yml
|   `-- skills/azure-terraform-review/SKILL.md
|-- modules/azure-storage/
|   |-- main.tf
|   |-- variables.tf
|   `-- outputs.tf
|-- examples/basic/main.tf
`-- README.md
```

Initialization also creates provider lock files. The [solution](solution/README.md)
is a recovery aid, not a prerequisite: keep it closed during the first attempt.
For independent demos, use the [facilitator checkpoint procedure](FACILITATOR.md).

## Official references

- [Repository custom instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot)
- [Planning with Copilot in VS Code](https://code.visualstudio.com/docs/copilot/chat/chat-planning)
- [Agent Skills in VS Code](https://code.visualstudio.com/docs/agent-customization/agent-skills)
- [AzureRM Storage Account, version 4.50.0](https://registry.terraform.io/providers/hashicorp/azurerm/4.50.0/docs/resources/storage_account)
- [AzureRM Storage Container, version 4.50.0](https://registry.terraform.io/providers/hashicorp/azurerm/4.50.0/docs/resources/storage_container)
- [Terraform validate](https://developer.hashicorp.com/terraform/cli/commands/validate)
- [Terraform module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
