class PlateNormalizer
  class << self
    def normalize_plate(plate)
      return if plate.nil?

      # puts '-' in the string in case there is none
      plate.gsub!(/\A([a-zA-Z]{3})(\d{4})\Z/, '\1-\2') unless plate.include? '-'

      plate.upcase
    end
  end
end
