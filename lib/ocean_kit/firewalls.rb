# frozen_string_literal: true

module OceanKit
  class Firewalls < Thor
    desc "list", "Lists all firewalls for account."
    def list
      puts pastel.white.bold.underline("Firewalls:\n")
      do_client.firewalls.all.each_with_index do |firewall, index|
        puts pastel.white.bold("[#{index}]: Firewall #{firewall.name} has #{firewall.droplet_ids.count} droplets")
        firewall_inbound_rules(firewall).each_with_index do |rule, ii|
          puts pastel.blue.bold("     [#{ii}] #{pastel.blue.bold(rule)}")
        end
      end
    end

    desc "enable_all_ssh", "Enables SSH on all firewalls"
    def enable_all_ssh
      puts pastel.white.bold("Enabling SSH on all firewalls")
      do_client.firewalls.all.each_with_index do |fw, index|
        inbound_rules = firewall_inbound_rules(fw)
        fw.inbound_rules = add_ssh_rule(inbound_rules)
        begin
          update_firewall(fw)
          puts pastel.green.bold("SSH enabled on firewall #{fw.name}")
        rescue DropletKit::Error => e
          puts pastel.red.bold("Error: #{e.message}")
        end
      end
    end

    desc "disable_all_ssh", "Disables SSH on all firewalls"
    def disable_all_ssh
      puts pastel.white.bold("Disabling SSH on all firewalls")
      do_client.firewalls.all.each_with_index do |fw, index|
        inbound_rules = firewall_inbound_rules(fw)
        fw.inbound_rules = remove_ssh_rule(inbound_rules)
        begin
          update_firewall(fw)
          puts pastel.green.bold("SSH disabled on firewall #{fw.name}")
        rescue DropletKit::Error => e
          puts pastel.red.bold("Error: #{e.message}")
        end
      end
    end

    desc "enable_ssh [firewall_number]", "Enable SSH on given firewall"
    def enable_ssh(number)
      firewall = fetch_firewall(number)
      inbound_rules = firewall_inbound_rules(firewall)
      firewall.inbound_rules = add_ssh_rule(inbound_rules)
      begin
        update_firewall(firewall)
        puts pastel.green.bold("SSH enabled on firewall #{firewall.name}")
      rescue DropletKit::Error => e
        puts pastel.red.bold("Error: #{e.message}")
      end
    end

    desc "disable_ssh [firewall_number]", "Disable SSH on given firewall"
    def disable_ssh(number)
      firewall = fetch_firewall(number)
      inbound_rules = firewall_inbound_rules(firewall)
      firewall.inbound_rules = remove_ssh_rule(inbound_rules)
      begin
        update_firewall(firewall)
        puts pastel.green.bold("SSH disabled on firewall #{firewall.name}")
      rescue DropletKit::Error => e
        puts pastel.red.bold("Error: #{e.message}")
      end
    end

    private

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

    def pastel
      Pastel.new
    end

    def find_firewall_by_id(id)
      do_client.firewalls.find(id:)
    end
  end
end
