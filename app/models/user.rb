class User < ApplicationRecord
  validates_presence_of :name,
                        :email
  has_many :parties
  has_many :invites, through: :parties
end
