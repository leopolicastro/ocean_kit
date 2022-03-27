# frozen_string_literal: true

module OceanKit
  class Config < Thor
    desc "setup", "Setup OceanKit environment"
    def setup
      # First create the ~/.ocean_kit directory if it doesn't exist
      Dir.mkdir(File.expand_path("~/.ocean_kit")) unless File.directory?(File.expand_path("~/.ocean_kit"))
      # Next create the credentials.yml file if it doesn't exist
      unless File.file?(File.expand_path("~/.ocean_kit/credentials.yml"))
        File.write(File.expand_path("~/.ocean_kit/credentials.yml"), <<~YAML)
          ---
          digital_ocean_token: <YOUR_DIGITAL_OCEAN_TOKEN>

        YAML
      end
      puts pastel.green.bold("Successfully setup OceanKit environment.")
      puts pastel.white.bold("Please add your Digital Ocean personal access token your credentials in ~/.ocean_kit/credentials.yml")
    end
  end
end
