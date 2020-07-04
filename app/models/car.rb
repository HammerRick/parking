class Car < ApplicationRecord
  validates :plate, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z]{3}\-?\d{4}\Z/, message: 'must follow the style: AAA-0000' }

  after_save do
    plate.upcase!

    # puts '-' in the string in case there is none
    plate.gsub!(/\A[A-Z]{3}\d{4}\Z/, '\1-\2') unless plate.include? '-'
    self.plate = plate
  end
end
