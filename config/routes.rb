Rails.application.routes.draw do
  # devise_for :users
  namespace :api do
    namespace :v1 do
      constraints format: :json do
        devise_for :users
        post  'users/sign_up' => 'registrations#create'
        post  'books/search' => 'books#search'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
