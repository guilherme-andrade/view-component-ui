require 'active_support/core_ext/object/blank'

require 'view_component_ui/compiler/class_list_builder'

module ViewComponentUI
  module Compiler
    class HashArgsExtractor
      def call(ast:)
        extract_hash_arguments_from_ast_nodes(ast)
      end

      private

      def extract_hash_arguments_from_ast_nodes(node)
        hash_args = []
        return unless node.is_a?(Parser::AST::Node)

        if node.type == :send
          hash_args += extract_hashes(node).flatten(10)
        end

        node.children.each do |child|
          next unless child.is_a?(Parser::AST::Node)

          hash_args += extract_hash_arguments_from_ast_nodes(child)
        end

        hash_args.flatten.compact
      end

      def extract_hashes(node)
        scan_for_hash_children(node).each_with_object([]) { |hash_node, acc| extract_value(hash_node, acc) }.compact
      end

      def scan_for_hash_children(node)
        node.children[2..].select { |child| child.type == :hash }
      end

      def extract_value(node, acc)
        node.children.select { |n| n.type == :pair }.each do |key_value_node|
          key_node = key_value_node.children.first
          value_node = key_value_node.children.last
          value = pair_node_value(key_node, value_node)

          acc << value if value.present?
        end
      end

      def pair_node_value(key_node, value_node)
        key = source_code(key_node)
        case value_node.type
        when :hash
          hashes = []
          extract_value(value_node, hashes)
          hashes.flatten.map { |h| { key.to_sym => h } }
        when :int, :str, :sym
          { key.to_sym => node_text(value_node) }
        else
          extract_color_scheme_calls(key_node, value_node)
        end
      end

      def extract_color_scheme_calls(key_node, value_node)
        value = source_code(value_node)
        return unless value.include?('color_scheme_token')

        match = /color_scheme_token\((\d+)\)/.match(value)
        return unless match

        weight = match[1].to_i
        ViewComponentUI.config.theme.color_scheme.values.map do |color|
          { source_code(key_node).to_sym => "#{color}-#{weight}" }
        end
      end

      def node_text(node)
        source_code(node).delete(':').delete('\'').to_s
      end

      def source_code(node)
        node.location.expression.source
      end
    end
  end
end
