Rails.configuration.stripe = {
  :publishable_key => ENV['publishable_key'],
  :secret_key => ENV['secret_key']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.configure do |events|
  events.subscribe 'customer.subscription.deleted' do |event|
    subscriber = User.find_by_stripeid(event.data.object.customer)
    subscriber.update_attribute(:subscribed, false)
    head 200
  end

  events.subscribe 'invoice.payment_succeeded' do |event|
    subscriber = User.find_by_stripeid(event.data.object.customer)
    subscriber.update_attribute(:subscribed, true)
    puts "Payment received"
    head 200
  end


  events.subscribe 'invoice.payment_failed' do |event|
    #subscriber = User.stripeid.find(event.data.object.customer)
    #subscriber.update_attribute(:subscribed, false)
    head 200
  end
end