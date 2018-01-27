Gem::Specification.new do |s|
  s.name = 'teachable-api-client'
  s.version = '0.0.1'
  s.license = 'GPL-3.0'
  s.author = 'Alexander Carpenter'
  s.email = 'alexander.h.carpenter@gmail.com'
  s.summary = 'Simple Gem to containing a client to interact with Teachable\'s Todoable API'
  # metadata keys must be strings
  s.metadata = { 'source_code_uri' => 'https://github.com/aCarpenter/teachable-api-client' }
  # rest-client requires ~> 2.0
  s.required_ruby_version = '~> 2.0'
  s.files = []
  s.add_runtime_dependency 'rest-client', '~> 2.0'

  s.add_development_dependency 'rspec', '~> 3.7'
  s.add_development_dependency 'rubocop', '~> 0.52.1'
end
