# config/routes.rb
Rails.application.routes.draw do
  # Define a página inicial do site (http://localhost:3000/)
  root "home#index"

  # Rota de verificação de saúde da aplicação (padrão do Rails 8)
  get "up" => "rails/health#show", as: :rails_health_check

  # --- NOSSAS ROTAS DA API ---
  namespace :api do
    namespace :v1 do
      post 'calculate', to: 'calculations#create'
    end
  end
end