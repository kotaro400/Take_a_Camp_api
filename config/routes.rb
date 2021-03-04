Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :api do
    resources :users, only: [:create]
    resource :session, only: [:create, :show]
    resources :cells, only: [:index]
    resources :votes, only: [:create]
  end
end
