# Lab 4 - Generate a Terraform validation pipeline

**Agent Mode | 10 minutes | Prerequisite: Lab 3**

## Objective

Validate both the child module and root example on pull requests without Azure
credentials or deployment commands.

## Steps

Submit in **Agent** mode:

```text
Create .github/workflows/terraform-validate.yml.

Requirements:
- Trigger on pull_request; use read-only contents permission.
- Check out the code and install Terraform 1.11.4.
- Run terraform fmt -check -recursive from the repository root.
- Use a matrix to validate modules/azure-storage and examples/basic separately.
- In each directory, run terraform init -backend=false -input=false,
  followed by terraform validate -no-color.
- Fail the workflow when checks fail; do not use continue-on-error.
- Do not run terraform plan, apply, destroy, or Azure login.
- Do not require Azure credentials, secrets, or an Azure subscription.

Run the equivalent local checks if Terraform is installed. Fix any errors and
report failures honestly. Keep generated .terraform directories out of git;
retain provider lock files. Do not change our security requirements.
```

Review the workflow. It must use `pull_request`, not `pull_request_target`, and
must not reference Azure secrets or grant `id-token: write`.

## Run locally

From the learner repository root, run each command and stop to resolve any failure:

```powershell
terraform fmt -check -recursive
terraform -chdir=modules/azure-storage init -backend=false -input=false
terraform -chdir=modules/azure-storage validate -no-color
terraform -chdir=examples/basic init -backend=false -input=false
terraform -chdir=examples/basic validate -no-color
```

Initialization downloads the provider and writes local metadata/lock files.
`-backend=false` disables backend initialization; it is **not** a general promise
of offline execution. This example has no remote backend or external module.
`validate` checks syntax and provider-schema consistency without querying Azure.
It does not prove that security policy, every caller input, or deployment will pass.

## Demonstrate a failure and recovery

1. In the module's Storage Account resource, manually add
   `workshop_invalid_argument = true`. Save the file.
2. Run the module's `terraform validate -no-color`; expect an unsupported-argument
   error. This is a safe, deterministic schema error, not weakened security.
3. Ask Agent Mode:

```text
Identify the Terraform validation error, explain its cause, and fix it without
weakening our platform standards. Rerun formatting and validation for both the
module and example. Do not run plan, apply, or destroy.
```

4. Confirm the temporary argument is removed and both directories pass.

**Expected output:** `.github/workflows/terraform-validate.yml`, two initialized
and valid configurations, and a visible failure-to-fix demonstration.

**Checkpoint:**

```powershell
git add .github/workflows modules examples
git commit -m "Lab 4: add Terraform validation workflow"
git branch lab-5-start
```

To see CI run, push the learner repository to GitHub and open a PR against its
default branch. Ensure the default branch has an initial commit first. A local
validation result is not evidence that GitHub Actions has run.

[Next: Lab 5 - Build a review skill](05-review-skill.md)
