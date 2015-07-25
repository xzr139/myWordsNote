Rails.application.routes.draw do
  
  resources :words do 
    collection do
      get 'search'
    end
  end
  
  resources :notes do 
    collection do
      get 'welcome'
      get 'about'
    end
  end

  resources :words
  resources :notes
  resources :sessions, only: [:new, :create, :destroy]
  
  root :to => "notes#welcome"
  
  get "sessions/destroy"
  post "words/search_suggest"

end
