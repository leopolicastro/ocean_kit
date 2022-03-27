# frozen_string_literal: true

module OceanKit
  class Droplets < Thor
    desc "list", "Lists all droplers."
    def list
      puts underline_text("Droplets:")
      puts pastel.blue.bold "🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳\n"
      do_client.droplets.all.each_with_index do |droplet, index|
        puts pastel.white.bold "Name: ", pastel.clear.white(droplet.name)
        puts pastel.white.bold "ID: ", pastel.clear.white(droplet.id)
        puts pastel.white.bold "Public IP: ", pastel.clear.white(droplet.networks.v4.first.ip_address)
        puts pastel.white.bold "Region: ", pastel.clear.white(droplet.region.slug)
        puts pastel.white.bold "Status: ", pastel.clear.white(droplet.status)
        puts pastel.white.bold "Created: ", pastel.clear.white(droplet.created_at)
        puts pastel.blue.bold "\n🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳🐳\n"
      end
    end
  end
end
