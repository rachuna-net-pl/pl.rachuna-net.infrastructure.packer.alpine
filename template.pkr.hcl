source "proxmox-iso" "alpine" {
  ## Proxmox Connection Details
  proxmox_url              = "https://${var.proxmox_node_name}.rachuna-net.pl:8006/api2/json"
  node                     = var.proxmox_node_name
  username                 = var.proxmox_api_username
  password                 = var.proxmox_api_password
  insecure_skip_tls_verify = !var.proxmox_api_tls_verify

  ## VM Template Definition
  template_name        = "${var.vm_name}"
  template_description = "Built on ${formatdate("YYYY-MM-DD HH:mm", timestamp())}"
  vm_id                = var.vm_id == 0 ? null : var.vm_id
  vm_name              = var.vm_name
  tags                 = var.vm_tags
  pool                 = "templates"

  boot_iso {
    iso_url          = var.iso_url
    iso_target_path  = var.iso_target_path
    iso_checksum     = var.iso_checksum
    iso_storage_pool = var.iso_storage_pool
    iso_file         = var.iso_file == null ? null : "${var.iso_storage_pool}:iso/${var.iso_file}"
    unmount          = true
  }

  ## VM Configuration
  os              = "l26"
  qemu_agent      = true
  memory          = var.vm_memory
  cores           = var.vm_cores
  sockets         = var.vm_sockets
  scsi_controller = "virtio-scsi-pci"

  network_adapters {
    bridge   = "vmbr0"
    model    = "virtio"
    vlan_tag = var.vm_is_production ? 20 : 10
    firewall = true
  }

  disks {
    type         = "scsi"
    disk_size    = var.vm_disk_size
    storage_pool = "storage.rachuna-net.pl"
    format       = "raw"
  }

  ##
  http_directory    = "http"
  http_bind_address = var.http_bind_address
  http_port_min     = var.http_server_port
  http_port_max     = var.http_server_port
  http_interface    = var.http_interface
  vm_interface      = var.vm_interface

  boot = null

  boot_command = [
    "root<enter><wait3>",
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>", # Start networking with DHCP
    "wget ${local.http_url}/answers<enter><wait3>",     #Replace CR if file was generated on Windows machine
    "sed -i 's/\\r$//g' $PWD/answers<enter><wait3>",
    "USERANSERFILE=1 setup-alpine -f $PWD/answers<enter><wait15>", # Run alpine installer
    "${local.root_password}<enter><wait3>",
    "${local.root_password}<enter><wait3>",
    "no<enter><wait15>",
    "y<enter><wait25>",
    "reboot<enter>",
    "<wait30>",
    "root<enter><wait3>",
    "${local.root_password}<enter><wait3>",
    "wget ${local.http_url}/alpine-setup.sh<enter><wait3>",
    "chmod +x $PWD/alpine-setup.sh<enter><wait3>",
    "sed -i 's/\\r$//g' $PWD/alpine-setup.sh<enter><wait3>",
    "$PWD/alpine-setup.sh<enter><wait3>",
  ]

  boot_wait = "20s"

  ## SSH Configuration  
  ssh_handshake_attempts    = 100
  ssh_username              = var.ssh_username
  ssh_password              = var.ssh_password
  ssh_private_key_file      = var.ssh_private_key_file
  ssh_clear_authorized_keys = true
  ssh_timeout               = "45m"
  ssh_agent_auth            = var.ssh_agent_auth

}