# frozen_string_literal: true

def do_client
  DropletKit::Client.new(access_token: access_token)
end

def access_token
  credentials_file["digital_ocean_token"]
rescue => e
  puts pastel.red.bold("Error: #{e.message}")
end

def credentials_file
  YAML.load(File.read(File.expand_path("~/.ocean_kit/credentials.yml")))
end

def check_credentials_file
  if credentials_file.nil?
    puts pastel.red.bold("Error: credentials file not found. Please run `ocean_kit setup` first.")
    exit 1
  end
end
