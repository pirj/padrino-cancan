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

    # CanCan expects current_user to get current user, while Padrino provides current_account
    def current_user
      current_account
    end

    # No helper_method defined by Padrino, so we have to comment one line out
    def self.included(base)
      base.extend ClassMethods
      # base.helper_method :can?, :cannot?, :current_ability
    end
  end
end
