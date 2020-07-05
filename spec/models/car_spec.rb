require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:car) { create :car }

  describe 'plate validations' do
    it 'is valid with a valid plate' do
      expect(car).to be_valid
    end

    it 'is invalid with a valid but alredy used plate' do
      duplicated_car = car.dup
      expect(duplicated_car).to be_invalid
    end

    it 'is invalid without a plate' do
      car.plate = nil
      expect(car).to be_invalid
    end

    it 'is invalid with a blank plate' do
      car.plate = ''
      expect(car).to be_invalid
    end

    it 'is invalid with a plate without numbers' do
      car.plate = 'ASA-ADSA'
      expect(car).to be_invalid
    end

    it 'is invalid with a plate without letters' do
      car.plate = '122-3214'
      expect(car).to be_invalid
    end

    it 'is invalid with too few letters' do
      car.plate = 'AS-3214'
      expect(car).to be_invalid
    end

    it 'is invalid with too much letters' do
      car.plate = 'ASQW-3214'
      expect(car).to be_invalid
    end

    it 'is invalid with too few numbers' do
      car.plate = 'ASA-321'
      expect(car).to be_invalid
    end

    it 'is invalid with too much letters' do
      car.plate = 'ASQ-13214'
      expect(car).to be_invalid
    end
  end

  describe 'parking_tickets validations' do
    it 'is valid with no parking tickets' do
      expect(car.parking_tickets.count).to eq(0)
      expect(car).to be_valid
    end

    it 'is valid with no active parking tickets' do
      create(:parking_ticket, :left, car: car)
      expect(car.parking_tickets.count).to eq(1)
      expect(car.parking_tickets.active.count).to eq(0)
      expect(car).to be_valid
    end

    it 'is valid with one active parking tickets' do
      create(:parking_ticket, :paid, car: car)
      expect(car.parking_tickets.count).to eq(1)
      expect(car.parking_tickets.active.count).to eq(1)
      expect(car).to be_valid
    end

    it 'is invalid with one more than one active parking tickets' do
      create(:parking_ticket, :paid, car: car)
      create(:parking_ticket, :paid, car: car)

      expect(car.parking_tickets.count).to eq(2)
      expect(car.parking_tickets.active.count).to eq(2)
      expect(car).to be_invalid
    end
  end
end
