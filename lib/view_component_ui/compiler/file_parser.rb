module ViewComponentUI
  module Compiler
    class FileParser
      require 'parser/current'
      require 'view_component_ui/compiler/hash_args_extractor'

      def call(file_path:)
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
      rescue Parser::SyntaxError
        Rails.logger.error("ViewComponentUI: Failed to parse #{file_path}. Skipping...")
      end

      private

      def file_is_ruby?(file_path:)
        file_path.end_with?('.rb')
      end

      def file_is_erb?(file_path:)
        file_path.end_with?('.html.erb')
      end

      def extract_ruby_from_erb(erb:)
        # Use a regex to extract ruby code from ERB
        erb.scan(/<%=?([\s\S]*?)%>/m).flatten
      end
    end
  end
end
