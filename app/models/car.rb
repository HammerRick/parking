class Car < ApplicationRecord
  has_many :parking_tickets

  validates :plate, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z]{3}\-?\d{4}\Z/, message: 'must follow the style: AAA-0000' }
  validate :can_only_have_one_active_parking_ticket

  after_save do
    plate = self.plate.upcase

    # puts '-' in the string in case there is none
    plate.gsub!(/\A[A-Z]{3}\d{4}\Z/, '\1-\2') unless plate.include? '-'
    self.plate = plate
  end

  def can_only_have_one_active_parking_ticket
    errors.add(:parking_tickets, "can't have more than one active") if parking_tickets.active.count > 1
  end

  def can_park?
    if parking_tickets > 0
      parking_tickets.last.left?
    else
      true
    end
  end
end
