class User < ApplicationRecord
  extend Enumerize
  
  validates :phone_number, presence: true, uniqueness: { case_sensitive: true }
  has_secure_password
  has_many :orders

  enumerize :role, in: %i[user], default: :user, predicates: true, scope: :shallow

  def self.from_token_request(request)
    phone_number = request.params&.[]('auth')&.[]('phone_number')
    find_by phone_number: phone_number
  end
end
