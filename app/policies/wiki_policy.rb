class WikiPolicy < ApplicationPolicy
  def show?
    !record.private? || (user.present? && (user.premium? || user.admin?))
  end

  def create?
    user.present?
  end

  def destroy?
    user.present? && user.admin?
  end
end
