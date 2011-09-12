module Padrino
  module CanCan
    module Helpers
      module ClassMethods
        include ::CanCan::Ability

        def abilities &block
          @block = block
        end

        def current_ability account
          @ability ||= Ability.new(account, registered_abilities, &@block)
        end

        def allow roles, &block
#          p "allow #{roles.inspect}"
          if roles.is_a? Array
            roles.each do |role| allow_role role, &block end
          else
            allow_role roles, &block 
          end
        end

        private
          def registered_abilities
            @_registered_abilities ||= {}
          end

          def allow_role role, &block
            registered_abilities[role] ||= []
            registered_abilities[role] << block
          end
      end

      def self.included(base) #:nodoc:
        base.extend(ClassMethods)
      end

      class Ability
        include ::CanCan::Ability
        def initialize account, registered_abilities, &block
          block.call

          role = account.role.to_sym rescue :any
          (registered_abilities[role] || []).each do |cans|
            cans.call
          end
        end
      end
    end
  end
end
