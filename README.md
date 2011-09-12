# CanCan for Padrino

Padrino can can use all CanCan goodies

## Using

Add to your Gemfile

    gem 'padrino-cancan'

Run

    bundle

Register in your app

    class MyApp < Padrino::Application
      register Padrino::CanCan

      ...

Define how you want access denied to be handled

      error CanCan::AccessDenied do
        403
      end

Add some abilities for some roles

      role [:any, :external, :manager, :manufacturer, :admin] do
        can :index, :base
        can [:index, :view, :find, :search], Product
      end
      
      role [:external, :manager, :manufacturer, :admin] do
        can [:edit, :update], :account => account
      end

      role [:manager, :admin] do
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

In your views

    -if can?(:destroy, Product)
      %li=link_to 'Destroy', url(:products, :destroy, product.id), :confirm => pt(:confirm)
    -if can?(:edit, Product)
      %li=link_to 'Edit', url(:products, :edit, product.id)

## Author

Created by [Phil Pirozhkov](https://github.com/pirj)

[Origin](https://github.com/pirj/padrino-cancan)

## Future

Remove studid instance_eval. Check for extra initialization which may be cached. Go back to initial abilily/role/can syntax. Write tests.
