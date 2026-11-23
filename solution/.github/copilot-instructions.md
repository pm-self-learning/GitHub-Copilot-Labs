# Azure Terraform platform standards

- Use `hashicorp/azurerm` constrained to `~> 4.50.0` and Terraform `>= 1.9, < 2.0`
  for this workshop. Review provider changes before upgrading.
- Require HTTPS-only Storage Accounts and minimum TLS 1.2.
- Explicitly disable account-level anonymous Blob access and set each container's
  access type to `private`. Do not expose options that weaken these controls.
- Disable public network access. Private endpoints and DNS are outside this demo;
  document that it does not supply a usable private network path.
- Require non-empty, case-sensitive `Environment`, `Owner`, and `Project` tags on
  taggable resources. Validate the module input; do not silently invent values.
  Blob containers do not expose Azure resource tags through this resource.
- Use `main.tf`, `variables.tf`, and `outputs.tf` for reusable modules.
- Declare typed, described inputs and described, non-secret outputs. Validate
  Storage Account and container naming rules. Global uniqueness needs Azure.
- Accept the existing Resource Group name and location; do not create or look up
  a Resource Group in the basic example.
- Configure providers only in the calling root module. Declare provider
  requirements in both the reusable module and example.
- Use `storage_account_id` for the container with this provider version.
- Prefer Microsoft Entra authorization and disable Shared Key access. Document
  that real deployment/access requires deliberate RBAC and connectivity design.
- Follow Terraform best practices: readable names, explicit dependencies through
  references, version constraints, input validation, and minimal scope.
- Only run local `terraform fmt`, `terraform init -backend=false -input=false`,
  and `terraform validate` checks in this workshop. Never run `terraform plan`,
  `apply`, `destroy`, or Azure deployment/sign-in commands.
- Never commit credentials, account keys, state, saved plans, or `.terraform`
  directories. Retain generated provider lock files.
- Document assumptions, inputs, outputs, and local checks. Do not equate static
  validation with security compliance or a successful deployment.

This educational module uses direct resources so learners can inspect their
settings. For production, evaluate approved Azure Verified Modules first.
