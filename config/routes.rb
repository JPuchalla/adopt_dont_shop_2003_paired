Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'home#index'
  get '/shelters', to: 'shelters#index'
  post '/shelters', to: 'shelters#create'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#read'
  patch '/shelters/:id', to: 'shelters#update'
  delete 'shelters/:id', to: 'shelters#destroy'
  get '/shelters/:id/edit', to: 'shelters#edit'
  get '/shelters/:id/pets', to: 'shelters#pets'
  post '/shelters/:id/pets', to: 'pets#create'
  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:id/reviews', to: 'reviews#create'
  get '/shelters/:id/reviews/new', to: 'reviews#new'
  patch '/shelters/:id/reviews/:rid', to: 'reviews#update'
  delete '/shelters/:id/reviews/:rid', to: 'reviews#destroy'
  get '/shelters/:id/reviews/:rid/edit', to: 'reviews#edit'
  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#read'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id/adoptable', to: 'pets#adoptable'
  patch '/pets/:id/pending', to: 'pets#pending'
  get '/favorites', to: 'favorites#index'
  delete '/favorites', to: 'favorites#destroy'
  patch '/favorites/:pet_id', to: 'favorites#update'
  delete "/favorites/:pet_id", to: 'favorites#delete'
end
