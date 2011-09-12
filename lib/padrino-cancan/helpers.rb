module Padrino
  module CanCan
    module Helpers
      module ClassMethods
        def abilities &block
          block.call
        end

        def allow roles, &block
#          p "allow #{roles.inspect}"
          if roles.is_a? Array
            roles.each do |role| allow_role role, &block end
          else
            allow_role roles, &block 
          end
        end

        def registered_abilities
          @_registered_abilities ||= {}
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

      class Ability
        def initialize account

          @block.call

          role = account.role.to_sym rescue :any
          (@abilities[role] || []).each do |block|
            block.call
          end
        end
      end
    end
  end
end

class Ability
  include ::CanCan::Ability

  def initialize account
    p "sdfsdfdf #{account}"
    p "ssd #{registered_mailers.inspect}"
  end
end
