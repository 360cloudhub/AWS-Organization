resource "aws_guardduty_detector" "admin" {
  count = length(var.admin_account_id) > 0 ? 1 : 0

  enable = true
  provider = aws.admin
}

resource "aws_guardduty_organization_admin_account" "org_admin" {
  count = length(var.admin_account_id) > 0 ? 1 : 0

  #provider = aws.org_admin
  admin_account_id = var.admin_account_id
  depends_on = [
    aws_guardduty_detector.admin
  ]
}


resource "aws_guardduty_organization_configuration" "admin" {
  count = length(var.admin_account_id) > 0 ? 1 : 0

  provider = aws.admin
  auto_enable = true
  detector_id = aws_guardduty_detector.admin[0].id
  depends_on = [
    aws_guardduty_organization_admin_account.org_admin
  ]
}

resource "aws_guardduty_detector" "member" {
  provider = aws.member

  count = length(var.member_account_id) > 0 ? 1 : 0
  enable = true
}

resource "aws_guardduty_member" "member" {
  provider = aws.admin

  count = length(var.member_account_id) > 0 ? 1 : 0
  account_id         = var.member_account_id
  detector_id        = length(var.admin_detector_id) > 0 ? var.admin_detector_id : aws_guardduty_detector.admin[0].id
  email              = var.email_id
  invite             = true
  invitation_message = "please accept guardduty invitation"

  depends_on = [
    aws_guardduty_detector.member
  ]
}
