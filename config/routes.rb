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

post "sessions/create"
get "sessions/new"
post "sessions/new"
delete "sessions/destroy"
get "sessions/destroy"
  
  root :to => "notes#welcome"
  
  get "sessions/destroy"
  post "words/search_suggest"

end
