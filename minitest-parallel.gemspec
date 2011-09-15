$:.unshift File.expand_path("../lib", __FILE__)
require "minitest/parallel/version"

Gem::Specification.new do |s|
  s.name          = "minitest-parallel"
  s.version       = Minitest::Parallel::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Mitchell Hashimoto"]
  s.email         = ["mitchell.hashimoto@gmail.com"]
  s.summary       = "minitest-parallel runs your minitest tests in parallel."
  s.description   = "minitest-parallel runs your minitest tests in parallel."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "minitest-parallel"

  s.add_dependency "minitest", "~> 2.6.0"

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path  = 'lib'
end

