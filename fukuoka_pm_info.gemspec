# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fukuoka_pm_info/version'

Gem::Specification.new do |spec|
  spec.name          = "fukuoka_pm_info"
  spec.version       = FukuokaPmInfo::VERSION
  spec.authors       = ["aspick"]
  spec.email         = ["yugo@18th-lab.com"]
  spec.description   = "Fukuoka city PM2.5 information crawler"
  spec.summary       = "Fukuoka"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "nokogiri"
end
