class User < ApplicationRecord
  has_many :trips_owned, class_name: "Trip", foreign_key: :owner_id
  has_many :trips_assigned, class_name: "Trip", foreign_key: :assignee_id

  def fullname
    "#{firstname} #{lastname}"
  end
end
