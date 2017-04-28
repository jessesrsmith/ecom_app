require "stripe"

class ChargeService
  def self.create_customer(email, stripe_token)
    customer = Stripe::Customer.create(
      email:  email,
      source: stripe_token
    )
  end

  def self.place_order(customer, amount)
    charge = Stripe::Charge.create(
      customer:    customer.id,
      amount:      amount,
      description: "Rails Stripe customer",
      currency:    "usd"
    )
  rescue
    false
  end
end
