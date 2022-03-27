# frozen_string_literal: true

require 'thor'

module OceanKit
  class OceanCli < Thor
    desc 'hello [name]', 'say my name'
    def hello(name)
      if name == 'Heisenberg'
        puts 'you are goddman right'
      else
        puts 'say my name'
      end
    end
  end
end
