class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name ,:username, :email
  has_one :profile
end
