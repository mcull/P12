Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  scope '/admin' do
     resources :base_goods
     resources :colors
     #resources :designs
     resources :design_constraints
     resources :goods_categories
     resources :print_modes
     resources :printable_goods
     resources :printable_locations
     resources :printers do
       resources :base_goods do
         resources :printer_inventories
       end
     end
     resources :sales_channels
     resources :shipments
     resources :sizes
   end

   resources :design_owners do
     resources :designs do
       resources :print_ready_arts
     end
   end
   resources :products do
     resources :product_photos
   end

   get 'product/:id/remove_main_photo', to: 'products#remove_main_photo', as: 'remove_product_main_photo'
   post 'product_photos/create', to: 'product_photos#create', as: 'add_product_photos'

   get 'admin/upc_code/create', to: 'upc_codes#create', as: 'create_upc_code'
   get 'admin/upc_code/destroy', to: 'upc_codes#destroy', as: 'destroy_upc_code'
   get 'admin/upc_code/next', to: 'upc_codes#next', as: 'next_upc_code'
   get 'admin/upc_code/bulk', to: 'upc_codes#new', as: 'bulk_upc_code'
   post 'admin/upc_code/bulk_upload', to: 'upc_codes#bulk_create', as: 'bulk_upc_code_upload'


  # Point of indirection
     post '/listeners/coloradotimberline', to: 'shipments#create'

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
