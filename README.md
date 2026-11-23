# GitHub Copilot Workshop

Hands-on workshops for building repeatable engineering workflows with GitHub Copilot.

## Scenario and outcomes

A platform team wants developers to provision Azure Storage through a standard,
secure Terraform module instead of starting from scratch. Through these labs, build
a module for one Storage Account and one private Blob container in an **existing**
Resource Group.

You will produce shared Copilot standards, an infrastructure plan, a reusable
module, a credential-free validation workflow, and a repeatable review skill.
These are authoring and validation exercises, not a deployment tutorial.

| Lab | Capability | 
| --- | --- |
| [1. Define standards](01-custom-instructions.md) | Custom Instructions | 
| [2. Plan the module](02-plan-module.md) | Plan Mode | 
| [3. Build the module](03-build-module.md) | Agent Mode | 
| [4. Validate in CI](04-validation-pipeline.md) | Agent Mode | 
| [5. Package a review workflow](05-review-skill.md) | Agent Skills | 

## Pre-requisites

- Install current VS Code, Git, and Terraform CLI 1.9 or later (below 2.0).

## Azure Terraform platform engineering labs

Build a reusable Azure Storage module using repository instructions, Plan Mode,
Agent Mode, GitHub Actions, and an Agent Skill.

| Lab | Capability |
| --- | --- | 
| [1. Define Azure Terraform standards](labs/azure-terraform/01-custom-instructions.md) | Custom Instructions |
| [2. Design the infrastructure](labs/azure-terraform/02-plan-module.md) | Plan Mode | 
| [3. Build the Terraform module](labs/azure-terraform/03-build-module.md) | Agent Mode | 
| [4. Automate validation](labs/azure-terraform/04-validation-pipeline.md) | Agent Mode and GitHub Actions | 
| [5. Create and use a review skill](labs/azure-terraform/05-review-skill.md) | Agent Skills | 

