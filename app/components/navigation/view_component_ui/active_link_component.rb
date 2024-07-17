module ViewComponentUI
  class ActiveLinkComponent < LinkComponent
    prop :exact, default: false, optional: true
    prop :active, default: nil, optional: true
    alias exact? exact

    default_props color: proc { active? ? 'blue-900' : 'blue-600' } # tw-text-blue-900 tw-text-blue-600

    def active?
      return active if active.present?
      return false if request.path.blank? || to.blank?
      return request.path == to if exact?

      request.path.include?(to)
    end
  end
end
