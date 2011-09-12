require 'cancan'
require 'padrino-cancan/helpers'

module Padrino
  module CanCan
    class << self
      def registered(app)
        app.helpers Padrino::CanCan::Helpers
#        app.helpers ::CanCan::ControllerAdditions
      end
      alias :included :registered
    end
  end
end
