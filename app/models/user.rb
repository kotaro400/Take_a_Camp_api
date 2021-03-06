class User < ApplicationRecord
  has_secure_password
  
  has_many :votes
  belongs_to :team

  validates :password, presence: true, length: { in: 6..20 }
  validates :name, presence: true, uniqueness: { case_sensitive: true }
  validates_format_of :password, with: /\A[a-zA-Z0-9]+\z/
end
