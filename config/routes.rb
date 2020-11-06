Rails.application.routes.draw do
  resources :companies
  resources :teachers
  resources :students
  resources :courses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: "static#home"
  get '/about', to: "static#about"
end
