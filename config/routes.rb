Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "static#home", as: "root"
  get "/about", to: "static#about"

  get "/login/:type", to: "sessions#new", as: "login"
  post "/login/:type", to: "sessions#create"
  post "/logout", to: "sessions#destroy"

  resources :company_admins
  resources :companies, only: [:index, :show]
  resources :teachers
  resources :courses
  resources :students, only: [:new, :create]

  get "/students/profile", to: "students#show", as: "student"
  get "/students/profile/edit", to: "students#edit", as: "edit_student"
  patch "/students/profile/edit", to: "students#update"

  get "/companies/profile/edit", to: "companies#edit", as: "edit_company"
  patch "/companies/profile/edit", to: "companies#update"

  post "courses/register/:id", to: "courses#register", as: "course_register"
  delete "courses/unregister/:id", to: "courses#unregister", as: "course_unregister"
end
