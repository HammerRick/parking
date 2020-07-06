class Car < ApplicationRecord
  require 'plate_normalizer'

  has_many :parking_tickets

  validates :plate, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z]{3}\-?\d{4}\Z/, message: 'must follow the style: AAA-0000' }
  validate :can_only_have_one_active_parking_ticket

  before_save do
    self.plate = PlateNormalizer.normalize_plate(plate) unless plate.nil?
  end

  def self.by_plate(plate)
    find_by_plate PlateNormalizer.normalize_plate(plate)
  end

  def can_only_have_one_active_parking_ticket
    errors.add(:parking_tickets, "can't have more than one active") if parking_tickets.active.count > 1
  end

  def can_park?
    if parking_tickets.count.positive?
      parking_tickets.last.left?
    else
      true
    end
  end
end
