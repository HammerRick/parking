require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/cars', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Car. As you add validations to Car, be sure to
  # adjust the attributes here as well.

  let!(:car) { create :car }

  let(:valid_attributes) {
    { plate: 'AAB-0000' }
  }

  let(:invalid_attributes) {
    { plate: '2AB-000' }
  }

  describe 'GET /index' do
    it 'renders a successful response' do
      get cars_url, as: :json
      expect(response).to be_successful
    end

    it 'renders a JSON response with a list of cars' do
      get cars_url, as: :json
      expect(response.body).to eq([car].to_json)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get car_url(car), as: :json
      expect(response).to be_successful
    end

    it 'renders a JSON response with the car data' do
      get car_url(car), as: :json
      expect(response.body).to eq(car.to_json)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Car' do
        expect {
          post cars_url,
               params: { car: valid_attributes }, as: :json
        }.to change(Car, :count).by(1)
      end

      it 'returns http success for the new car' do
        post cars_url,
             params: { car: valid_attributes }, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'renders a JSON response with the new car' do
        post cars_url,
             params: { car: valid_attributes }, as: :json

        expect(response.body).to eq(Car.last.to_json)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Car' do
        expect {
          post cars_url,
               params: { car: invalid_attributes }, as: :json
        }.to change(Car, :count).by(0)
      end

      it 'returns http unprocessable_entity for the new car' do
        post cars_url,
             params: { car: invalid_attributes }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'renders a JSON response with errors for the new car' do
        post cars_url,
             params: { car: invalid_attributes }, as: :json

        expect(response.body).to eq({ 'plate': ['must follow the style: AAA-0000'] }.to_json)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) {
        { plate: 'AAB-0001' }
      }

      it 'updates the requested car' do
        patch car_url(car),
              params: { car: new_attributes }, as: :json
        car.reload
        expect(car.plate).to eq('AAB-0001')
      end

      it 'renders a JSON response with the car' do
        patch car_url(car),
              params: { car: new_attributes }, as: :json

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'returns http bad_request' do
        car = Car.create! valid_attributes
        patch car_url(car),
              params: { car: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders a JSON response with errors for the car' do
        car = Car.create! valid_attributes
        patch car_url(car),
              params: { car: invalid_attributes }, as: :json
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
