Rails.application.routes.draw do

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  root 'word#index'

  post '/' => 'word#processing'
end
