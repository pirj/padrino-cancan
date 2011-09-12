# CanCan for Padrino

Padrino can can use all CanCan goodies

## Using

Add to your Gemfile

    gem 'padrino-cancan'

Run

    bundle

Register in your app:

    class MyApp < Padrino::Application
      register Padrino::CanCan

      ...

Add some abilities for some roles

      abilities do
        allow [:any, :external, :manager, :manufacturer, :admin] do
          can :index, :base
          can [:index, :view, :find, :search], Product
        end
        
        allow [:external, :manager, :manufacturer, :admin] do
          can [:edit, :update], :account => account
        end

        allow [:manager, :admin] do
          can [:create, :destroy], [Brand, Factory]
          can :manage, Product
        end

        ...
      end

refer to [CanCan wiki](https://github.com/ryanb/cancan/wiki/defining-abilities) to learn how to define abilities syntax ("can" method)


In your controller

    App.controllers :products do
      get :index do
        authorize! :index, Product
        ...
      end

      get :view, :with => :id  do
        authorize! :view, Product
        ...
      end

      ...
    end

In your views:

    -if can?(:destroy, Product)
      %li=link_to 'Destroy', url(:products, :destroy, product.id), :confirm => pt(:confirm)
    -if can?(:edit, Product)
      %li=link_to 'Edit', url(:products, :edit, product.id)

## Author

Created by [Phil Pirozhkov](https://github.com/pirj)

[Origin](https://github.com/pirj/padrino-cancan)

## Future

Remove namespace waste
Be less dynamic, use permission caching
