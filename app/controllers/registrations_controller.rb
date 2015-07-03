class RegistrationsController < Devise::RegistrationsController
  def edit
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name || current_user.email}",
      amount: Amount.default
    }
  end
end
