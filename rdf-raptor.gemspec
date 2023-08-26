#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'rdf-raptor'
  gem.homepage           = 'https://github.com/ruby-rdf/rdf-raptor'
  gem.license            = 'Unlicense'
  gem.summary            = 'Raptor RDF Parser plugin for RDF.rb.'
  gem.description        = 'RDF.rb plugin for parsing/serializing NTriples, RDF/XML, Turtle and RDFa data using the Raptor RDF Parser library.'
  gem.metadata           = {
    "documentation_uri" => "https://ruby-rdf.github.io/rdf-raptor",
    "bug_tracker_uri"   => "https://github.com/ruby-rdf/rdf-raptor/issues",
    "homepage_uri"      => "https://github.com/ruby-rdf/rdf-raptor",
    "mailing_list_uri"  => "https://lists.w3.org/Archives/Public/public-rdf-ruby/",
    "source_code_uri"   => "https://github.com/ruby-rdf/rdf-raptor",
  }

  gem.authors            = ['Arto Bendiken', 'John Fieber']
  gem.email              = 'public-rdf-ruby@w3.org'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS CONTRIBUTING.md CREDITS README.md UNLICENSE VERSION etc/doap.ttl) + Dir.glob('lib/**/*.rb')
  gem.require_paths      = %w(lib)

  gem.required_ruby_version      = '>= 3.0'
  gem.requirements               = ['libraptor2 (>= 2.0)']
  gem.add_runtime_dependency     'ffi',      '~> 1.15'
  gem.add_runtime_dependency     'rdf',      '~> 3.3'
  gem.add_development_dependency 'yard' ,    '~> 0.9'
  gem.add_development_dependency 'rspec',    '~> 3.12'
  gem.add_development_dependency 'rspec-its','~> 1.3'
  gem.add_development_dependency 'rdf-spec', '~> 3.2'
  gem.add_development_dependency 'rake',     '~> 13.0'

  gem.post_install_message = <<-MESSAGE
  NOTE: RDF::Raptor requires libraptor2 to be installed on the system. Please see the Installation
  section in the README for more information on how to install it.
  MESSAGE
end
