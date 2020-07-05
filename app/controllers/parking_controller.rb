class ParkingController < ApplicationController
  def index
  end

  def in
    plate = params['plate']
    car = Car.find_or_create_by(plate: plate)

    if car.new_record?
      render json: { error: 'invalid' }.merge(car.errors.messages), status: :bad_request
    elsif car.can_park?
      parking_ticket = car.parking_tickets.create(in_at: Time.zone.now)
      render json: { id: parking_ticket.id, message: "Car with plate number #{car.plate} sucefully parked."},
             status: :created
    else
      active_ticket_id = car.parking_tickets.active.last.id
      render json: { error: "This car is currently parked with and older ticket, id: #{active_ticket_id}." },
             status: :bad_request
    end
  end

  def pay
  end

  def out
  end

  def history
  end
end
