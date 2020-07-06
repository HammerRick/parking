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
    ticket_id = params['id']
    parking_ticket = ParkingTicket.find_by(id: ticket_id)

    if parking_ticket.nil?
      render json: { error: "Parking Ticket with id #{ticket_id} not found." }, status: :not_found
    elsif parking_ticket.paid
      render json: { message: 'Thank you, but this ticket has already been paid, new payment not accepted.' }
    else
      parking_ticket.paid = true
      render json: { message: 'Thank you, payment received!' }
    end
  end

  def out
    ticket_id = params['id']
    parking_ticket = ParkingTicket.find_by(id: ticket_id)

    if parking_ticket.nil?
      render json: { error: "Parking Ticket with id #{ticket_id} not found." }, status: :not_found
    elsif !parking_ticket.paid
      render json: { error: 'Please pay this ticket before leaving.' }, status: :bad_request
    elsif parking_ticket.out_at.nil?
      parking_ticket.out_at = Time.zone.now if parking_ticket.out_at.nil?
      render json: { message: 'Thank you for you preference, good bye!' }
    else
      render json: { message: "Your car has alredy been returned to you at #{parking_ticket.out_at}" }
    end
  end

  def history
  end
end
