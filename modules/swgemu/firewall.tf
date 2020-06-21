resource "vultr_firewall_group" "swgemu_firewall" {
    description = "swgemu_firewall"
}

resource "vultr_firewall_rule" "swgemu_firewall_rule" {
    firewall_group_id = vultr_firewall_group.swgemu_firewall.id
    protocol = "tcp"
    network = "0.0.0.0/0"
    from_port = "44453"
}
