class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user
  attribute :status, default: "pending"
end
