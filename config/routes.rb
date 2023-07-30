# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resource :page, only: :show
  resource :weather, only: [:new, :show]

  root 'pages#show'
end
