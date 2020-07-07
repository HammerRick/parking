require 'rails_helper'

RSpec.describe "Helps", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/help/index"
      expect(response).to have_http_status(:success)
    end

    it "returns json with help message" do
      expetec_hash =
      {
        'message' => 'please use routes below to work with this application',
        'car_routes' => {
          'GET /cars' => 'Shows all saved cars information',
          'POST /cars' => 'send json params to create new car',
          'GET /car/id' => 'Shows car with id "id"',
          'PUT /car/id' => 'Shows car with id "id"',
        },
        'parking_routes' => {
          'POST /parking' => 'send json {"plate" => "AAA-000"} to par car with said plate',
          'PUT /parking/id/pay' => 'pay for ticket with id "id"',
          'PUT /parking/id/out' => 'Take out car parked with ticket id "id"',
          'GET /parking/plate' => 'Get parking history for car with plate "plate"',
        }
      }
      get "/help/index"
      expect(JSON.parse(response.body)).to eq(expetec_hash)
    end
  end

end
