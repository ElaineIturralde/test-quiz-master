Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'questions#index'
  get 'answer' => 'questions#answer'
  resources :questions, except: :index do
    post :answer, on: :member
  end
end
