module ViewComponentUI
  module Compiler
    class Runner
      require 'listen'
      require 'view_component_ui/compiler/file_classes_extractor'

      def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        output = Output.new
        file_classes_extractor = FileClassesExtractor.new

        ViewComponentUI.config.content.each do |location|
          listener = Listen.to(File.dirname(location.to_s), only: /\.(rb|erb)$/) do |modified, added, removed|
            (modified + added + removed).each do |file_path|
              classes = file_classes_extractor.call(file_path:)
              next unless classes

              output.add_entry(file_path:, classes:)
            end

            ViewComponentUI.compiler.on_compile.call
          end

          Dir.glob("#{location}/**/*").each do |file_path|
            classes = file_classes_extractor.call(file_path:)
            next unless classes

            output.add_entry(file_path:, classes:)
          end

          listener.start
        end

        ViewComponentUI.compiler.on_compile.call
      end
    end
  end
end
