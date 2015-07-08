class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user && user.admin?
        scope
      elsif user.present?
        Wiki.for_policy_scope(user)
      else
        Wiki.visible_to(user)
      end
    end
  end

  def show?
    !record.private? || (user.present? && (user.premium? || user.admin?)) || record.users.include?(user)
  end

  def create?
    user.present?
  end

  def destroy?
    user.present? && user.admin?
  end
end
