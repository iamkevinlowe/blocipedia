class Wiki < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  before_create :generate_slug
  after_initialize :default_public

  scope :visible_to, -> (user) { user && (user.premium? || user.admin?) ? all : where(private: false) }

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
