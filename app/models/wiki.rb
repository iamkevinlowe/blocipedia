class Wiki < ActiveRecord::Base
  belongs_to :user

  after_initialize :default_public

  scope :visible_to, -> (user) { user && (user.premium? || user.admin?) ? all : where(private: false) }

  def private_icon
    if private
      "<span class='glyphicon glyphicon-lock'
      style='color: red; font-size: 0.6em;'>
      </span>".html_safe
    else
      ""
    end
  end

  private

  def default_public
    self.private ||= false
  end
end
