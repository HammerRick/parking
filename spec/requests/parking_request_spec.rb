require 'rails_helper'

RSpec.describe "Parkings", type: :request do

  describe "POST /" do
    it "returns http success" do
      get "/parking/"

      # this has to show currently parked car
      expect(JSON.parse(response.body)).to eq({ plate: 'FAA-1234' })
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /" do
    it "returns http success" do
      get "/parking/"

      expect(JSON.parse(response.body)).to eq({ plate: 'FAA-1234' })
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /park" do
    it "returns http success" do
      get "/parking/park"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /out" do
    it "returns http success" do
      get "/parking/leave"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /pay" do
    it "returns http success" do
      get "/parking/pay"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /history" do
    it "returns http success" do
      get "/parking/history"
      expect(response).to have_http_status(:success)
    end
  end

end
