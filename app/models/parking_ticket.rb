class ParkingTicket < ApplicationRecord
  belongs_to :car
  validates_associated :car
  validates :in_at, presence: true

  validate :cannot_leave_in_the_future,
    :cannot_leave_without_paying

  def cannot_leave_in_the_future
    if out_at.present? && out_at > Time.zone.now
      errors.add(:paid, 'leave datime cannot be in the future')
    end
  end

  def cannot_leave_without_paying
    if out_at.present? && !paid
      errors.add(:paid, "can't leave without paying")
    end
  end

  def left?
    return true if out_at.present?

    false
  end

  def time_stayed
    delta_time = if left?
      out_at - in_at
    else
    Time.zone.now - in_at
    end

    Time.at(delta_time).utc.strftime '%H:%M'
    # TODO: fix this so if you go over a day it doesn't reset to 0
  end
end
