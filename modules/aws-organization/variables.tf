variable "region" {
  description = "Name of valid aws region"
  default = "us-east-1"
}
// OU Vars
variable "ou_name" {
  default = ""
  type = string
  description = "The name for the organizational unit"
}

variable "ou_parent_id" {
  default = ""
  type = string
  description = "ID of the parent organizational unit, which may be the root"
}

// Account Vars
variable "account_name" {
  default = ""
  type = string
  description = "A friendly name for the member account."
}

variable "account_email" {
  default = ""
  type = string
  description = "The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account."
}

variable "iam_user_access_to_billing" {
  default = "DENY"
  type = string
  description = "If set to ALLOW, the new account enables IAM users to access account billing information if they have the required permissions. If set to DENY, then only the root user of the new account can access account billing information."
}

variable "account_parent_id" {
  default = ""
  type = string
  description = "Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection."
}

variable "role_name" {
  default = ""
  type = string
  description = "The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account. The Organizations API provides no method for reading this information after account creation, so Terraform cannot perform drift detection on its value and will always show a difference for a configured value after import unless ignore_changes is used."
}

variable "tags" {
  default = {}
  type = map(string)
  description = "Map of tags to assign to the reqsource."
}

variable "policy_name" {
  default = ""
  type = string
  description = "The friendly name to assign to the policy"
}

variable "policy_description" {
  default = ""
  type = string
  description = "A description to assign to the policy"
}

variable "policy_type" {
  default = "SERVICE_CONTROL_POLICY"
  type = string
  description = "The type of policy to create. Currently, the only valid values are SERVICE_CONTROL_POLICY (SCP) and TAG_POLICY. Defaults to SERVICE_CONTROL_POLICY"
}

variable "policy_content" {
  description = "The policy content to add to the new policy. For example, if you create a [service control policy (SCP)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html), this string must be JSON text that specifies the permissions that admins in attached accounts can delegate to their users, groups, and roles. For more information about the SCP syntax, see the [Service Control Policy Syntax documentation](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_scp-syntax.html) and for more information on the Tag Policy syntax, see the [Tag Policy Syntax documentation.](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_example-tag-policies.html)"
  type = string
  default = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "*",
    "Resource": "*"
  }
}
CONTENT
}

variable "policy_id" {
  default = ""
  type = string
  description = "The unique identifier (ID) of the policy that you want to attach to the target"
}

variable "target_id" {
  type = any
  default = []
  description = "The unique identifier (ID) of the root, organizational unit, or account number that you want to attach the policy to"
}