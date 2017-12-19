Rails.application.routes.draw do

  get '/adminlogin',to:'admin#new'

  post '/adminlogin',to:'admin#index'

  get '/home',to:'employee_pages#home'

  get '/details', to: 'employees#edit'
  patch '/details', to: 'employees#update'


  get  '/signup',  to: 'employees#new'

  post '/signup',  to: 'employees#create'

  get    '/login',   to: 'sessions#new'

  post   '/login',   to: 'sessions#create'

  get 'employees/:id/show',to: 'employees#show'

  delete '/logout',  to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'employees#new'  
  resources :employees 
end
