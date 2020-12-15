require_relative 'lib/skeletons/version'

Gem::Specification.new do |spec|
  spec.name          = "skeleton_wars"
  spec.version       = SkeletonWars::VERSION
  spec.authors       = ["Ghostily-Boo"]
  spec.email         = ["grace.rl.qin@gmail.com"]

  spec.summary       = "Learn different skeletal components of different species."
  spec.description   = "CLI to view pictures and components of bones or skeletal structures of horses, dogs, humans."
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'json'
  spec.add_development_dependency 'tty-prompt'
  spec.add_development_dependency 'open-uri'
end
