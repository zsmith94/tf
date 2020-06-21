provider "vultr" {
    api_key = "NON2KYATVRBHNLSTKQ4NL2EGRXKLEEYMFS6Q"
    rate_limit  = 700
    retry_limit = 3
}

# instantiate swgemu server
resource "vultr_server" "swgemu" {
    plan_id = "201"
    region_id   = "25"
    os_id = "381"
    label = var.label
    tag = var.tag
    hostname = var.hostname
    ssh_key_ids = ["${data.vultr_ssh_key.terraform_key.id}"]
    firewall_group_id = vultr_firewall_group.swgemu_firewall.id
    # user_data = file("userdata.sh")

    # get the public IP
    provisioner "local-exec" {
        command = "echo ${vultr_server.swgemu.main_ip} > external_ip"
    }

    provisioner "file" {
        source = "files/setup.sh"
        destination = "/tmp/setup.sh"
        connection {
            type = "ssh"
            user = "root"
            host = vultr_server.swgemu.main_ip
            password = vultr_server.swgemu.default_password
        }

    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/setup.sh",
            "bash /tmp/setup.sh"
        ]
    }
}
