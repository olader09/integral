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

  def generate_password(phone_number)
    p new_password = rand(0000..9999).to_s.rjust(4, '0')
    password = new_password
    save
    # sms_service = SmsPasswordService.new(phone_number, new_password)
    response = sms_service.send_request_sms_password
    return response = JSON.parse(response.body)
  end
end
