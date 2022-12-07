class Product < ApplicationRecord
   attribute :in_stock, default: true
   has_many :carts, dependent: :destroy
   has_many :orders, through: :order_items
   has_many :users, through: :carts
   has_many :reviews, dependent: :destroy
   
   validates :title, presence: true, uniqueness: true
   validates :description, presence: true
   validates :image, presence: true
   validates :price, presence: true

end
