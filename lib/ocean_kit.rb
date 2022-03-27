# frozen_string_literal: true

require "droplet_kit"
require_relative "ocean_kit/version"
require_relative "./ocean_kit/ocean_cli"

module OceanKit
  class OceanClient
    def client
      DropletKit::Client.new(access_token: "a2de9724bd9eda0ea8bebc4454b9750fc034dc413c4c1b869ea8392b9ae338bf")
    end
  end

  class Error < StandardError; end
end
