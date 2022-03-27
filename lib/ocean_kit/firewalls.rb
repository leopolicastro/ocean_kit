# frozen_string_literal: true

require "thor"

module OceanKit
  class Firewalls < Thor
    desc "list", "Lists all firewalls"
    def list
      do_client.firewalls.all.each_with_index do |firewall, index|
        puts "[#{index}]: Firewall #{firewall.name} has #{firewall.droplet_ids.count} droplets"
      end
    end

    desc "enable_ssh [firewall_number]", "Enable SSH on given firewall"
    def enable_ssh(number)
      firewall_id = nil
      do_client.firewalls.all.each_with_index do |firewall, index|
        if index == number.to_i
          firewall_id = firewall.id
          break
        end
      end
      firewall = do_client.firewalls.find(id: firewall_id)
      inbound_rules = firewall_inbound_rules(firewall)
      firewall.inbound_rules = add_ssh_rule(inbound_rules)
      begin
        update_firewall(firewall)
        puts "SSH enabled on firewall #{firewall.name}"
      rescue DropletKit::Error => e
        puts "Error: #{e.message}"
      end
    end

    desc "disable_ssh [firewall_number]", "Disable SSH on given firewall"
    def disable_ssh(number)
      firewall_id = nil
      do_client.firewalls.all.each_with_index do |firewall, index|
        if index == number.to_i
          firewall_id = firewall.id
          break
        end
      end
      firewall = do_client.firewalls.find(id: firewall_id)
      inbound_rules = firewall_inbound_rules(firewall)
      firewall.inbound_rules = remove_ssh_rule(inbound_rules)
      begin
        update_firewall(firewall)
        puts "SSH disabled on firewall #{firewall.name}"
      rescue DropletKit::Error => e
        puts "Error: #{e.message}"
      end
    end

    private

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

    def do_client
      @digital_ocean = OceanKit::OceanClient.new
      @digital_ocean.client
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
  end
end
