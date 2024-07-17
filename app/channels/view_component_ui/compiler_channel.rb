module ViewComponentUI
  class CompilerChannel < ActionCable::Channel::Base
    extend AssetHelper

    def subscribed
      stream_from "compiler_channel"
    end

    def self.broadcast_css_changed
      css_path = vite_asset_path('style.css')
      ActionCable.server.broadcast("compiler_channel", { css_path: })
    end
  end
end
