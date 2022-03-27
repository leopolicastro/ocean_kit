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
  end
end
