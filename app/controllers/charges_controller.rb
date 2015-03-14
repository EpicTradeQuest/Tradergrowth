class ChargesController < ApplicationController
    before_filter :authenticate_user!

    def new
    end

    def create
      token = params[:stripeToken]

      # Create a customer
      customer = Stripe::Customer.create(
        card: token,
        plan: 19,
        email: current_user.email
      )

      current_user.subscribed = true
      current_user.stripeid = customer.id
      current_user.save

      flash[:success] = "Thanks for subscribing, it's great to have you here."
      redirect_to trades_path
    end

    def show
    end

    def destroy
      if current_user.subscribed
        customer = Stripe::Customer.retrieve(current_user.stripeid)
        customer.subscriptions.first.delete()
        # current_user.subscribed = false
        # current_user.save
        flash[:success] = "Your subscription has been cancelled, we'll miss you."
        redirect_to trades_path
      else
        flash[:warning] = "You're not subscribed!"
        redirect_to trades_path
      end
    end

end
