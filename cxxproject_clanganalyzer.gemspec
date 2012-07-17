# -*- encoding: utf-8 -*-
gem_name = 'cxxproject_clanganalyzer'
require File.expand_path("lib/#{gem_name}/version")

Gem::Specification.new do |gem|
  gem.name          = gem_name
  gem.version       = CxxprojectClanganalyzer::VERSION

  gem.authors       = ["Christian Köstlin"]
  gem.email         = ["christian.koestlin@esrlabs.com"]
  gem.description   = %q{cxxproject-plugin to facilitate the clang static code analyzer}
  gem.summary       = %q{cxxproject-plugin to facilitate the clang static code analyzer}
  gem.homepage      = "http://marcmo.github.com/cxxproject/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'cxx'
end
