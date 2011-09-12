Gem::Specification.new do |gem|
  gem.name = "padrino-cancan"
  gem.version = "0.1.0"
  gem.description = "Padrino can can use all CanCan goodies"
  gem.summary = gem.description
  gem.authors = ["Phil Pirozhkov"]
  gem.email = ["pirj@mail.ru"]
  gem.date = Time.now.strftime '%Y-%m-%d'
  gem.homepage = "https://github.com/pirj/padrino-cancan"
  gem.require_paths = ["lib"]
  gem.files = [
    'lib/padrino-cancan.rb',
    'lib/padrino-cancan/helpers.rb'
    ]

  gem.add_dependency 'cancan'
end
