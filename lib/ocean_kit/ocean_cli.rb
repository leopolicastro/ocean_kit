# frozen_string_literal: true

require "thor"
require_relative "./firewalls"

module OceanKit
  class OceanCLI < Thor
    desc "firewalls SUBCOMMAND ...ARGS", "manage your DO firewall"
    subcommand "firewalls", Firewalls
  end
end
