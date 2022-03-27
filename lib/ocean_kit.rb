# frozen_string_literal: true

require "droplet_kit"
require_relative "ocean_kit/version"
require_relative "./ocean_kit/ocean_cli"

require "yaml"

module OceanKit
  class OceanClient
    def client
      DropletKit::Client.new(access_token: access_token)
    end

    def access_token
      credentials_file = YAML.load(File.read(File.expand_path("~/.ocean_kit/credentials.yml")))
      credentials_file["digital_ocean_token"]
    end
  end

  class Error < StandardError; end
end
