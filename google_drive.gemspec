Gem::Specification.new do |s|
  s.name = 'google_drive_maintained'
  s.version = '3.0.8'
  s.authors = ['Hiroshi Ichikawa']
  s.email = ['gimite+github@gmail.com']
  s.summary = 'Access and manipulate spreadsheets and files in Google Drive easily.'
  s.description = 'This Ruby library provides a convenient interface for reading and writing files and spreadsheets stored in Google Drive and Google Docs. It supports authentication, worksheet manipulation, and now includes background color styling and Cell object access.'
  s.homepage = 'https://github.com/y-bonfire/google-drive-ruby-maintained'
  s.rubygems_version = '1.2.0'
  s.license = 'BSD-3-Clause'
  s.required_ruby_version = '>= 3.0.0'

  s.files = ['README.md'] + Dir['lib/**/*']
  s.require_paths = ['lib']

  s.add_dependency('nokogiri', ['>= 1.5.3', '< 2.0.0'])
  s.add_dependency('google-apis-drive_v3', '~> 0.5', '>= 0.5.0')
  s.add_dependency('google-apis-sheets_v4', '~> 0.4', '>= 0.4.0')
  s.add_dependency('googleauth', ['~> 0.5', '>= 0.5.0'])
  s.add_development_dependency('test-unit', ['>= 3.0.0', '< 4.0.0'])
  s.add_development_dependency('rake', ['~> 0.8', '>= 0.8.0'])
  s.add_development_dependency('rspec-mocks', ['>= 3.4.0', '< 4.0.0'])
end
