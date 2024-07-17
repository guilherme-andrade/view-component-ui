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
            Rails.logger.info 'Recompiling ViewComponentUI...'
            Rails.logger.info "Modified: #{modified}"
            Rails.logger.info "Added: #{added}"
            Rails.logger.info "Removed: #{removed}"
            (modified + added + removed).each do |file_path|
              classes = file_classes_extractor.call(file_path:)
              next unless classes.present?

              output.add_entry(file_path:, classes:)
            end

            system 'yarn build:view-component-ui'
            ::ViewComponentUI::CompilerChannel.broadcast_css_changed
          end

          Dir.glob("#{location}/**/*").each do |file_path|
            classes = file_classes_extractor.call(file_path:)
            next unless classes.present?

            output.add_entry(file_path:, classes:)
          end

          listener.start
        end

        system 'yarn build:view-component-ui'
        ::ViewComponentUI::CompilerChannel.broadcast_css_changed
      end
    end
  end
end
