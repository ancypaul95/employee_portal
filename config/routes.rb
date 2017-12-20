Rails.application.routes.draw do

  get '/adminlogin',to:'adminsession#new'

  post '/adminlogin',to:'adminsession#create'

  delete '/adminlogout',to:'adminsession#destroy'

  get '/adminhome',to:'admin#home'

  get '/index',to:'admin#create'

  get '/home',to:'employees#home'

  get  '/signup',  to: 'employees#new'

  post '/signup',  to: 'employees#create'

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'

  delete '/logout',  to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'employees#new'  
  resources :employees 
end
