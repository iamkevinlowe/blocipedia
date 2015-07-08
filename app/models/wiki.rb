class Wiki < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  before_create :generate_slug
  after_initialize :default_public

  scope :visible_to, -> (user) { user && (user.premium? || user.admin?) ? all : where(private: false) }
  scope :for_user, -> (user) { eager_load(:collaborators).where("wikis.user_id = ? OR collaborators.user_id = ?", user.id, user.id) }
  scope :for_policy_scope, -> (user) { eager_load(:collaborators).where("wikis.user_id = ? OR collaborators.user_id = ? OR wikis.private = ?", user.id, user.id, false) }


  friendly_id :title, use: :slugged
  validates_presence_of :title, :slug, :body

  private

  def generate_slug
    self.slug = title.parameterize
  end

  def default_public
    self.private ||= false
  end
end
