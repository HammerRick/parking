require 'rails_helper'

RSpec.describe 'Parkings', type: :request do

  let(:valid_plate) { 'AAB-0000' }
  let(:invalid_plate) { '2AB-000' }

  describe 'post /' do
    context 'valid plate' do
      it 'returns http success' do
        post '/parking/', params: { plate: valid_plate }

        expect(response).to have_http_status(:success)
      end

      it 'renders a JSON response with the car`s plate number' do
        post '/parking/', params: { plate: valid_plate }
        parking_ticket= ParkingTicket.last

        expect(JSON.parse(response.body)).to eq(
          {
            'id' => parking_ticket.id,
            'message' => "Car with plate number #{valid_plate} sucefully parked."
          }
        )
      end
    end

    context 'invalid plate' do
      it 'returns http bad_request' do
        post '/parking/', params: { plate: invalid_plate }

        expect(response).to have_http_status(:bad_request)
      end

      it 'renders a JSON response with errors for the parking attempt' do
        post '/parking/', params: { plate: invalid_plate }

        expect(JSON.parse(response.body)).to eq(
          {
            'error' => 'invalid',
            'plate' => ['must follow the style: AAA-0000']
          }
        )
      end
    end

    context 'valid plate but car already has an active parking_ticket' do
      let(:car) { create :car, plate: valid_plate}
      let!(:parking_ticket) { create :parking_ticket, car: car}
      it 'returns http bad_request' do
        post '/parking/', params: { plate: valid_plate }

        expect(response).to have_http_status(:bad_request)
      end

      it 'renders a JSON response with errors for the parking attempt' do
        post '/parking/', params: { plate: valid_plate }

        expect(JSON.parse(response.body)).to eq(
          { 'error' => "This car is currently parked with and older ticket, id: #{parking_ticket.id}." }
        )
      end
    end
  end

  describe 'GET /' do
    it 'returns http success' do
      get '/parking/'

      expect(response).to have_http_status(:success)
    end

    xit 'returns parked cars' do
      get '/parking/'

      # TODO: implement response
    end
  end


  describe 'PUT /:id/pay' do
    context 'unpaid ticket' do
      it 'returns http success' do
        parking_ticket= create(:parking_ticket)

        put "/parking/#{parking_ticket.id}/pay"
        expect(response).to have_http_status(:success)
      end

      it 'renders a JSON response confirming payment' do
        parking_ticket= create(:parking_ticket)

        put "/parking/#{parking_ticket.id}/pay"
      end

      context 'paid ticket' do
        it 'returns http success' do
          parking_ticket= create(:parking_ticket, :paid)

          put "/parking/#{parking_ticket.id}/pay"
          expect(response).to have_http_status(:success)
        end

        it 'renders a JSON response confirming payment' do
          parking_ticket= create(:parking_ticket, :paid)

          put "/parking/#{parking_ticket.id}/pay"
          expect(JSON.parse(response.body)).to eq(
            {
              'message' => 'Thank you, but this ticket has already been paid, new payment not accepted.'
            }
          )
        end
      end

      context 'invalid ticket' do
        it 'returns http success' do
          put "/parking/-1/pay"
          expect(response).to have_http_status(:not_found)
        end

        it 'renders a JSON response with not found errors' do
          put "/parking/-1/pay"
          expect(JSON.parse(response.body)).to eq(
            {
              'error' => 'Parking Ticket with id -1 not found.'
            }
          )
        end
      end
    end
  end

  describe 'PUT /:id/out' do
    context 'paid ticket' do
      it 'returns http success' do
        parking_ticket= create(:parking_ticket, :paid)

        put "/parking/#{parking_ticket.id}/out"
        expect(response).to have_http_status(:success)
      end

      it 'renders a JSON response confirming end of transaction' do
        parking_ticket= create(:parking_ticket, :paid)

        put "/parking/#{parking_ticket.id}/out"
        expect(JSON.parse(response.body)).to eq({ message: 'Thank you for you preference, good bye!' })
      end
    end

    context 'unpaid ticket' do
      it 'returns http bad_request' do
        parking_ticket= create(:parking_ticket)

        put "/parking/#{parking_ticket.id}/out"
        expect(response).to have_http_status(:bad_request)
      end

      it 'renders a JSON response requesting payment' do
        parking_ticket= create(:parking_ticket)

        put "/parking/#{parking_ticket.id}/out"
        expect(JSON.parse(response.body)).to eq({ message: 'Error, please pay your parking ticket.' })
      end
    end
  end

  describe 'GET /:plate' do
    it 'returns http success' do
      parking_ticket= create(:parking_ticket, :paid)
      get "/parking/#{parking_ticket.plate}"
      expect(response).to have_http_status(:success)
    end

    it 'renders a JSON response with requested information' do
      parking_ticket= create(:parking_ticket, :paid)
      get "/parking/#{parking_ticket.plate}"
      expect(JSON.parse(response.body)).to eq([
        { id: parking_ticket.id, time: '25 minutes', paid: true, left: false }
      ])
    end
  end
end
