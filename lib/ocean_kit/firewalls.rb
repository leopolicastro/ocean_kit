# frozen_string_literal: true

require "thor"

module OceanKit
  class Firewalls < Thor
    desc "list", "Lists all firewalls"
    def list
      puts "List all firewalls"
      @digital_ocean = OceanKit::OceanClient.new
      @digital_ocean.client.firewalls.all.each do |firewall|
        puts "Firewall #{firewall.name} has #{firewall.droplet_ids.count} droplets"
        puts firewall.id
      end
    end
  end
end
