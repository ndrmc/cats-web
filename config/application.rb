require_relative 'boot'

require 'rails/all'
require 'ethiopic_calendar'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cats
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << Rails.root.join('lib')
    config.assets.paths << Rails.root.join('node_modules')

    config.generators.javascript_engine :js

    def load_console(app = self)
      super
      project_specific_irbrc = File.join(Rails.root, ".irbrc")
      puts "Loading project specific .irbrc ..."
      load(project_specific_irbrc) if File.exists?(project_specific_irbrc)
    end

    # Get applicaiton version from git tag
    if Rails.env.development?
      File.open('config/VERSION', 'w') do |file|
        file.write `git describe --tags --always`
      end
    end

    config.version = File.read('config/VERSION')

  end
end
