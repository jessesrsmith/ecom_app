class Product < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true,
             numericality: { greater_than_or_equal_to: 0.01 }

  def self.latest
    Product.order(:updated_at).last
  end
end
