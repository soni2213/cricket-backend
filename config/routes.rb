# frozen_string_literal: true

Rails.application.routes.default_url_options[:host] = 'localhost:3001'

Rails.application.routes.draw do
  if Rails.env.development? || Rails.env.test?
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end

  namespace :api, defaults: { format: :json } do
    resources :users, only: %i[show]
    resources :teams, only: %i[show]
    resources :matches, only: %i[create] do
      member do
        post :record_score
        put :record_winner
        put :update_match_status
        get  :summary
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
