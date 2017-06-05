require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rbenv'
require 'capistrano/puma'
install_plugin Capistrano::Puma

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git


Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }