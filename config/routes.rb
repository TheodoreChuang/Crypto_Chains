Rails.application.routes.draw do
  resources :articles do
    resources :comments
    member do
      put "like" => "articles#up_vote"
      put "dislike" => "articles#down_vote"
    end
  end
  devise_for :users, path: "", path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}
  root "articles#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
