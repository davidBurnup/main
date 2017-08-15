class ApplicationPolicy

  def rails_admin?(action)
    case action
      when :dashboard
        user.is_admin?
      when :index
        user.is_admin?
      when :show
        user.is_admin?
      when :new
        user.is_admin?
      when :edit
        user.is_admin?
      when :destroy
        user.is_admin?
      when :export
        user.is_admin?
      when :history
        user.is_admin?
      when :show_in_app
        user.is_admin?
      else
        raise ::Pundit::NotDefinedError, "unable to find policy #{action} for #{record}."
    end
  end

  # Hash of initial attributes for :new, :create and :update actions. This is optional
  def attributes_for(action)
  end

end
