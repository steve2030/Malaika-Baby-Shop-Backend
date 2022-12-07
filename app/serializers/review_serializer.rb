class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_one :user
  has_one :product
end
