Rails.application.routes.draw do

  get '/home',to:'employee_pages#home'

  get '/details',to:'employee_pages#details'

  get  '/signup',  to: 'employees#new'

  post '/signup',  to: 'employees#create'

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'

  delete '/logout',  to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'  
  resources:employees
end
