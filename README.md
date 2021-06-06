## Getting Started

### Setting up AWS Profile
1. Setup Default AWS profile pointing to AWS organization admin account
2. Setup an AWS profile for GuardDuty Admin
3. Setup an AWS profile for GuardDuty member account

Ref: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

### Steps to run terraform
1. Run ``terraform init`` to initialize the module.
2. You can now run ``terraform plan`` to see how it will work.
3. Run ``terraform apply`` to create resources

