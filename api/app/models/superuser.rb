class Superuser < ApplicationRecord
  extend Enumerize

  validates :login, presence: true, uniqueness: { case_sensitive: true }
  has_secure_password

  enumerize :role, in: %i[admin], default: :admin, predicates: true, scope: :shallow

  def self.from_token_request(request)
    login = request.params&.[]('auth')&.[]('login')
    find_by login: login
  end

end
