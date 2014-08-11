Chlite::Application.routes.draw do

  devise_for :admins
  resources :cities
  resources :states
  resources :destinations

  get :searches, to:"searches#show", as:"searches"

  resources :campsites

  namespace :api do
    namespace :v1 do
      resources :campsites
      get :searches, to:"searches#show", as:"searches"
    end
  end

  # STATIC PAGES =====================================================
  root to:"pages#home"
  get :terms, to:"pages#terms", as:"terms"
  get :privacy, to:"pages#privacy", as:"privacy"
  get :takedown, to:"pages#takedown", as:"takedown"
  get :mobile_teaser, to:"pages#mobile_teaser", as:"mobile_teaser"
  get :support, to:"pages#support", as:"support"
  get :unauthorized, to:"pages#unauthorized", as:"unauthorized"

  # IMPORTS ==========================================================
  post :upload_destination, to:"imports#destination_import", as:"upload_destination"
  post :upload_city, to:"imports#city_import", as:"upload_city"
  post :upload_state, to:"imports#state_import", as:"upload_state"
  post :special_one_time_import, to:"imports#special_one_time_import", as:"special_one_time_import"
  post :upload_cg, to:"imports#campsite_import", as:"upload_cg"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
