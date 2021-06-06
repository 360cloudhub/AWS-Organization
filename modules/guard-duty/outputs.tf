output "admin_detector_id" {
  value = concat(aws_guardduty_detector.admin.*.id, [""])[0]
  description = "Identifier Admin Detector"
}