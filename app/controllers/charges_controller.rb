class ChargesController < ApplicationController
    before_filter :authenticate_user!

    def new
    end

    def create
      token = params[:stripeToken]

      # Create a customer
      customer = Stripe::Customer.create(
        card: token,
        plan: 1986,
        email: current_user.email
      )

      current_user.subscribed = true
      current_user.stripeid = customer.id
      current_user.save

      flash[:success] = "Thanks for subscribing, it's great to have you here."
      redirect_to trades_path
    end
end
