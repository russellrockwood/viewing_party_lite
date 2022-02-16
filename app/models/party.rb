class Party < ApplicationRecord
  validates_presence_of :start_date,
                        :start_time,
                        :duration,
                        :movie_id 
  belongs_to :user
  has_many :invites
end
