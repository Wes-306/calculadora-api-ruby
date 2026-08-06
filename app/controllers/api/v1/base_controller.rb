# app/controllers/api/v1/base_controller.rb
module Api
  module V1
    # Herdamos de ActionController::API em vez de ApplicationController.
    # Isso remove o peso de renderização de views HTML e cookies, deixando a API muito mais rápida.
    class BaseController < ActionController::API
      include ActionController::HttpAuthentication::Token::ControllerMethods
      
      # Garantimos que qualquer controller que herde deste precise de autenticação
      before_action :authenticate

      private

      def authenticate
        # Intercepta o cabeçalho HTTP "Authorization: Bearer <token>"
        authenticate_or_request_with_http_token do |token, _options|
          # Compara o token enviado com a nossa variável de ambiente (segurança contra ataques de timing)
          ActiveSupport::SecurityUtils.secure_compare(
            token, 
            ENV.fetch('API_TOKEN', 'meu-token-secreto-de-desenvolvimento')
          )
        end
      end
    end
  end
end