require 'view_component_ui'
require 'view_component_ui/compiler'

require 'rspec/snapshot'

RSpec.describe ViewComponentUI::Compiler::FileClassesExtractor do
  subject { described_class.new.call(file_path:) }

  let(:file_path) { File.join('spec/test_subjects/button_component_example.rb') }

  it 'returns a list of possible classes by inferring what could be passed to the component' do
    expect(subject).to match_snapshot('spec/test_subjects/button_component_example')
  end
end
