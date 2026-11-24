# Lab 3 - Generate the Azure Terraform module

Feature: **Agent Mode**

## Objective

Use Agent Mode to implement multiple related files while retaining the platform
standards established in Lab 1.

## Steps

1. In Copilot chat, in the same chat from previous lab, select **Interactive** Agent mode.
2. Submit the following prompt.
   
```text
Implement the approved Azure Storage Terraform module plan.

Under a 'solution' folder, create the following structure:

Create:
- modules/azure-storage/main.tf
- modules/azure-storage/variables.tf
- modules/azure-storage/outputs.tf
- examples/basic/main.tf
- README.md

Follow the custom instructions. Use secure defaults and configurable inputs.
Ensure the example uses an existing Resource Group. Explain the module inputs,
outputs, local validation commands, and workshop limitations in README.md.
Use AzureRM ~> 4.50.0 consistently and Terraform >= 1.9, < 2.0.

DO NOT run any shell commands.
Do NOT deploy any Azure resources.
Do NOT run terraform plan, apply, or destroy.
```

3. Inspect the files generated.
4. Ask Copilot to explain which Lab 1 instructions influenced the implementation.
5. Save the files.

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
additional hardening choices to consider. They do not replace
RBAC or network design. A private endpoint is not created by this workshop.

[Next: Lab 4 - Review Skill](04-review-skill.md)
