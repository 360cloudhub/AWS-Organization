variable "region" {
  description = "Valid AWS Region"
}

variable "guardduty_admin_aws_profile_name" {
  description = "Name of AWS Profile for Admin Account"
}

variable "guardduty_member_aws_profile_name" {
  description = "Name of AWS Profile for Member Account"
}

variable "admin_account_id" {
  description = "AWS Account ID for Guard Duty Administration"
  default = ""
}

variable "member_account_id" {
  description = "AWS Account ID for Guard Duty Member"
  default = ""
}

variable "email_id" {
  description = "Email ID of memeber account"
  default = ""
}

variable "admin_detector_id" {
  description = "Detector ID of Guard Duty Admin"
  default = ""
}