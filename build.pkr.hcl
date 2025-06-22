
build {
  sources = [
    "source.file.answers",
    "source.file.setup",
    "source.proxmox-iso.alpine",
  ]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | sudo -S env {{ .Vars }} {{ .Path }}"
    inline = [
      "echo '${var.ssh_username} ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/${var.ssh_username}",
      "mkdir -p /home/${var.ssh_username}/.ssh",
      "echo '${var.ssh_public_key}'",
      "echo '${var.ssh_public_key}' > /home/${var.ssh_username}/.ssh/authorized_keys",
      "chown -R ${var.ssh_username}:${var.ssh_username} /home/${var.ssh_username}/.ssh",
      "chmod 700 /home/${var.ssh_username}/.ssh",
      "chmod 600 /home/${var.ssh_username}/.ssh/authorized_keys",
    ]
  }

  # Cleanup
  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | sudo -S env {{ .Vars }} {{ .Path }}"
    inline = [
      "rm -f /root/alpine-setup.sh", # remove setup script
      "rm -f /root/.ssh/authorized_keys",
      "sed -r -i 's/^#?PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config",
      "sed -r -i 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "passwd -d root", # Disable root access
      "passwd -l root", # Lock root password
    ]
  }

}