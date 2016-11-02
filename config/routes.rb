require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'trackings#new'

  resources :trackings do
  	collection do
			get'avaibility_chart'
		end
  end
  # get '/availabilities/chart', to: 'availabilities#chart', as: 'availabilities_chart'

	mount Sidekiq::Web => '/sidekiq'
end
