Rails.application.routes.draw do
  resources :articles do
    resources :comments
    member do
      put "like" => "votes#up_vote"
      put "dislike" => "votes#down_vote"
    end
  end
  devise_for :users, path: "", path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}
  root "articles#index"
  get 'tags/:tag', to: 'articles#index', as: "tag"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
