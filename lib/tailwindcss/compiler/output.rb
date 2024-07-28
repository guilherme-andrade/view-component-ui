require 'fileutils'

module Tailwindcss
  module Compiler
    class Output
      def add_entry(file_path:, classes:)
        return if classes.blank?

        path = compiled_file_path(file_path:)
        create_folder(file_path: path)

        path = path += '.classes'
        File.open(path, 'wb') do |file|
          file << classes.join("\n")
        end
        File.delete(path) if File.empty?(path)
      end

      def output_path
        Tailwindcss.config.output_path.call.to_s
      end

      def create_folder(file_path:)
        dir_name = File.dirname(file_path)
        FileUtils.mkdir_p(dir_name)
      end

      def compiled_file_path(file_path:)
        Tailwindcss.config.content.each do |folder|
          return File.join(output_path, file_path.delete_prefix(folder.to_s)) if file_path.include?(folder.to_s)
        end
      end
    end
  end
end
