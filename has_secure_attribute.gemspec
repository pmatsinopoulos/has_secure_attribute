# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'has_secure_attribute/version'

Gem::Specification.new do |s|
  s.name = "has_secure_attribute"
  s.version = HasSecureAttribute::VERSION

  s.authors = ["Panayotis Matsinopoulos"]
  s.email = ["panayotis@matsinopoulos.gr"]
  s.description = "Does what `has_secure_password` does, but for any attribute that you want. It does not have to be a `password` attribute. It may be for example `security_answer`"
  s.date = "2013-08-15"

  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.md MIT-LICENSE)

  s.homepage = "https://github.com/pmatsinopoulos/has_secure_attribute"
  s.require_paths = ["lib"]
  s.summary = "Allows an ActiveRecord::Base class to declare an attribute that will be saved one-way encrypted and not clear text"

  s.add_runtime_dependency("activerecord")
  s.add_runtime_dependency("bcrypt-ruby", "~> 3.0.0")

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec")
  s.add_development_dependency("mysql2")
  s.add_development_dependency("factory_girl")
  s.add_development_dependency("database_cleaner")
end