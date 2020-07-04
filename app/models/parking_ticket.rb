class ParkingTicket < ApplicationRecord
  belongs_to :car
  validates_associated :car
end
