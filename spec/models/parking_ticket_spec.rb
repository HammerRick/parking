require 'rails_helper'

RSpec.describe ParkingTicket, type: :model do
  before(:each) do
    @parking_ticket = create!(:parking_ticket)
  end

  context 'relationship validation' do
    it 'is valid with a car' do
      expect(@parking_ticket.car).not_to be_nil
      expect(@parking_ticket).to be_valid
    end

    it 'is invalid without a car' do
      @parking_ticket.car = nil
      expect(@parking_ticket.car).to be_nil
      expect(@parking_ticket).to be_valid
    end
  end
end