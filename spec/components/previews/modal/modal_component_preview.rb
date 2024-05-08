module Modal
  class ModalComponentPreview < ViewComponent::Preview
    def default
      render ViewComponentUI::ModalComponent.new do |modal|
        modal.with_head do
          "asdsad"
        end
      end
    end
  end
end
