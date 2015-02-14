$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "controllers")
require "quotes_controller"

require 'rulers'

module BestQuotes
  class Application < Rulers::Application
  end
end
