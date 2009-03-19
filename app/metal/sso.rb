# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)
require 'hancock-client'

class Sso < Hancock::Client::Default
  disable :raise_errors
end
