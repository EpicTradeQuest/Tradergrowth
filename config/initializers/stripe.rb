Rails.configuration.stripe = {
  :publishable_key => ENV['publishable_key'],
  :secret_key => ENV['secret_key']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.deleted' do |event|
    subscription = User.stripeid.find(event.data.object.customer)
    subscription.update_attribute(:subscribed, false)
    head 200
  end

  events.subscribe 'invoice.payment.received' do |event|
    subscription = User.stripeid.find(event.data.object.customer)
    #email the customer the invoice
    head 200
  end
end