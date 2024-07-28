module Tailwindcss
  module Compiler
    class Runner
      require 'listen'
      require 'tailwindcss/compiler/file_classes_extractor'
      require 'tailwindcss/compiler/output'
      require 'tailwindcss/compiler/connection'
      require 'tailwindcss/compiler/channel'

      def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        output = Output.new
        file_classes_extractor = FileClassesExtractor.new

        content.each do |location|
          if Tailwindcss.config.watch_content
            listener = Listen.to(File.dirname(location.to_s), only: /\.(rb|erb)$/) do |modified, added, removed|
              Tailwindcss.config.logger.info 'Recompiling Tailwindcss...'
              Tailwindcss.config.logger.info "Modified: #{modified}"
              Tailwindcss.config.logger.info "Added: #{added}"
              Tailwindcss.config.logger.info "Removed: #{removed}"
              (modified + added + removed).each do |file_path|
                classes = file_classes_extractor.call(file_path:)
                next unless classes.present?

                output.add_entry(file_path:, classes:)
              end

              system 'yarn build:view-component-ui'
              Channel.broadcast_css_changed
            end

            listener.start
          end

          Dir.glob("#{location}/**/*").each do |file_path|
            next unless File.file?(file_path)

            classes = file_classes_extractor.call(file_path:)
            next unless classes.present?

            output.add_entry(file_path:, classes:)
          end
        end

        system 'yarn build:view-component-ui'
        Channel.broadcast_css_changed
      end

      private

      def content
        Tailwindcss.config.content.respond_to?(:call) ? Tailwindcss.config.content.call : Tailwindcss.config.content
      end
    end
  end
end
