class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :wikis, through: :collaborators

  after_initialize :default_role

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def standard?
    role == 'standard'
  end

  def upgrade(stripeToken)
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: self.email,
      card: stripeToken
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is Not the user_id in your app
      amount: Amount.default,
      description: "BigMoney Membership - #{self.name || self.email}",
      currency: 'usd'
    )

    self.update_attributes!(role: 'premium')
  end

  private

  def default_role
    self.role ||= 'standard'
  end
end
