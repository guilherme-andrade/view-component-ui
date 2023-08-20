module ViewComponentUI
  module Compiler
    class Runner
      require 'parser/current'
      require 'listen'
      require 'view_component_ui/compiler/output'

      def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        output = Output.new

        ViewComponentUI.config.content.each do |location|
          listener = Listen.to(File.dirname(location.to_s), only: /\.(rb|erb)$/) do |modified, added, removed|
            (modified + added + removed).each do |file_path|
              ast = ast_from_file(file_path:)
              next unless ast

              output.add_entry(file_path:, classes: HashArgsExtractor.new.call(ast:))
            end

            system 'yarn build'
          end

          Dir.glob("#{location}/**/*").each do |file_path|
            ast = ast_from_file(file_path:)
            next unless ast

            output.add_entry(file_path:, classes: HashArgsExtractor.new.call(ast:))
          end

          listener.start
        end

        system 'yarn build'
      end

      def ast_from_file(file_path:)
        code = if file_is_ruby?(file_path:)
                 File.read(file_path)
               elsif file_is_erb?(file_path:)
                 extract_ruby_from_erb(erb: File.read(file_path)).join("\n")
               else
                 return
               end

        buffer = Parser::Source::Buffer.new(file_path)
        buffer.source = code

        parser = Parser::CurrentRuby.new
        parser.parse(buffer)
      end

      def file_is_ruby?(file_path:)
        file_path.end_with?('.rb')
      end

      def file_is_erb?(file_path:)
        file_path.end_with?('.html.erb')
      end

      def extract_ruby_from_erb(erb:)
        # Use a regex to extract ruby code from ERB
        erb.scan(/<%([\s\S]*?)%>/m).flatten
      end
    end
  end
end
