# frozen_string_literal: true

require_relative "lib/string_calculator/version"

Gem::Specification.new do |spec|
  spec.name = "string_calculator"
  spec.version = StringCalculator::VERSION
  spec.authors = ["Abhinav Chauhan"]
  spec.email = ["abhic.bob@gmail.com"]
  spec.license = "MIT"

  spec.summary = "A simple calculator that takes string input to perform calculation."
  spec.description = "Provides functionality to parse strings containing numbers and delimiters " \
                     "and calculate their sum."
  spec.homepage = "https://github.com/abhiccc1/string_calculator"

  spec.required_ruby_version = ">= 3.1.0"
  spec.metadata["homepage_uri"] = spec.homepage

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
