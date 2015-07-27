require "bootstrap_tools/version"

require 'bootstrap_tools/helpers'
require 'haml'
require 'jquery-ui-rails'

module BootstrapTools
  class Engine < ::Rails::Engine
    initializer "bootstrap_tools.initialize" do |app|
      ActionView::Base.send :include, BootstrapTools::Helpers
    end
  end
end
