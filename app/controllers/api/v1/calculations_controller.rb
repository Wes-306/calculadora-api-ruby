# app/controllers/api/v1/calculations_controller.rb
module Api
  module V1
    # Herdando do BaseController, este endpoint já nasce protegido por Token!
    class CalculationsController < BaseController
      def create
        # 1. Extração dos parâmetros da requisição
        operation = params[:operation]
        a = params[:a].to_f
        b = params[:b].to_f

        # 2. Instanciando nosso PORO (Plain Old Ruby Object)
        calculator = Calculator.new

        # 3. Validação de segurança (Allowlist)
        # Garantimos que o usuário só possa chamar métodos matemáticos permitidos
        if %w[add subtract multiply divide].include?(operation)
          # O public_send invoca dinamicamente o método escolhido na classe Calculator
          result = calculator.public_send(operation, a, b)
          render json: { result: result }, status: :ok
        else
          render json: { error: 'Operação inválida. Use: add, subtract, multiply, divide.' }, status: :unprocessable_content
        end
        
      # Tratamento de erro elegante na camada de controle
      rescue ZeroDivisionError => e
        render json: { error: e.message }, status: :unprocessable_content
      end
    end
  end
end