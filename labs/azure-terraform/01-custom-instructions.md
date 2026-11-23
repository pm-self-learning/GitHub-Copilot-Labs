# Lab 1 - Define Azure Terraform standards

Feature: **Custom Instructions**

## Objective

Make platform standards available to Copilot across subsequent tasks, rather than
repeating them in every prompt.

## Steps

1. Open this repo in VS Code and open `Copilot Chat`.
2. Select **Agent** mode and submit the prompt below.


      ```text
      Create .github/copilot-instructions.md for the repository.
      
      Define these standards:
      - Use hashicorp/azurerm with a constrained provider version. For this workshop
        use ~> 4.50.0 and Terraform >= 1.9, < 2.0.
      - Require HTTPS-only Storage Accounts and minimum TLS 1.2.
      - Disable anonymous public Blob access at the account level and explicitly
        set each Blob container's access type to private.
      - Disable public network access. Explain that private endpoints and DNS are
        out of scope, so this demo does not provide a usable private network path.
      - Require non-empty, case-sensitive Environment, Owner, and Project tags on
        taggable resources. Do not invent a tags property on Blob containers.
      - Use main.tf, variables.tf, and outputs.tf for reusable modules.
      - Declare typed, described inputs, validate Azure resource names and required
        tags, and provide described outputs without secrets or account keys.
      - Accept an existing Resource Group name; do not create a Resource Group.
      - Keep provider configuration in the root example, not in the child module.
      - Follow Terraform best practices and document assumptions and limitations.
      - Only run local fmt, init -backend=false, and validate checks in this workshop.
        Never run terraform plan, apply, destroy, or Azure deployment commands.
      - Never store secrets or Terraform state in source control.
      
      Create only the instructions file. Do not create Terraform resources yet.
      ```
3. Review the generated file and proposed commands before accepting changes.
4. Save the file, `.github/copilot-instructions.md` with accepted changes in the repo.
   
## Demonstrate and check

Open `.github/copilot-instructions.md`. Confirm all three mandatory tags and
the no-deployment rule are explicit. 

Ask:

```text
Summarize the repository instructions that will guide later Terraform tasks.
Do not change any files.
```

Inspect Copilot's instruction/context references where available. Start a **new
chat** for Lab 2: the standards live in the repository, not just this conversation.
Instructions guide the model; they are not an enforcement mechanism.

**Expected output:** `.github/copilot-instructions.md`; no Terraform files.


[Next: Lab 2 - Plan the module](02-plan-module.md)
