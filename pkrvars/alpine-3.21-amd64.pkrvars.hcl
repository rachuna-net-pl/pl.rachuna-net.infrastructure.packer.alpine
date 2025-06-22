#### PROXMOX CLUSTER VARIABLES ####
# proxmox_node_name            = env("PKR_VAR_proxmox_node_name")
# proxmox_api_username         = env("PKR_VAR_proxmox_api_username")
# proxmox_api_password         = env("PKR_VAR_proxmox_api_password")
# proxmox_api_tls_verify       = env("PKR_VAR_proxmox_api_tls_verify")

#### BOOT ISO VARIABLES ####
iso_url      = "https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/x86_64/alpine-standard-3.21.2-x86_64.iso"
iso_checksum = "sha256:706e9521cd21188786cb983131040ee68399e504924ea3318d600d1e04a93878"
# iso_storage_pool             = env("PKR_VAR_iso_storage_pool")

#### VM VARIABLES ####
vm_name = "alpine-3.21.2"
vm_tags = "template;alpine-3"
vm_id            = 913
vm_memory        = 4096
vm_cores         = 2
vm_sockets       = 2
vm_disk_size     = "64G"
vm_is_production = false

### SSH CONFIG ###

# ssh_public_key               = env("PKR_VAR_ssh_public_key")
# ssh_private_key_file         = env("PKR_VAR_ssh_private_key_file")
# root_password                = env("PKR_VAR_root_password")