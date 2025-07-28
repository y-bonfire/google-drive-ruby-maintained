Gem::Specification.new do |spec|
  spec.name = 'google_drive_maintained'
  spec.version = '3.0.9'
  spec.authors = ['Hiroshi Ichikawa']
  spec.email = ['gimite+github@gmail.com']
  spec.summary = 'Access and manipulate spreadsheets and files in Google Drive easily.'
  spec.description = 'This Ruby library provides a convenient interface for reading and writing files and spreadsheets stored in Google Drive and Google Docs. It supports authentication, worksheet manipulation, and now includes background color styling and Cell object access.'
  spec.homepage = 'https://github.com/y-bonfire/google-drive-ruby-maintained'
  spec.license = 'BSD-3-Clause'
  spec.required_ruby_version = '>= 3.1'

  spec.files = ['README.md'] + Dir['lib/**/*']
  spec.require_paths = ['lib']

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/y-bonfire/google-drive-ruby-maintained",
    "changelog_uri" => "https://github.com/y-bonfire/google-drive-ruby-maintained/blob/main/CHANGELOG.md",
    "bug_tracker_uri" => "https://github.com/y-bonfire/google-drive-ruby-maintained/issues",
    "documentation_uri" => "https://rubydoc.info/gems/google_drive_ruby_maintained"
  }

  spec.add_dependency('nokogiri', ['>= 1.13', '< 2.0.0'])
  spec.add_dependency('google-apis-drive_v3', '>= 0.5.0')
  spec.add_dependency('google-apis-sheets_v4', '>= 0.4.0')
  spec.add_dependency('googleauth', ['>= 1.10'])
  spec.add_development_dependency('test-unit', ['>= 3.0.0', '< 4.0.0'])
  spec.add_development_dependency('rake', ['>= 0.8.0'])
  spec.add_development_dependency('rspec-mocks', ['>= 3.4.0', '< 4.0.0'])
end
