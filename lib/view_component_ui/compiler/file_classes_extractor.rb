module ViewComponentUI
  module Compiler
    class FileClassesExtractor
      require 'view_component_ui/compiler/output'
      require 'view_component_ui/compiler/file_parser'

      def call(file_path:)
        ast = file_parser.call(file_path:)
        return unless ast

        hash_args = hash_args_extractor.call(ast:)
        hash_args.map { class_list_builder.call(**_1) }.flatten.compact
      end

      private

      def hash_args_extractor = HashArgsExtractor.new

      def file_parser = FileParser.new

      def class_list_builder = ClassListBuilder.new
    end
  end
end
