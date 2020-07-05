Rails.application.routes.draw do
  scope controller: 'parking' do
    get '', to: 'parking#index'
    post 'park'
    put ':id/out', to: 'parking#out'
    put ':id/pay', to: 'parking#pay'
    get ':plate', to: 'parking#history'
  end

  resources :cars
end
