# spec/requests/api/v1/calculations_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::Calculations", type: :request do
  describe "POST /api/v1/calculate" do
    let(:headers) do
      {
        'Authorization' => "Bearer #{ENV.fetch('API_TOKEN', 'meu-token-secreto-de-desenvolvimento')}",
        'Content-Type' => 'application/json'
      }
    end

    context "com parâmetros válidos" do
      let(:valid_params) { { operation: 'add', a: 15, b: 5 }.to_json }

      it "retorna o status HTTP 200 (OK) e o resultado correto" do
        post '/api/v1/calculate', params: valid_params, headers: headers
        
        expect(response).to have_http_status(:ok)
        
        json_response = JSON.parse(response.body)
        expect(json_response['result']).to eq(20.0)
      end
    end

    context "com operação inválida" do
      let(:invalid_params) { { operation: 'power', a: 2, b: 3 }.to_json }

      it "retorna status 422 (Unprocessable Entity)" do
        post '/api/v1/calculate', params: invalid_params, headers: headers
        
        expect(response).to have_http_status(:unprocessable_content)
        expect(JSON.parse(response.body)['error']).to include('Operação inválida')
      end
    end

    context "sem token de autenticação" do
      let(:params) { { operation: 'add', a: 1, b: 1 }.to_json }

      it "retorna status 401 (Unauthorized)" do
        # Fazemos a requisição sem passar a variável `headers`
        post '/api/v1/calculate', params: params 
        
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end