require 'rails_helper'

RSpec.describe Car, type: :model do
  before(:each) do
    @car = create(:car)
  end

  context 'plate validations' do
    it 'is valid with a valid plate' do
      expect(@car).to be_valid
    end

    it 'is invalid without a plate' do
      @car.plate = nil
      expect(@car).to be_invalid
    end

    it 'is invalid with a blank plate' do
      @car.plate = ''
      expect(@car).to be_invalid
    end

    it 'is invalid with a plate without numbers' do
      @car.plate = 'ASA-ADSA'
      expect(@car).to be_invalid
    end

    it 'is invalid with a plate without letters' do
      @car.plate = '122-3214'
      expect(@car).to be_invalid
    end

    it 'is invalid with the too few letters' do
      @car.plate = 'AS-3214'
      expect(@car).to be_invalid
    end

    it 'is invalid with the too much letters' do
      @car.plate = 'ASQW-3214'
      expect(@car).to be_invalid
    end

    it 'is invalid with the too few numbers' do
      @car.plate = 'ASA-321'
      expect(@car).to be_invalid
    end

    it 'is invalid with the too much letters' do
      @car.plate = 'ASQ-13214'
      expect(@car).to be_invalid
    end
  end
end
