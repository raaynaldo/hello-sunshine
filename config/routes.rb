Rails.application.routes.draw do
  resources :companies
  resources :teachers
  resources :students
  resources :courses
  post 'courses/register/:id', to: "courses#register", as: "course_register"
  delete 'courses/unregister/:id', to: "courses#unregister", as: "course_unregister"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: "static#home", as: "root"
  get '/about', to: "static#about"

  get '/login/:type', to: "sessions#new", as: "login"
  post '/login/:type', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
end
