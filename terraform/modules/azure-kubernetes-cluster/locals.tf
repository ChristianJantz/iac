locals {
  # Abstract if auto_scaler_profile_scale_down_delay_after_delete is not set or null we should use the scan_interval.
  auto_scaler_profile_scale_down_delay_after_delete = var.auto_scaler_profile_scale_down_delay_after_delete == null ? var.auto_scaler_profile_scan_interval : var.auto_scaler_profile_scale_down_delay_after_delete
}