require 'bundler/setup'
Bundler.setup

require 'web_bouncer'

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = false

  config.order = :random
end
