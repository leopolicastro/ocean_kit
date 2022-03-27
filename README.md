# OceanKit

Digital Ocean CLI.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ocean_kit'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ocean_kit

## Usage

- OceanKit expects a `~/.ocean_kit/credentials.yml` file to exist on your computer, server etc.

  - The file should have the following format:

    ```yml
    digital_ocean_token: your_digital_ocean_personal_access_token
    ```

For a list of available commands run

```
$ ocean_kit
```

Sample Output:

```text
Commands:
  ocean_kit firewalls SUBCOMMAND ...ARGS  # manage your DO firewall
  ocean_kit help [COMMAND]                # Describe available commands or one specific command
```

```
ocean_kit firewalls
```

Sample output:

```text
Commands:
  ocean_kit firewalls disable_all_ssh                # Disables SSH on all firewalls
  ocean_kit firewalls disable_ssh [firewall_number]  # Disable SSH on given firewall
  ocean_kit firewalls enable_all_ssh                 # Enables SSH on all firewalls
  ocean_kit firewalls enable_ssh [firewall_number]   # Enable SSH on given firewall
  ocean_kit firewalls help [COMMAND]                 # Describe subcommands or one specific subcommand
  ocean_kit firewalls list                           # Lists all firewalls.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ocean_kit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ocean_kit/blob/main/CODE_OF_CONDUCT.md).

- Currently only has very basic functionality to list firewalls, and enable or disable ssh on them.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OceanKit project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/leopolicastro/ocean_kit/blob/main/CODE_OF_CONDUCT.md).
