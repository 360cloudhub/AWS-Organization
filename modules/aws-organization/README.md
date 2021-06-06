## Getting Started

#### Organization Example

This example creates a tagging policy and assigns it to multiple targets. 
````
module "tagging_rules_1" {
  source = "./modules/aws-organization"

  policy_name = "tagging-rules"
  policy_description = "Testing tagging policy"

  policy_type = "TAG_POLICY"

  policy_content = <<CONTENT
{
    "tags": {
        "CostCenter": {
            "tag_key": {
                "@@assign": "CostCenter"
            }
        }
    }
}
CONTENT

  target_id = ["r-dgk7", module.development_ou.ou_id]

}
````

#### Other Examples
This example creates an OU named ou_1 and attach to given parent id
```
module "org" {
  source = "./modules/aws-organization"

  ou_name = "ou_1"
  ou_parent_id = "r-0000"
}
```

This example creates an OU named ou_2 and attach to root organization
```
module "org_2" {
  source = "./modules/aws-organization"

  ou_name = "ou_2"
}
```

This example creates an OU named ou_3 and attach it under ou_2
```
module "org_3" {
  source = "./modules/aws-organization"

  ou_name = "ou_3"
  ou_parent_id = module.org_2.ou_id
}
```

This example creates an scp policy
```
module "scp_1" {
  source = "./modules/aws-organization"

  policy_name = "scp_policy_all"
  policy_description = "A description of the policy"
  policy_type = "SERVICE_CONTROL_POLICY"

  policy_content = <<CONTENT
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
```
This example Attaches the scp policy
```
module "attach_policy" {
  source = "./modules/aws-organization"

  policy_id = module.scp_1.policy_id
  target_id = module.org_3.ou_id
}
````

This example Creates AWS organization Account
```
module "attach_policy" {
  source = "./modules/aws-organization"

  account_name = "dev1"
  account_email = "dev@example.com"
  iam_user_access_to_billing = "ALLOW"
  account_parent_id = "ou-1234" # Remove this parameter to attach account to root
}
````

<!--- BEGIN_TF_DOCS --->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account\_email | The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account. | `string` | `""` | no |
| account\_name | A friendly name for the member account. | `string` | `""` | no |
| account\_parent\_id | Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection. | `string` | `""` | no |
| ou\_name | The name for the organizational unit | `string` | `""` | no |
| ou\_parent\_id | ID of the parent organizational unit, which may be the root | `string` | `""` | no |
| policy\_content | The policy content to add to the new policy. For example, if you create a [service control policy (SCP)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html), this string must be JSON text that specifies the permissions that admins in attached accounts can delegate to their users, groups, and roles. For more information about the SCP syntax, see the [Service Control Policy Syntax documentation](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_scp-syntax.html) and for more information on the Tag Policy syntax, see the [Tag Policy Syntax documentation.](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_example-tag-policies.html) | `string` | `"{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": {\n    \"Effect\": \"Allow\",\n    \"Action\": \"*\",\n    \"Resource\": \"*\"\n  }\n}\n"` | no |
| policy\_description | A description to assign to the policy | `string` | `""` | no |
| policy\_id | The unique identifier (ID) of the policy that you want to attach to the target | `string` | `""` | no |
| policy\_name | The friendly name to assign to the policy | `string` | `""` | no |
| policy\_type | The type of policy to create. Currently, the only valid values are SERVICE\_CONTROL\_POLICY (SCP) and TAG\_POLICY. Defaults to SERVICE\_CONTROL\_POLICY | `string` | `"SERVICE_CONTROL_POLICY"` | no |
| role\_name | The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account. The Organizations API provides no method for reading this information after account creation, so Terraform cannot perform drift detection on its value and will always show a difference for a configured value after import unless ignore\_changes is used. | `string` | `""` | no |
| tags | Map of tags to assign to the reqsource. | `map(string)` | `{}` | no |
| target\_id | The unique identifier (ID) of the root, organizational unit, or account number that you want to attach the policy to | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| account\_arn | ARN of the organization account |
| account\_id | Identifier of the organization account |
| master\_account\_arn | ARN of the master account |
| master\_account\_email | Email of the master account |
| master\_account\_id | ID of the master account |
| non\_master\_accounts | List of organization accounts excluding the master account |
| org\_accounts | List of organization accounts including the master account |
| org\_arn | ARN of the organization |
| org\_id | ID of the organization |
| ou\_arn | ARN of the organizational unit |
| ou\_id | Identifier of the organization unit |
| policy\_arn | ARN of the organization policy |
| policy\_id | Identifier of the organization policy |
| roots | List of organization roots |
<!--- END_TF_DOCS --->
