module Padrino
  module CanCan
    module Helpers
      def current_ability
        @ability ||= Ability.new(current_account, registered_abilities)
      end

      def can? *args
        current_ability.can? *args
      end

      def cannot? *args
        current_ability.cannot? *args
      end

      def authorize! *args
        current_ability.authorize! *args
      end

      def registered_abilities
        self.class.registered_abilities
      end

      module ClassMethods
        def registered_abilities
          @@_registered_abilities ||= {}
        end

        def role roles, &block
          if roles.is_a? Array
            roles.each do |role| allow_role role, &block end
          else
            allow_role roles, &block 
          end
        end

        private
          def allow_role role, &block
            registered_abilities[role] ||= []
            registered_abilities[role] << block
          end
      end

      def self.included(base) #:nodoc:
        base.extend(ClassMethods)
      end
    end

    class Ability
      include ::CanCan::Ability

      def initialize account, registered_abilities
        role = account.role.to_sym rescue :any

        (registered_abilities[role] || []).each do |cans|
          instance_eval &cans
        end
      end
    end
  end
end
