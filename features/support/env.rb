# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "test"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'cucumber/formatters/unicode' # Comment out this line if you don't want Cucumber Unicode support
Cucumber::Rails.use_transactional_fixtures

require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

require 'cucumber/rails/rspec'
require 'webrat/core/matchers'
require 'safariwatir'
require 'dm-sweatshop'

include Webrat::Matchers

module MyWorldHelpers
  def sso_server
    @sso_server ||= 'http://hancock.atmos.org/sso'
  end
  def browser
    @browser ||= Watir::Safari.new
  end
end

World(MyWorldHelpers)
