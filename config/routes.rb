# frozen_string_literal: true

Rails.application.routes.default_url_options[:host] = 'localhost:3001'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: %w[show]
    resources :scores, only: [] do
      collection do
        post :record_score
        post :record_toss
        get :retrieve_score
        post :match_winner
      end
    end
  end

  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: 'api/login',
               sign_out: 'api/logout',
               registration: 'api/signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
end
