locals {
  # "timestamp" template function replacement
  timestamp     = regex_replace(timestamp(), "[- TZ:]", "")
  use_iso_file  = var.iso_file != null ? true : false
  http_url      = join("", ["http://", coalesce(var.http_server_host, "{{ .HTTPIP }}"), ":", coalesce(var.http_server_port, "{{ .HTTPPort }}")])
  root_password = coalesce(var.root_password, uuidv4())
}