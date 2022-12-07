class ProfileSerializer < ActiveModel::Serializer
  attributes :is_admin, :image, :phone, :address
end
