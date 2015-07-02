class WikiPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user.present? && user.role == 'admin'
  end
end