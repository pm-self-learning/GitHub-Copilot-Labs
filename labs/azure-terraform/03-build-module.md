# Lab 3 - Generate the Azure Terraform module

**Agent Mode | 10 minutes | Prerequisite: Approved Lab 2 plan**

## Objective

Use Agent Mode to implement multiple related files while retaining the platform
standards established in Lab 1.

## Steps

1. Continue the planning conversation, approve the design, and select **Agent**.
2. Submit the following prompt. Security details are intentionally not repeated.

```text
Implement the approved Azure Storage Terraform module plan.

Create:
- modules/azure-storage/main.tf
- modules/azure-storage/variables.tf
- modules/azure-storage/outputs.tf
- examples/basic/main.tf
- README.md

Follow our custom instructions. Use secure defaults and configurable inputs.
Ensure the example uses an existing Resource Group. Explain the module inputs,
outputs, local validation commands, and workshop limitations in README.md.
Use AzureRM ~> 4.50.0 consistently and Terraform >= 1.9, < 2.0.

Format the Terraform code. Do not deploy any Azure resources.
Do not run terraform plan, apply, or destroy.
```

3. Inspect the diff, rather than accepting the generated result blindly.
4. Ask Copilot to explain which Lab 1 instructions influenced the implementation.

## Acceptance checklist

- The module uses the caller's Resource Group name and location; no new Resource Group.
- Variables have types, descriptions, naming checks, and required-tag checks.
- The example configures AzureRM with `features {}` and calls the local module
  using `source = "../../modules/azure-storage"`.
- Provider version constraints appear in both module and example.
- Storage Account settings explicitly include
  `https_traffic_only_enabled = true`, `min_tls_version = "TLS1_2"`,
  `allow_nested_items_to_be_public = false`, and
  `public_network_access_enabled = false`.
- The container uses `storage_account_id` and `container_access_type = "private"`.
- Outputs include account ID, account name, and primary Blob endpoint, not keys.
- The example supplies non-empty `Environment`, `Owner`, and `Project` tags.

Disabling Shared Key access and preferring Microsoft Entra authorization are
additional hardening choices shown in the reference solution. They do not replace
RBAC or network design. A private endpoint is not created by this workshop.

## Local check

Run in the learner repository root:

```powershell
terraform fmt -check -recursive
```

If formatting fails, ask Agent Mode to format the affected files and rerun the
check. Initialization and schema validation come next.

**Expected output:**

```text
modules/azure-storage/main.tf
modules/azure-storage/variables.tf
modules/azure-storage/outputs.tf
examples/basic/main.tf
README.md
```

**Checkpoint:**

```powershell
git add modules examples README.md
git commit -m "Lab 3: build Azure Storage module"
git branch lab-4-start
```

[Next: Lab 4 - Automate validation](04-validation-pipeline.md)
