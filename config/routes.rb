Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  get 'users' => 'users#index'
  resources :users do
    collection do
      delete :bulk_destroy
      patch  :bulk_block
      patch  :bulk_unblock
    end  
  end

  post 'messages' => 'messages#create'
  
  root 'pages#home'
end
