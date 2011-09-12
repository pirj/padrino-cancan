# CanCan for Padrino

Padrino can can use all CanCan goodies

## Using

Add to your Gemfile

    gem 'padrino-cancan'

and run bundle

Register in your app:

    class MyApp < Padrino::Application
      register Padrino::CanCan

      ...

and add some abilities for some roles

    abilities do
      allow [:any, :external, :manager, :manufacturer, :admin] do
        p "allow"
        p self
        can :index, :base
        can [:index, :view, :find, :search], Product
      end
      
      allow [:external, :manager, :manufacturer, :admin] do
        can [:edit, :update], :account => account
      end

      ...
    end

## Author

Created by [Phil Pirozhkov](https://github.com/pirj)

[Origin](https://github.com/pirj/padrino-cancan)

## Future

Remove namespace waste
Be less dynamic, use permission caching
