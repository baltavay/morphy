# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "morphy"
  spec.version       = "0.0.2"
  spec.date          = '2015-05-29'
  spec.authors       = ["Maksatbek Mansurov"]
  spec.email         = ["maksat.mansurov@gmail.com"]
  spec.description   = %q{Morphological analyzer (POS tagger + inflection engine) for Russian language in ruby. Inspired by pymorphy2}
  spec.summary       = %q{Morphological analyzer for Russian language in ruby. Inspired by pymorphy2}
  spec.homepage      = "https://github.com/baltavay/morphy"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]    
  spec.add_development_dependency 'dawg', '~> 0.0', '>= 0.0.2'
end
