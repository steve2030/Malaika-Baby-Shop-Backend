class Profile < ApplicationRecord
  belongs_to :user
  attribute :is_admin, default: false
end
