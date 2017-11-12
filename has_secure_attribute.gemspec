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
  s.date = Time.now.to_date.to_s
  s.license = 'MIT'
  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.md MIT)

  s.homepage = "https://github.com/pmatsinopoulos/has_secure_attribute"
  s.require_paths = ["lib"]
  s.summary = "Allows an ActiveRecord::Base class to declare an attribute that will be saved one-way encrypted and not clear text"

  s.add_runtime_dependency("activerecord", "~> 5.1")
  s.add_runtime_dependency("bcrypt", "~> 3.1")

  s.add_development_dependency("rake", "~> 12.0")
  s.add_development_dependency("rspec", "~> 3.0")
  s.add_development_dependency("mysql2", "~> 0.4.0")
  s.add_development_dependency("factory_bot", "~> 4.8", ">= 4.8.0")
  s.add_development_dependency("database_cleaner", "~> 1.6", ">= 1.6.0")
end
