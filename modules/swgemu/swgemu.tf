provider "vultr" {
    api_key = "NON2KYATVRBHNLSTKQ4NL2EGRXKLEEYMFS6Q"
    rate_limit  = 700
    retry_limit = 3
}

# instantiate swgemu server
resource "vultr_server" "swgemu" {
    plan_id = "201"
    region_id   = "4"
    os_id = "167"
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

    # copy all of our files to /tmp
    provisioner "file" {
        source = "files/"
        destination = "/tmp/"
        connection {
            type = "ssh"
            user = "root"
            host = "${vultr_server.swgemu.main_ip}"
            password = "${vultr_server.swgemu.default_password}"
        }

    }

    # add ex permissions, run all scripts
    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/*.sh",
            "echo 'permissions altered for scripts in /tmp...'",
            "bash /tmp/pkg_setup.sh",
            "echo 'packages installed, now setting up mysql...'",
            "bash /tmp/mysql_setup.sh {vultr_server.swgemu.default_password} {var.new_password}",
            "echo 'mysql set up, now running swg setup...'",
            "bash /tmp/swg_setup.sh",
            "echo 'swg setup complete...'"
        ]

        connection {
            type = "ssh"
            user = "root"
            host = "${vultr_server.swgemu.main_ip}"
            password = "${vultr_server.swgemu.default_password}"
        }
    }
}
