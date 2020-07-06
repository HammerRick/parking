require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:car) { create :car }

  describe 'plate validations' do
    it 'is valid with a valid plate' do
      expect(car).to be_valid
    end

    it 'is invalid with a valid but already used plate' do
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

  describe 'plate normalized after save' do
    it 'do nothing on a normalized plate' do
      car = create(:car, plate: 'MMX-8456')
      expect(car.plate).to eq('MMX-8456')
    end

    it 'change downcase letters to upcase' do
      car = create(:car, plate: 'mmx-8456')
      expect(car.plate).to eq('MMX-8456')
    end

    it 'add "-" in case there is none' do
      car = create(:car, plate: 'MMX8456')
      expect(car.plate).to eq('MMX-8456')
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

  describe 'can_park?' do
    it 'is true when the car has no parking_tickets' do
      expect(car.parking_tickets.count).to eq(0)
      expect(car.can_park?).to be true
    end

    it 'is true when the car has only inactive parking_tickets' do
      create(:parking_ticket, :left, car: car)

      expect(car.parking_tickets.count).to eq(1)
      expect(car.parking_tickets.active.count).to eq(0)
      expect(car.can_park?).to be true
    end

    it 'is false when the car has an active parking_ticket' do
      create(:parking_ticket, :paid, car: car)

      expect(car.parking_tickets.count).to eq(1)
      expect(car.parking_tickets.active.count).to eq(1)
      expect(car.can_park?).to be false
    end
  end

  describe 'by_plate' do
    let!(:car) { create :car, plate: 'MMZ-4231'}

    it 'finds car using an exact match' do
      expect(Car.by_plate('MMZ-4231')).to eq(car)
    end

    it 'finds car without using "-" on the plate' do
      expect(Car.by_plate('MMZ4231')).to eq(car)
    end

    it 'finds car using lowercase letters on the plate' do
      expect(Car.by_plate('mmz-4231')).to eq(car)
    end

    it "does't find car using wrong # of letters" do
      expect(Car.by_plate('mmmz-4231')).to eq(nil)
    end

    it "does't find car using wrong # of numbers" do
      expect(Car.by_plate('mmz-42311')).to eq(nil)
    end

    it "does't find car using empty string" do
      expect(Car.by_plate('')).to eq(nil)
    end

    it "does't find car using nil" do
      expect(Car.by_plate(nil)).to eq(nil)
    end
  end
end
