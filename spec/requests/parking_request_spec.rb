require 'rails_helper'

RSpec.describe 'Parkings', type: :request do

  describe 'POST /' do
    context 'valid plate' do
      it 'returns http success' do
        POST '/parking/', params: { plate: 'FAA-1234' }

        expect(response).to have_http_status(:success)
      end

      it 'renders a JSON response with the car`s plate number' do
        POST '/parking/', params: { plate: 'FAA-1234' }
        pt = ParkingTicker.last

        expect(JSON.parse(response.body)).to eq({ id: pt.id, message: 'Car with plate number FAA-1234 sucefully parked.' })
      end
    end

    context 'invalid plate' do
      it 'returns http bad_request' do
        POST '/parking/'

        expect(response).to have_http_status(:bad_request)
      end

      it 'renders a JSON response with errors for the parking attempt' do
        POST '/parking/'

        expect(JSON.parse(response.body)).to eq({ plate: 'FAA-1234' })
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
        pt = create(:parking_ticket)

        put "/parking/#{pt.id}/pay"
        expect(response).to have_http_status(:success)
      end

      it 'renders a JSON response confirming payment' do
        pt = create(:parking_ticket)

        put "/parking/#{pt.id}/pay"
        expect(JSON.parse(response.body)).to eq({ message: 'Thank you, payment received!' })
      end
    end

    context 'paid ticket' do
      it 'returns http bad_request' do
        pt = create(:parking_ticket)

        put "/parking/#{pt.id}/pay"
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns http success' do
        pt = create(:parking_ticket)

        put "/parking/#{pt.id}/pay"
        expect(JSON.parse(response.body)).to eq({ message: 'Error, please pay your parking ticket.' })
      end
    end
  end

  describe 'PUT /:id/out' do
    context 'paid ticket' do
      it 'returns http success' do
        pt = create(:parking_ticket, :paid)

        put "/parking/#{pt.id}/out"
        expect(response).to have_http_status(:success)
      end

      it 'renders a JSON response confirming end of transaction' do
        pt = create(:parking_ticket, :paid)

        put "/parking/#{pt.id}/out"
        expect(JSON.parse(response.body)).to eq({ message: 'Thank you for you preference, good bye!' })
      end
    end

    context 'unpaid ticket' do
      it 'returns http bad_request' do
        pt = create(:parking_ticket)

        put "/parking/#{pt.id}/out"
        expect(response).to have_http_status(:bad_request)
      end

      it 'renders a JSON response requesting payment' do
        pt = create(:parking_ticket)

        put "/parking/#{pt.id}/out"
        expect(JSON.parse(response.body)).to eq({ message: 'Error, please pay your parking ticket.' })
      end
    end
  end

  describe 'GET /:plate' do
    it 'returns http success' do
      pt = create(:parking_ticket, :paid)
      get "/parking/#{pt.plate}"
      expect(response).to have_http_status(:success)
    end

    it 'renders a JSON response with requested information' do
      pt = create(:parking_ticket, :paid)
      get "/parking/#{pt.plate}"
      expect(JSON.parse(response.body)).to eq([
        { id: pt.id, time: '25 minutes', paid: true, left: false }
      ])
    end
  end
end
