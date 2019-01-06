Rails.application.routes.draw do
  get 'proxy/input'

  get 'proxy/output'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'proxy#input'
end
