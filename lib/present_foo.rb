require "delegate"
require "present_foo/version"
require "present_foo/presenter"
require "present_foo/presentation"

module PresentFoo

  def self.load!
    hook_rails if defined?(::Rails)
  end

  private

  def self.hook_rails
    ActiveSupport.on_load(:action_controller) do
      ::ActionController::Base.send :include, Presentation
    end
  end

end

PresentFoo.load!
