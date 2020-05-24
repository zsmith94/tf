data "vultr_ssh_key" "ubuntu" {
    filter {
        name = "name"
        values = ["ubuntu"]
    }
}
