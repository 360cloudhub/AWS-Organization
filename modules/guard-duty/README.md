# terraform-aws-guardduty

> **A Terraform module for creating and managing AWS Guard Duty resources like Guard Duty Administrator, Detector, Member Account**


## Getting Started

#### Guard Duty Administrator Example

This example creates a Guard Duty Administrator 
````
module "gd_admin" {
  source = "./modules/guard-duty"

  admin_account_id = "123456"
  guardduty_admin_aws_profile_name = "admin"
  guardduty_member_aws_profile_name = "member"
  region = "us-east-1"
}
````

#### Guard Duty Administrator Example
This example creates an Guard Duty member account
```
module "gd_member" {
  source = "./modules/guard-duty"

  member_account_id = "45679"
  admin_detector_id = module.gd_admin.admin_detector_id
  guardduty_admin_aws_profile_name = "admin"
  guardduty_member_aws_profile_name = "member"
  email_id = "abc@abc.com"
  region = "us-east-1"
}
```

<!--- BEGIN_TF_DOCS --->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| region | The AWS region to deploy Guard Duty. | `string` | `""` | yes |
| guardduty\_admin\_aws\_profile\_name | AWS profile name. Used to deploy Guard duty Admin resources| `string` | `""` | yes |
| guardduty\member\_aws\_profile\_name | AWS profile name. Used to deploy Guard duty member resources. | `string` | `""` | yes |
| admin\_account\_id | AWS Account ID of Admin AWS account | `string` | `""` | no |
| member\_account\_id | AWS Account ID of Member AWS account | `string` | `""` | no |
| email\_id | Email ID of Member Account | `string` | `""` | no |
| admin\_detector\_id | Detector ID of Admin Account | `string` | `""` | no |
|

## Outputs

| Name | Description |
|------|-------------|
| admin\_detector\_id | Detector ID of Admin detector |
|
<!--- END_TF_DOCS --->
