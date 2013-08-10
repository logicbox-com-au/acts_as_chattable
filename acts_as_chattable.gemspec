# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "acts_as_chattable"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Bruscella"]
  s.date = "2013-08-10"
  s.email = "ben@logicbox.com.au"
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".rspec",
    ".ruby-gemset",
    ".ruby-version",
    "Gemfile",
    "Gemfile.lock",
    "MIT-LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "acts_as_chattable.gemspec",
    "coverage/.last_run.json",
    "coverage/.resultset.json",
    "gemfiles/Gemfile-3.0",
    "gemfiles/Gemfile-3.1",
    "gemfiles/Gemfile-3.2",
    "gemfiles/Gemfile-4.0",
    "lib/acts_as_chattable.rb",
    "lib/acts_as_chattable/message.rb",
    "lib/acts_as_chattable/model.rb",
    "lib/acts_as_chattable/rails3.rb",
    "lib/acts_as_chattable/rails4.rb",
    "lib/acts_as_chattable/railtie.rb",
    "lib/acts_as_chattable/relation.rb",
    "lib/generators/acts_as_chattable/migration/migration_generator.rb",
    "lib/generators/acts_as_chattable/migration/templates/migration.rb",
    "lib/generators/acts_as_chattable/migration/templates/migration_permanent.rb",
    "spec/acts_as_chattable_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/admin.rb",
    "spec/support/send_message.rb",
    "spec/support/user.rb"
  ]
  s.homepage = "https://github.com/logicbox-com-au/acts_as_chattable"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Make user chattable!"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<dragonfly>, [">= 0.9.15"])
      s.add_runtime_dependency(%q<railties>, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_dependency(%q<dragonfly>, [">= 0.9.15"])
      s.add_dependency(%q<railties>, [">= 3.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.0.0"])
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    s.add_dependency(%q<dragonfly>, [">= 0.9.15"])
    s.add_dependency(%q<railties>, [">= 3.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
  end
end

