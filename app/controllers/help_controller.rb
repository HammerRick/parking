class HelpController < ApplicationController
  def index
    help_hash =
    {
      message: 'please use routes below to work with this application',
      car_routes: {
        'GET /cars' => 'Shows all saved cars information',
        'POST /cars' => 'send json params to create new car',
        'GET /car/id' => 'Shows car with id "id"',
        'PUT /car/id' => 'Shows car with id "id"',
      },
      parking_routes: {
        'POST /parking' => 'send json {"plate" => "AAA-000"} to par car with said plate',
        'PUT /parking/id/pay' => 'pay for ticket with id "id"',
        'PUT /parking/id/out' => 'Take out car parked with ticket id "id"',
        'GET /parking/plate' => 'Get parking history for car with plate "plate"',
      }
    }

    render json: help_hash
  end
end
