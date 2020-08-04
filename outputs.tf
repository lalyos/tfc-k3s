output "k3s_master_ip" {
  value = google_compute_address.static.address
}

output "k8s_config" {
  value = templatefile("config.tmpl", 
    {
      server_ip = google_compute_address.static.address
      admin_password = data.external.password.result.password
    }
  )
}