class ChargeSucceeded
  def call(event)
    Rails.logger.log("Somebody paid us! Woohoo!")
  end
end
