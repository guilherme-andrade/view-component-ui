module ViewComponentUI
  class ActiveLinkComponent < LinkComponent
    prop :exact, Types::Bool.default(false).optional
    prop :active, Types::Bool.optional

    default_props color: proc { active? ? 'blue-900' : 'blue-600' } # tw-text-blue-900 tw-text-blue-600

    def active?
      return false if props[:disabled].present?
      return active if props[:active].present?
      return false if request.path.blank? || props[:to].blank?
      return request.path == to if props[:exact]

      request.path.include?(props[:to])
    end
  end
end
