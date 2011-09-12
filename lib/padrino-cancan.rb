require 'cancan'
require 'padrino-cancan/helpers'

module Padrino
  module CanCan
    class << self
      def registered(app)
        app.helpers Padrino::CanCan::Helpers
        app.helpers ::CanCan::ControllerAdditions
      end
      alias :included :registered
    end
  end
end

module CanCan
  module ControllerAdditions
    # No helper_method defined by Padrino, so we have to comment one line out
    def self.included(base)
      base.extend ClassMethods
      # base.helper_method :can?, :cannot?, :current_ability
    end

    def current_ability
      settings.current_ability current_account 
    end
  end
end
