# frozen_string_literal: true

namespace :tailwindcss do
  task compile: :environment do
    require 'tailwindcss/compiler'
    Tailwindcss::Compiler::Runner.new.call
    loop do
    end
  end

  task install: :environment do
    require 'tailwindcss/installer'
    Tailwindcss::Installer.new.call
  end
end
