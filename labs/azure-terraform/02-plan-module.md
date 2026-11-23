# Lab 2 - Plan an Azure Storage Terraform module

Feature: **Plan Mode**

## Objective

Review an infrastructure design before permitting code generation.

## Steps

1. In a new Copilot chat, select **Plan** mode.
2. Submit the prompt and inspect the proposed resources, contract, and file tree.

```text
Plan a reusable Terraform module that provisions one Azure Storage Account and
one private Blob container.

Requirements:
- Use an existing Azure Resource Group; accept its name and location as inputs.
- Accept Storage Account name, container name, and tags as configurable inputs.
- Follow the repository custom instructions.
- Expose Storage Account ID, name, and primary Blob endpoint as outputs.
- Include a basic usage example with placeholder values, without Azure lookups.
- Explain the required resources, input validations, outputs, provider
  constraints, provider configuration, files, and credential-free checks.
- Explain the difference between private container access and private networking.

Do not implement anything yet. Do not run Terraform or contact Azure.
```

3. Challenge the design with this follow-up:

```text
Explain exactly how the design prevents anonymous Blob access, requires HTTPS
and TLS 1.2, and handles public network access.

How will you validate Storage Account names (3-24 lowercase letters/digits)
and container names (3-63 lowercase letters/digits/hyphens, alphanumeric ends,
no consecutive hyphens)? What cannot be checked offline?

```

## Acceptance checkpoint

The plan should identify `azurerm_storage_account` and
`azurerm_storage_container`, the three module files, a basic root example, and
documentation. It should not create a Resource Group or require an Azure data
source for the example.

Look for account-level anonymous access disabled **and** private container access.
Names must be checked locally, but global account-name availability, Resource
Group existence, permissions, actual network access, and deployment success
cannot be proven by these labs.

Review the plan in chat and approve it when it looks correct.
Do not select an implementation action during this lab. Keep the conversation
for the next lab; if switching chats, paste the approved plan into the new chat.

**Expected output:** An implementation plan in chat; no source changes.
An optional local copy of the approved plan can be saved if needed. There is no separate code checkpoint to commit for this lab.

[Next: Lab 3 - Build the module](03-build-module.md)
