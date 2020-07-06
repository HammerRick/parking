require 'rails_helper'
require 'plate_normalizer'

RSpec.describe PlateNormalizer, type: :class do
  describe 'plate normalized after save' do
    it 'do nothing on a normalized plate' do
      plate = PlateNormalizer.normalize_plate('MMX-8456')
      expect(plate).to eq('MMX-8456')
    end

    it 'change downcase letters to upcase' do
      plate = PlateNormalizer.normalize_plate('mmx-8456')
      expect(plate).to eq('MMX-8456')
    end

    it 'add "-" in case there is none' do
      plate = PlateNormalizer.normalize_plate('MMX8456')
      expect(plate).to eq('MMX-8456')
    end
  end
end
