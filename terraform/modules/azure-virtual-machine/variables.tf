variable "location" {
  type        = string
  default     = "germanywestcentral"
  description = "Location of the VM Ressources. Default is set to 'germanywestcentral'"

  validation {
    condition     = contains(["germanywestcentral", "germanynorth", "westeurope", "northeurope"], var.location)
    error_message = "The posible locations are 'germanywestcentral', 'germanynorth', 'westeurope' and 'northeurope'"
  }
}
variable "name" {
  type        = string
  description = "(Required) The name of the Virtual Machine. Changing this forces a new resource to be created."
  nullable    = false
}

variable "os_disk" {
  type = object({
    caching                          = string
    storage_account_type             = string
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool, false)
    diff_disk_settings = optional(object({
      option    = string
      placement = optional(string, "CacheDisk")
    }), null)
  })
  description = <<-EOT
  object({
    caching                          = "(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`."
    storage_account_type             = "(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`. Changing this forces a new resource to be created."
    disk_encryption_set_id           = "(Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. Conflicts with `secure_vm_disk_encryption_set_id`. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault"
    disk_size_gb                     = "(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. If specified this must be equal to or larger than the size of the Image the Virtual Machine is based on. When creating a larger disk than exists in the image you'll need to repartition the disk to use the remaining space."
    name                             = "(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created."
    secure_vm_disk_encryption_set_id = "(Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with `disk_encryption_set_id`. Changing this forces a new resource to be created. `secure_vm_disk_encryption_set_id` can only be specified when `security_encryption_type` is set to `DiskWithVMGuestState`."
    security_encryption_type         = "(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are `VMGuestStateOnly` and `DiskWithVMGuestState`. Changing this forces a new resource to be created. `vtpm_enabled` must be set to `true` when `security_encryption_type` is specified. `encryption_at_host_enabled` cannot be set to `true` when `security_encryption_type` is set to `DiskWithVMGuestState`."
    write_accelerator_enabled        = "(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to `false`. This requires that the `storage_account_type` is set to `Premium_LRS` and that `caching` is set to `None`."
    diff_disk_settings               = optional(object({
      option    = "(Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is `Local`. Changing this forces a new resource to be created."
      placement = "(Optional) Specifies where to store the Ephemeral Disk. Possible values are `CacheDisk` and `ResourceDisk`. Defaults to `CacheDisk`. Changing this forces a new resource to be created."
    }), [])
  })
  EOT
  nullable    = false
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which the Virtual Machine should be exist. Changing this forces a new resource to be created."
  nullable    = false
}

variable "size" {
  type        = string
  description = "(Required) The SKU which should be used for this Virtual Machine, such as `Standard_F2`."
  nullable    = false
}

variable "additional_unattend_contents" {
  type = list(object({
    content = string
    setting = string
  }))
  default     = []
  description = <<-EOT
  list(object({
    content = "(Required) The XML formatted content that is added to the unattend.xml file for the specified path and component. Changing this forces a new resource to be created."
    setting = "(Required) The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`. Changing this forces a new resource to be created."
  }))
  EOT
}

variable "admin_password" {
  type        = string
  default     = null
  description = "(Optional) The Password which should be used for the local-administrator on this Virtual Machine Required when using Windows Virtual Machine. Changing this forces a new resource to be created. When an `admin_password` is specified `disable_password_authentication` must be set to `false`. One of either `admin_password` or `admin_ssh_key` must be specified."
  sensitive   = true
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "(Optional) The admin username of the VM that will be deployed."
  nullable    = false
}

variable "allow_extension_operations" {
  type        = bool
  default     = false
  description = "(Optional) Should Extension Operations be allowed on this Virtual Machine? Defaults to `false`."
}

variable "automatic_updates_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created. Defaults to `true`."
}

variable "availability_set_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. Cannot be used along with `new_availability_set`, `new_capacity_reservation_group`, `capacity_reservation_group_id`, `virtual_machine_scale_set_id`, `zone`. Changing this forces a new resource to be created."
}

variable "computer_name" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the `vm_name` field. If the value of the `vm_name` field is not a valid `computer_name`, then you must specify `computer_name`. Changing this forces a new resource to be created."
}

variable "custom_data" {
  type        = string
  default     = null
  description = "(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created."
}

variable "data_disks" {
  type = set(object({
    name                 = string
    storage_account_type = string
    create_option        = string
    attach_setting = object({
      lun                       = number
      caching                   = string
      create_option             = optional(string, "Attach")
      write_accelerator_enabled = optional(bool, false)
    })
    disk_encryption_set_id           = optional(string)
    disk_iops_read_write             = optional(number)
    disk_mbps_read_write             = optional(number)
    disk_iops_read_only              = optional(number)
    disk_mbps_read_only              = optional(number)
    logical_sector_size              = optional(number)
    source_uri                       = optional(string)
    source_resource_id               = optional(string)
    storage_account_id               = optional(string)
    image_reference_id               = optional(string)
    gallery_image_reference_id       = optional(string)
    disk_size_gb                     = optional(number)
    upload_size_bytes                = optional(number)
    network_access_policy            = optional(string)
    disk_access_id                   = optional(string)
    public_network_access_enabled    = optional(bool, true)
    tier                             = optional(string)
    max_shares                       = optional(number)
    trusted_launch_enabled           = optional(bool)
    secure_vm_disk_encryption_set_id = optional(string)
    security_type                    = optional(string)
    hyper_v_generation               = optional(string)
    on_demand_bursting_enabled       = optional(bool)
    encryption_settings = optional(object({
      disk_encryption_key = optional(object({
        secret_url      = string
        source_vault_id = string
      }))
      key_encryption_key = optional(object({
        key_url         = string
        source_vault_id = string
      }))
    }))
  }))
  default     = []
  description = <<-EOT
  set(object({
    name                             = "(Required) Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
    storage_account_type             = "(Required) The type of storage to use for the managed disk. Possible values are `Standard_LRS`, `StandardSSD_ZRS`, `Premium_LRS`, `PremiumV2_LRS`, `Premium_ZRS`, `StandardSSD_LRS` or `UltraSSD_LRS`. Azure Ultra Disk Storage is only available in a region that support availability zones and can only enabled on the following VM series: `ESv3`, `DSv3`, `FSv3`, `LSv2`, `M` and `Mv2`. For more information see the `Azure Ultra Disk Storage` [product documentation](https://docs.microsoft.com/azure/virtual-machines/windows/disks-enable-ultra-ssd)."
    create_option                    = "(Required) The method to use when creating the managed disk. Changing this forces a new resource to be created. Possible values include: `Import`, `Empty`, `Copy`, `FromImage`, `Restore`, `Upload`."
    attach_setting = object({
      lun                       = number
      caching                   = string
      create_option             = optional(string, "Attach")
      write_accelerator_enabled = optional(bool, false)
    })
    disk_encryption_set_id           = "(Optional) The ID of a Disk Encryption Set which should be used to encrypt this Managed Disk. Conflicts with `secure_vm_disk_encryption_set_id`. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault. Disk Encryption Sets are in Public Preview in a limited set of regions"
    disk_iops_read_write             = "(Optional) The number of IOPS allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. One operation can transfer between 4k and 256k bytes."
    disk_mbps_read_write             = "(Optional) The bandwidth allowed for this disk; only settable for UltraSSD disks and PremiumV2 disks. MBps means millions of bytes per second."
    disk_iops_read_only              = "(Optional) The number of IOPS allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. One operation can transfer between 4k and 256k bytes."
    disk_mbps_read_only              = "(Optional) The bandwidth allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks and PremiumV2 disks with shared disk enabled. MBps means millions of bytes per second."
    logical_sector_size              = "(Optional) Logical Sector Size. Possible values are: `512` and `4096`. Changing this forces a new resource to be created. Setting logical sector size is supported only with `UltraSSD_LRS` disks and `PremiumV2_LRS` disks."
    source_uri                       = "(Optional) URI to a valid VHD file to be used when `create_option` is `Import`. Changing this forces a new resource to be created."
    source_resource_id               = "(Optional) The ID of an existing Managed Disk or Snapshot to copy when `create_option` is `Copy` or the recovery point to restore when `create_option` is `Restore`. Changing this forces a new resource to be created."
    storage_account_id               = "(Optional) The ID of the Storage Account where the `source_uri` is located. Required when `create_option` is set to `Import`.  Changing this forces a new resource to be created."
    image_reference_id               = "(Optional) ID of an existing platform/marketplace disk image to copy when `create_option` is `FromImage`. This field cannot be specified if gallery_image_reference_id is specified. Changing this forces a new resource to be created."
    gallery_image_reference_id       = "(Optional) ID of a Gallery Image Version to copy when `create_option` is `FromImage`. This field cannot be specified if image_reference_id is specified. Changing this forces a new resource to be created."
    disk_size_gb                     = "(Optional) (Optional, Required for a new managed disk) Specifies the size of the managed disk to create in gigabytes. If `create_option` is `Copy` or `FromImage`, then the value must be equal to or greater than the source's size. The size can only be increased. In certain conditions the Data Disk size can be updated without shutting down the Virtual Machine, however only a subset of Virtual Machine SKUs/Disk combinations support this. More information can be found [for Linux Virtual Machines](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/expand-disks?tabs=azure-cli%2Cubuntu#expand-without-downtime) and [Windows Virtual Machines](https://learn.microsoft.com/azure/virtual-machines/windows/expand-os-disk#expand-without-downtime) respectively. If No Downtime Resizing is not available, be aware that changing this value is disruptive if the disk is attached to a Virtual Machine. The VM will be shut down and de-allocated as required by Azure to action the change. Terraform will attempt to start the machine again after the update if it was in a `running` state when the apply was started."
    upload_size_bytes                = "(Optional) Specifies the size of the managed disk to create in bytes. Required when `create_option` is `Upload`. The value must be equal to the source disk to be copied in bytes. Source disk size could be calculated with `ls -l` or `wc -c`. More information can be found at [Copy a managed disk](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/disks-upload-vhd-to-managed-disk-cli#copy-a-managed-disk). Changing this forces a new resource to be created."
    network_access_policy            = "(Optional) Policy for accessing the disk via network. Allowed values are `AllowAll`, `AllowPrivate`, and `DenyAll`."
    disk_access_id                   = "(Optional) The ID of the disk access resource for using private endpoints on disks. `disk_access_id` is only supported when `network_access_policy` is set to `AllowPrivate`."
    public_network_access_enabled    = "(Optional) Whether it is allowed to access the disk via public network. Defaults to `true`."
    tier                             = "(Optional) The disk performance tier to use. Possible values are documented [here](https://docs.microsoft.com/azure/virtual-machines/disks-change-performance). This feature is currently supported only for premium SSDs. Changing this value is disruptive if the disk is attached to a Virtual Machine. The VM will be shut down and de-allocated as required by Azure to action the change. Terraform will attempt to start the machine again after the update if it was in a `running` state when the apply was started."
    max_shares                       = "(Optional) The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time."
    trusted_launch_enabled           = "(Optional) Specifies if Trusted Launch is enabled for the Managed Disk. Changing this forces a new resource to be created."
    secure_vm_disk_encryption_set_id = "(Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with `disk_encryption_set_id`. Changing this forces a new resource to be created. `secure_vm_disk_encryption_set_id` can only be specified when `security_type` is set to `ConfidentialVM_DiskEncryptedWithCustomerKey`."
    security_type                    = "(Optional) Security Type of the Managed Disk when it is used for a Confidential VM. Possible values are `ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey`, `ConfidentialVM_DiskEncryptedWithPlatformKey` and `ConfidentialVM_DiskEncryptedWithCustomerKey`. Changing this forces a new resource to be created. `security_type` cannot be specified when `trusted_launch_enabled` is set to true. `secure_vm_disk_encryption_set_id` must be specified when `security_type` is set to `ConfidentialVM_DiskEncryptedWithCustomerKey`."
    hyper_v_generation               = "(Optional) The HyperV Generation of the Disk when the source of an `Import` or `Copy` operation targets a source that contains an operating system. Possible values are `V1` and `V2`. Changing this forces a new resource to be created."
    on_demand_bursting_enabled       = "(Optional) Specifies if On-Demand Bursting is enabled for the Managed Disk. Credit-Based Bursting is enabled by default on all eligible disks. More information on [Credit-Based and On-Demand Bursting can be found in the documentation](https://docs.microsoft.com/azure/virtual-machines/disk-bursting#disk-level-bursting)."
    encryption_settings              = optional(object({
      disk_encryption_key = optional(object({
        secret_url      = "(Required) The URL to the Key Vault Secret used as the Disk Encryption Key. This can be found as `id` on the `azurerm_key_vault_secret` resource."
        source_vault_id = "(Required) The ID of the source Key Vault. This can be found as `id` on the `azurerm_key_vault` resource."
      }))
      key_encryption_key = optional(object({
        key_url         = "(Required) The URL to the Key Vault Key used as the Key Encryption Key. This can be found as `id` on the `azurerm_key_vault_key` resource."
        source_vault_id = "(Required) The ID of the source Key Vault. This can be found as `id` on the `azurerm_key_vault` resource."
      }))
    }))
  }))
  EOT
  nullable    = false

  validation {
    condition = length(var.data_disks) == length(distinct([
      for d in var.data_disks : d.attach_setting.lun
    ]))
    error_message = "`data_disks.attach_setting.lun` must be unique."
  }
}

variable "disable_password_authentication" {
  type        = bool
  default     = true
  description = "(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to `true`. Changing this forces a new resource to be created."
}

variable "edge_zone" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Virtual Machine to be created."
}

variable "encryption_at_host_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
}

variable "eviction_policy" {
  type        = string
  default     = null
  description = "(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are `Deallocate` and `Delete`. Changing this forces a new resource to be created."
}

variable "extensions" {
  type = set(object({
    name                        = string
    publisher                   = string
    type                        = string
    type_handler_version        = string
    auto_upgrade_minor_version  = optional(bool)
    automatic_upgrade_enabled   = optional(bool)
    failure_suppression_enabled = optional(bool, false)
    settings                    = optional(string)
    protected_settings          = optional(string)
    protected_settings_from_key_vault = optional(object({
      secret_url      = string
      source_vault_id = string
    }))
  }))
  # tflint-ignore: terraform_sensitive_variable_no_default
  default     = []
  description = "Argument to create `azurerm_virtual_machine_extension` resource, the argument descriptions could be found at [the document](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension)."
  nullable    = false
  sensitive   = true # Because `protected_settings` is sensitive

  validation {
    condition = length(var.extensions) == length(distinct([
      for e in var.extensions : e.type
    ]))
    error_message = "`type` in `vm_extensions` must be unique."
  }
}

variable "extensions_time_budget" {
  type        = string
  default     = "PT1H30M"
  description = "(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (`PT1H30M`)."
}


variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(set(string))
  })
  default     = null
  description = <<-EOT
  object({
    type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."
    identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Linux Virtual Machine. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."
  })
  EOT
}

variable "license_type" {
  type        = string
  default     = null
  description = "(Optional) For Linux virtual machine specifies the BYOL Type for this Virtual Machine, possible values are `RHEL_BYOS` and `SLES_BYOS`. For Windows virtual machine specifies the type of on-premise license (also known as [Azure Hybrid Use Benefit](https://docs.microsoft.com/windows-server/get-started/azure-hybrid-benefit)) which should be used for this Virtual Machine, possible values are `None`, `Windows_Client` and `Windows_Server`."
}

variable "max_bid_price" {
  type        = number
  default     = -1
  description = "(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the `eviction_policy`. Defaults to `-1`, which means that the Virtual Machine should not be evicted for price reasons. This can only be configured when `priority` is set to `Spot`."
}

variable "network_interface_ids" {
  type        = list(string)
  default     = null
  description = "A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine. Cannot be used along with `new_network_interface`."

  validation {
    condition     = var.network_interface_ids == null ? true : length(var.network_interface_ids) > 0
    error_message = "`network_interface_ids` must be `null` or a non-empty list."
  }
}

variable "new_boot_diagnostics_storage_account" {
  type = object({
    name                             = optional(string)
    account_kind                     = optional(string, "StorageV2")
    account_tier                     = optional(string, "Standard")
    account_replication_type         = optional(string, "LRS")
    cross_tenant_replication_enabled = optional(bool, true)
    access_tier                      = optional(string, "Hot")
    enable_https_traffic_only        = optional(bool, true)
    min_tls_version                  = optional(string, "TLS1_2")
    allow_nested_items_to_be_public  = optional(bool, true)
    shared_access_key_enabled        = optional(bool, true)
    public_network_access_enabled    = optional(bool, false)
    default_to_oauth_authentication  = optional(bool, false)
    customer_managed_key = optional(object({
      key_vault_key_id          = string
      user_assigned_identity_id = string
    }))
    blob_properties = optional(object({
      delete_retention_policy = optional(object({
        days = optional(number, 7)
      }))
      restore_policy = optional(object({
        days = number
      }))
      container_delete_retention_policy = optional(object({
        days = optional(number, 7)
      }))
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
  })
  default     = null
  description = <<-EOT
  object({
    name                             = "(Optional) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Omit this field would generate one. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
    account_kind                     = "(Optional) Defines the Kind of account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`.  Defaults to `StorageV2`. Changing the `account_kind` value from `Storage` to `StorageV2` will not trigger a force new on the storage account, it will only upgrade the existing storage account from `Storage` to `StorageV2` keeping the existing storage account in place."
    account_tier                     = "(Optional) Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. For `BlockBlobStorage` and `FileStorage` accounts only `Premium` is valid. Defaults to `Standard`. Changing this forces a new resource to be created. Blobs with a tier of `Premium` are of account kind `StorageV2`."
    account_replication_type         = "(Optional) Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`. Defaults to `LRS`. Changing this forces a new resource to be created when types `LRS`, `GRS` and `RAGRS` are changed to `ZRS`, `GZRS` or `RAGZRS` and vice versa."
    cross_tenant_replication_enabled = "(Optional) Should cross Tenant replication be enabled? Defaults to `true`."
    access_tier                      = "(Optional) Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`."
    enable_https_traffic_only        = "(Optional) Boolean flag which forces HTTPS if enabled, see [here](https://docs.microsoft.com/azure/storage/storage-require-secure-transfer/) for more information. Defaults to `true`."
    min_tls_version                  = "(Optional) The minimum supported TLS version for the storage account. Possible values are `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLS1_2` for new storage accounts. At this time `min_tls_version` is only supported in the Public Cloud, China Cloud, and US Government Cloud."
    allow_nested_items_to_be_public  = "(Optional) Allow or disallow nested items within this Account to opt into being public. Defaults to `true`. At this time `allow_nested_items_to_be_public` is only supported in the Public Cloud, China Cloud, and US Government Cloud."
    shared_access_key_enabled        = "(Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is `true`. Terraform uses Shared Key Authorisation to provision Storage Containers, Blobs and other items - when Shared Key Access is disabled, you will need to enable [the `storage_use_azuread` flag in the Provider block](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#storage_use_azuread) to use Azure AD for authentication, however not all Azure Storage services support Active Directory authentication."
    public_network_access_enabled    = "(Optional) Whether the public network access is enabled? Defaults to `false`."
    default_to_oauth_authentication  = "(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is `false`"
    customer_managed_key             = optional(object({
      key_vault_key_id          = "(Required) The ID of the Key Vault Key, supplying a version-less key ID will enable auto-rotation of this key."
      user_assigned_identity_id = "(Required) The ID of a user assigned identity. `customer_managed_key` can only be set when the `account_kind` is set to `StorageV2` or `account_tier` set to `Premium`, and the identity type is `UserAssigned`."
    }))
    blob_properties = optional(object({
      delete_retention_policy = optional(object({
        days = "(Optional) Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`."
      }))
      restore_policy = optional(object({
        days = "(Required) Specifies the number of days that the blob can be restored, between `1` and `365` days. This must be less than the `days` specified for `delete_retention_policy`."
      }))
      container_delete_retention_policy = optional(object({
        days = "(Optional) Specifies the number of days that the container should be retained, between `1` and `365` days. Defaults to `7`."
      }))
    }))
    identity = optional(object({
      type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."
      identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."
    }))
  })
  EOT
}


variable "patch_assessment_mode" {
  type        = string
  default     = "ImageDefault"
  description = "(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are `AutomaticByPlatform` or `ImageDefault`. Defaults to `ImageDefault`."
}

variable "patch_mode" {
  type        = string
  default     = "ImageDefault"
  description = "(Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are `AutomaticByPlatform` and `ImageDefault`. Defaults to `ImageDefault`. For more information on patch modes please see the [product documentation](https://docs.microsoft.com/azure/virtual-machines/automatic-vm-guest-patching#patch-orchestration-modes). Defaults to `ImageDefault`."
  validation {
    condition = contains(["AutomaticByPlatform", "ImageDefault"], var.patch_mode)
    error_message = "`var.patch_mode` is not a valid value. Use one of: `AutomaticByPlatform`, `ImageDefault`"
  }
}

variable "reboot_setting" {
  type        = string
  default     = null
  description = "(Optional) Specifies the reboot setting for platform scheduled patching. Possible values are `Always`, `IfRequired` and `Never`. Only valid if `patch_mode` is `AutomaticByPlatform`."

  validation {
    condition     = var.reboot_setting == null ? true : contains(["Always", "IfRequired", "Never"], var.reboot_setting)
    error_message = "`var.reboot_setting` is not a valid value. Use one of: `Always`, `IfRequired`, `Never`"
  }
}

variable "secrets" {
  type = list(object({
    key_vault_id = string
    certificate = set(object({
      url   = string
      store = optional(string)
    }))
  }))
  default     = []
  description = <<-EOT
  list(object({
    key_vault_id = "(Required) The ID of the Key Vault from which all Secrets should be sourced."
    certificate  = set(object({
      url   = "(Required) The Secret URL of a Key Vault Certificate. This can be sourced from the `secret_id` field within the `azurerm_key_vault_certificate` Resource."
      store = "(Optional) The certificate store on the Virtual Machine where the certificate should be added. Required when use with Windows Virtual Machine."
    }))
  }))
  EOT
  nullable    = false
}
variable "source_image_reference_publisher" {
  type        = string
  default     = "Canonical"
  description = "Specifies the Publisher of the Image used to create the Virtual Machine. Changing this forces a new resource to be created."
  
}
variable "source_image_reference_offer" {
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
  description = "Specifies the Offer of the Image used to create the Virtual Machine. Changing this forces a new resource to be created."
  
}
variable "source_image_reference_sku" {
  type        = string
  default     = "22_04-lts-gen2"
  description = "Specifies the SKU of the Image used to create the Virtual Machine. Changing this forces a new resource to be created."
  
}
variable "source_image_reference_version" {
  type        = string
  default     = "latest"
  description = "Specifies the Version of the Image used to create the Virtual Machine. Changing this forces a new resource to be created."
  
}

variable "tags" {
  type = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."
}


variable "timezone" {
  type        = string
  default     = null
  description = "(Optional) Specifies the Time Zone which should be used by the Virtual Machine, [the possible values are defined here](https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/). Changing this forces a new resource to be created."
}

variable "user_data" {
  type        = string
  default     = null
  description = "(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine."

  validation {
    condition     = var.user_data == null ? true : can(base64decode(var.user_data))
    error_message = "`user_data` must be either `null` or valid base64 encoded string."
  }
}

variable "zone" {
  type        = string
  default     = null
  description = "(Optional) The Availability Zone which the Virtual Machine should be allocated in, only one zone would be accepted. If set then this module won't create `azurerm_availability_set` resource. Changing this forces a new resource to be created."
}

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "workbench"
}

variable "data_sa_type" {
  description = "Data Disk Storage Account type. Default is set to 'Standard_LRS'."
  type        = string
  default     = "Standard_LRS"
}

# variable "ssh_key" {
#   description = "Path to the public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
#   type = string
#   default     = "~/.ssh/id_rsa.pub"
# }
