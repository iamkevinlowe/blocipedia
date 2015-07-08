class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name || current_user.email}",
      amount: Amount.default
    }
  end

  def create

    current_user.upgrade(params[:stripeToken])

    flash[:success] = "Thanks for all the money, #{current_user.name || current_user.email}! Feel free to pay me again."
    redirect_to user_path(current_user) # or wherever

    # Stripe will send back CardErrors, with friendly messages when soemthing goes wrong.
    # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
