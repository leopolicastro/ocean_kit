# frozen_string_literal: true

def fetch_firewall(number)
  do_client.firewalls.all.each_with_index.filter { |firewall, index| index == number.to_i }.flatten.first
end

def update_firewall(firewall)
  new_firewall = DropletKit::Firewall.new(
    name: firewall.name,
    inbound_rules: firewall.inbound_rules.map { |rule| new_inbound_rule(rule) },
    outbound_rules: firewall.outbound_rules,
    droplet_ids: firewall.droplet_ids,
    tags: firewall.tags
  )
  do_client.firewalls.update(new_firewall, id: firewall.id)
end

def firewall_inbound_rules(firewall)
  firewall.inbound_rules.map(&:to_h)
end

def new_inbound_rule(rule)
  DropletKit::FirewallInboundRule.new(
    protocol: rule[:protocol],
    ports: rule[:ports],
    sources: rule[:sources]
  )
end

def remove_ssh_rule(rules_array)
  rules_array.delete_if { |r| r[:ports] == "22" }
end

def add_ssh_rule(rules_array)
  rules_array << {protocol: "tcp", ports: "22", sources: {addresses: ["0.0.0.0/0", "::/0"]}}
end
