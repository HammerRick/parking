require 'rails_helper'

RSpec.describe ParkingTicket, type: :model do
  let(:parking_ticket) { create :parking_ticket }

  describe 'relationship validation' do
    it 'is valid with a car' do
      expect(parking_ticket.car).not_to be_nil
      expect(parking_ticket).to be_valid
    end

    it 'is invalid without a car' do
      parking_ticket.car = nil
      expect(parking_ticket.car).to be_nil
      expect(parking_ticket).to be_invalid
    end
  end

  describe 'in_at validation' do
    it 'is valid when in_at set' do
      expect(parking_ticket.in_at).not_to be_nil
      expect(parking_ticket).to be_valid
    end

    it 'is invalid when in_at not set' do
      parking_ticket.in_at = nil
      expect(parking_ticket.in_at).to be_nil
      expect(parking_ticket).to be_invalid
    end
  end

  describe 'out_at validation' do
    let(:finished_parking_ticket) { create :parking_ticket, :left }

    context 'cannot_leave_in_the_future' do
      it 'is valid when out_at set is not set in the future' do
        expect(finished_parking_ticket.out_at <= Time.zone.now).to be true
        expect(finished_parking_ticket).to be_valid
      end

      it 'is invalid when in_at not set' do
        finished_parking_ticket.out_at = Time.zone.now + 1.day
        expect(finished_parking_ticket.out_at > Time.zone.now).to be true
        expect(finished_parking_ticket).to be_invalid
      end
    end

    context 'cannot_leave_without_paying' do
      it 'is valid when out_at is set and paid is true' do
        expect(finished_parking_ticket.out_at).not_to be nil
        expect(finished_parking_ticket.paid).to be true
        expect(finished_parking_ticket).to be_valid
      end

      it 'is invalid when out_at is set and paid is false' do
        finished_parking_ticket.out_at = Time.zone.now + 1.day
        expect(finished_parking_ticket.out_at).not_to be nil
        expect(finished_parking_ticket.paid).to be true
        expect(finished_parking_ticket).to be_invalid
      end

      it 'is valid when out_at is nil and paid is false' do
        finished_parking_ticket.out_at = nil
        finished_parking_ticket.paid = false

        expect(finished_parking_ticket.out_at).to be nil
        expect(finished_parking_ticket.paid).to be false
        expect(finished_parking_ticket).to be_valid
      end
    end
  end

  describe 'left?' do
    let(:finished_parking_ticket) { create :parking_ticket, :left }

    it 'is true when out_at is set' do
      expect(finished_parking_ticket.out_at).not_to be nil
      expect(finished_parking_ticket.left?).to be true
    end

    it 'is false when out_at is not set' do
      expect(parking_ticket.out_at).to be nil
      expect(parking_ticket.left?).to be false
    end
  end


  describe 'time_stayed' do
    let(:paid_parking_ticket) {
      create :parking_ticket,
      :paid,
      in_at: Time.zone.now - 3.hours
    }

    let(:finished_parking_ticket) {
      create :parking_ticket,
      :paid,
      in_at: Time.zone.now - 3.hours,
      out_at: Time.zone.now - 2.hours
    }

    it "shows difference between in_at and current time if the car didn't left yet" do
      expect(paid_parking_ticket.left?).to be false
      expect(paid_parking_ticket.time_stayed).to be_within(3.seconds).of(3.hours)
    end

    it 'shows difference between in_at and out_at if the car already left' do
      expect(finished_parking_ticket.left?).to be true
      expect(finished_parking_ticket.time_stayed).to be_within(3.seconds).of(1.hour)
    end
  end
end
