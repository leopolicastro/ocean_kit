# frozen_string_literal: true

require "droplet_kit"
require "pastel"
require "thor"
require "yaml"

require_relative "ocean_kit/version"
require_relative "./ocean_kit/firewalls"

module OceanKit
  class Client < Thor
    desc "firewalls SUBCOMMAND ...ARGS", "manage your DO firewall"
    subcommand "firewalls", Firewalls

    no_commands {
      def client
        DropletKit::Client.new(access_token: access_token)
      end

      def access_token
        credentials_file = YAML.load(File.read(File.expand_path("~/.ocean_kit/credentials.yml")))
        credentials_file["digital_ocean_token"]
      end
    }
  end

  class Error < StandardError; end
end
