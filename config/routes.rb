require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'trackings#new'

  resources :trackings do
  	collection do
			get 'preview'
		end
  end

	mount Sidekiq::Web => '/sidekiq'
end
