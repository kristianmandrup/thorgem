# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{thorgem}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2010-06-26}
  s.default_executable = %q{thorgem}
  s.description = %q{Creates a new thor task configured to your taste}
  s.email = %q{kmandrup@gmail.com}
  s.executables = ["thorgem"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "bin/thorgem",
     "lib/thorgem.rb",
     "lib/thorgem.thor",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/thortask_spec.rb",
     "templates/.gitignore",
     "templates/MITLICENSE",
     "templates/README.markdown",
     "templates/_signatures/APP.RUBY.TASK.THOR.signature",
     "templates/bin/binary.erb",
     "templates/bin/binary.erb.bat",
     "templates/cucumber.yml",
     "templates/features/app_name.feature",
     "templates/features/support/env.rb",
     "templates/lib/app_name.rb",
     "templates/spec/app_name/sample_spec.rb",
     "templates/spec/spec_helper.rb",
     "templates/templates/my_template.erb",
     "templates/templates/optional/opt_template.erb",
     "templates/wiki/home.textile",
     "thorgem.gemspec",
     "thortask.gemspec"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/thortask}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Creates a new thor task as a gem}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/thortask_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

