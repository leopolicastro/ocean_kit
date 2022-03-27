# frozen_string_literal: true

def do_client
  DropletKit::Client.new(access_token: access_token)
end

def access_token
  credentials_file = YAML.load(File.read(File.expand_path("~/.ocean_kit/credentials.yml")))
  credentials_file["digital_ocean_token"]
rescue => e
  puts pastel.red.bold("Error: #{e.message}")
end
