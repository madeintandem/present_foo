#$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
#$LOAD_PATH.unshift(File.dirname(__FILE__))

require "spec_helper"
require "rails"
require "present_foo"
require "fake_app"
require "fake_classes"
require "rspec/rails"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end
