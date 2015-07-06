class Wiki < ActiveRecord::Base
  belongs_to :user

  after_initialize :default_public

  private

  def default_public
    self.private ||= false
  end
end
