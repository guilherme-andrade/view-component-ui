# frozen_string_literal: true

require_relative 'lib/view_component_ui/version'

Gem::Specification.new do |spec|
  spec.name        = 'view-component-ui'
  spec.version     = ViewComponentUI::VERSION
  spec.authors     = ['Guilherme Andrade']
  spec.email       = ['guilherme.andrade.ao@gmail.com']
  spec.homepage    = 'https://guilherme-andrade.com/view-component-ui'
  spec.summary     = 'A UI library built with ViewComponent.'
  # spec.description = "TODO: Description of ViewComponentUI."
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.add_dependency 'deep_merge', '>= 1.0.1'
  spec.add_dependency 'dry-configurable', '>= 0.12.0'
  spec.add_dependency 'dry-initializer', '>= 3.0.0'
  spec.add_dependency 'dry-struct', '>= 1.0.0'
  spec.add_dependency 'dry-schema', '>= 1.13.0'
  spec.add_dependency 'dry-transformer', '>= 1.0.0'
  spec.add_dependency 'dry-types', '>= 1.0.0'
  spec.add_dependency 'rails', '>= 6.0.0'
  spec.add_dependency 'view_component', '>= 3.0.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
