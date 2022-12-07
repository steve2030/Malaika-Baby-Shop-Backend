class User < ApplicationRecord
    has_secure_password
    has_one :profile, dependent: :destroy
    has_many :carts, dependent: :destroy
    has_many :products, through: :carts
    has_many :reviews, dependent: :destroy
    
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :password,
               length: {minimum: 6},
               if: -> {new_record? || !password.nil?}
    
end
