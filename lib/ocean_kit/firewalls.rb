# frozen_string_literal: true

require "thor"

module OceanKit
  class Firewalls < Thor
    desc "list", "Lists all firewalls"
    def list
      puts "List all firewalls"

      do_client.firewalls.all.each_with_index do |firewall, index|
        puts "[#{index}]: Firewall #{firewall.name} has #{firewall.droplet_ids.count} droplets"
      end
    end

    private

    def disable_ssh(rules_array)
      rules_array.delete_if { |r| r[:ports] == "22" }
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
  end
end
