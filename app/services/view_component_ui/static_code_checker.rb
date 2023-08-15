module ViewComponentUI
  class StaticCodeChecker
    require 'parser/current'

    def call # rubocop:disable Metrics/MethodLength
      # Loop through the provided file locations
      ViewComponentUI.config.content.each do |location|
        # Use the Dir.glob method to get all the files matching the location pattern
        Dir.glob(location).each do |file_path|
          # Read the file content
          code = if file_is_ruby?(file_path)
                   File.read(file_path)
                 elsif file_is_erb?(file_path)
                   extract_ruby_from_erb(File.read(file_path)).join("\n")
                 else
                   next
                 end

          buffer = Parser::Source::Buffer.new(file_path)
          buffer.source = code

          parser = Parser::CurrentRuby.new
          ast = parser.parse(buffer)

          # Extract hash patterns from the current file's AST
          extract_hash_from_node(ast)
        end
      end
    end

    def file_is_ruby?(file_path)
      file_path.end_with?('.rb')
    end

    def file_is_erb?(file_path)
      file_path.end_with?('.html.erb')
    end

    def extract_ruby_from_erb(erb_content)
      # Use a regex to extract ruby code from ERB
      erb_content.scan(/<%([\s\S]*?)%>/m).flatten
    end

    # Define the method to extract relevant hashes from the AST node
    def extract_hash_from_node(node) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize
      return unless node

      case node.type
      when :send
        if node.children[0] && node.children[0].type == :const && node.children[0].children[1].match?(/Component/) && node.children[1] == :new
          node.children[2..].select { |child| child.type == :hash }.each do |hash_node|
            puts hash_node.location.expression.source
          end
        end
      when :lvasgn
        if node.children[0] == :args
          node.children[1..].select { |child| child.type == :hash }.each do |hash_node|
            puts hash_node.location.expression.source
          end
        end
      end

      node.children.each do |child|
        extract_hash_from_node(child) if child.is_a?(Parser::AST::Node)
      end
    end
  end
end
