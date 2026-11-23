# Azure Storage module - workshop reference solution

This directory is the completed answer for the [five labs](../README.md).
Copy its contents, including `.github` and `.gitignore`, into a separate learner
repository when recovering a demo. Its workflow and skill are deliberately nested
and are not active repository-root customizations in this workshop.

## Design

`modules/azure-storage` creates one Standard LRS StorageV2 account and one private
Blob container using AzureRM `~> 4.50.0`. Terraform must be `>= 1.9, < 2.0`.
The basic root example configures the provider and calls the local module. It
uses placeholder names and does not create or look up a Resource Group.

The account enforces HTTPS, TLS 1.2, disabled anonymous Blob access, disabled
public network access, and disabled Shared Key access. The container explicitly
uses private access. Security controls are not caller-configurable bypasses.

This uses direct resources for teaching; evaluate the
[Azure Verified Storage Account Module](https://registry.terraform.io/modules/Azure/avm-res-storage-storageaccount/azurerm/latest)
and organizational standards before production adoption.

## Inputs

All inputs are required.

| Name | Type | Constraints |
| --- | --- | --- |
| `name` | string | 3-24 lowercase letters/digits; global uniqueness not checked offline |
| `resource_group_name` | string | Non-empty existing Resource Group name |
| `location` | string | Non-empty Azure region |
| `container_name` | string | 3-63 lowercase letters/digits/hyphens; alphanumeric ends; no consecutive hyphens |
| `tags` | map(string) | Non-empty, case-sensitive `Environment`, `Owner`, `Project`; additional tags allowed |

Tags are applied to the Storage Account. The container resource does not support
Azure resource tags.

## Outputs

The module and example expose `storage_account_id`, `storage_account_name`, and
`primary_blob_endpoint`. No keys, connection strings, or secrets are exported.

See [examples/basic/main.tf](examples/basic/main.tf) for complete usage.

## Credential-free checks

Run these commands from this directory (or the learner repository root after copying):

```powershell
terraform fmt -check -recursive
terraform -chdir=modules/azure-storage init -backend=false -input=false
terraform -chdir=modules/azure-storage validate -no-color
terraform -chdir=examples/basic init -backend=false -input=false
terraform -chdir=examples/basic validate -no-color
```

Stop and resolve failures before proceeding. Initialization needs internet access
for provider installation and writes local metadata. Keep lock files in git;
do not commit `.terraform` directories or state.

The reference lock files include Windows and Linux package checksums for local
and GitHub-hosted CI use. The provider constraint intentionally stays in the
4.50 patch series for reproducible teaching; upgrades are a separate review.
The workflow uses Terraform 1.11.4 and readable Actions release tags. Pin reviewed
Actions commit SHAs where required by organizational policy.

## Limits

Do not run `plan`, `apply`, or `destroy` in this workshop. No Azure credentials
or subscription are needed for the documented checks. Validation does not verify
global name availability, Resource Group existence, actual access, every caller
input, or deployment readiness.

**A private container is not a private endpoint.** Public network access is
disabled, but private endpoints, private DNS, role assignments, deployment
identity, remote state, and monitoring are not supplied. The endpoint output
does not imply reachability. Shared Key is disabled and the example opts into
Microsoft Entra storage authentication; real deployment and use require a
separately reviewed identity/network design and provider-operation compatibility.
Do not treat this example as a complete production platform.

The nested `.github/skills/azure-terraform-review/SKILL.md` packages review guidance,
not deterministic policy enforcement. The nested workflow becomes active only
when copied to `.github/workflows/terraform-validate.yml` at a GitHub repository root.
