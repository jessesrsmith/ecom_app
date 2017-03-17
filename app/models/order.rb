class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  validates :name, presence: true

  def self.place_stripe_order(email, stripe_token, amount)
    customer = Stripe::Customer.create(
      email:  email,
      source: stripe_token
    )
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

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
