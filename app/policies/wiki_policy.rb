class WikiPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user &&user.admin?
        wikis = scope.all
      elsif user && user.premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.users.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
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
