# frozen_string_literal: true

require "droplet_kit"
require "pastel"
require "thor"
require "yaml"

require_relative "ocean_kit/version"
require_relative "./ocean_kit/resources/base"
require_relative "./ocean_kit/helpers/base"

module OceanKit
  class Client < Thor
    desc "firewalls SUBCOMMAND ...ARGS", "manage your DO firewall"
    subcommand "firewalls", Firewalls
  end

  class Error < StandardError; end
end
