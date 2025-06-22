source "file" "answers" {
  content = templatefile("${path.root}/templates/answers.pkrtpl", {
    keyboard_layout  = var.keyboard_layout
    keyboard_variant = var.keyboard_variant
    timezone         = var.timezone
    dns_servers      = var.dns_servers
  })
  target = "${path.root}/http/answers"
}

source "file" "setup" {
  content = templatefile("${path.root}/templates/alpine-setup.sh.pkrtpl", {
    ssh_username = var.ssh_username
    ssh_password = var.ssh_password
  })
  target = "${path.root}/http/alpine-setup.sh"
}