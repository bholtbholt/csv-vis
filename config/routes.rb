Rails.application.routes.draw do
  resources :keyword_entries
  resources :keywords
  resources :sites do
    collection { post :upload_csv }
  end

  root 'sites#index'
end
