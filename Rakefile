require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |gem|
  gem.name        = "hiera-dyml"
  gem.version     = "0.0.4"
  gem.summary     = "DeepMerge YAML backend  for Hiera"
  gem.email       = "johan.bakker@panifex.nl"
  gem.author      = "Johan Bakker"
  gem.homepage    = "http://github.com/provonet/hiera-dyml"
  gem.description = "Hiera YAML backend with support for deep merging of hashes"

  gem.require_path = "lib"
  gem.files        = Dir["lib/**/*"].select { |f| File.file? f }

  gem.add_dependency('hiera', '>=1.0.0')
  gem.add_dependency('deep_merge', '>=1.0.0')
end

Rake::GemPackageTask.new(spec) do |pkg|
    pkg.need_tar = true
end

task :default => :repackage
