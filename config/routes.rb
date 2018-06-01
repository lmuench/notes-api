# frozen_string_literal: true

Rails.application.routes.draw do
  resources :notebooks do
    resources :notes
  end
end
