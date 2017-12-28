Rails.application.routes.draw do

  get '/adminlogin',to:'adminsession#new'

  post '/adminlogin',to:'adminsession#create'

  delete '/adminlogout',to:'adminsession#destroy'

  get '/adminhome',to:'admin#home'

  get '/adminemployee',to:'admin#index'

  get '/adminedit',to:'admin#edit'

  patch '/adminedit', to: 'admin#update'

  get '/adminproject',to:'admin#projects'

  get  '/addemployee',  to: 'employees#new'
  
  post '/addemployee',  to: 'employees#create'

  get '/showemployee',to:'employees#show'
  
  post '/showemployee',to:'employees#show'

  get '/home',to:'employees#home'

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'

  delete '/logout',  to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'employees#new'  
  resources :employees 
end
