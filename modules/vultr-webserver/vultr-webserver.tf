provider "vultr" {
    api_key = "NON2KYATVRBHNLSTKQ4NL2EGRXKLEEYMFS6Q"
    rate_limit  = 700
    retry_limit = 3
}

resource "vultr_server" "web" {
    plan_id = "201"
    region_id   = "25"
    os_id = "381"
    label = var.label
    tag = var.tag
    hostname = var.hostname
    ssh_key_ids = ["${data.vultr_ssh_key.terraform_key.id}"]
}

data "vultr_ssh_key" "terraform_key" {
    filter {
        name = "name"
        values = ["terraform_key"]
    }
}
