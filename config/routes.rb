Rails.application.routes.draw do
  scope controller: 'parking' do
    get '', to: 'parking#index'
    post '', to: 'parking#in'
    put ':id/pay', to: 'parking#pay'
    put ':id/out', to: 'parking#out'
    get ':plate', to: 'parking#history'
  end

  resources :cars
end
