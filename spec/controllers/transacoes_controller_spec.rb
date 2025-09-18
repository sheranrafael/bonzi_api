require 'rails_helper'

RSpec.describe TransacoesController, type: :controller do
  describe 'POST /transacao' do
    it 'cria uma transação válida' do
      post :create, 
        body: { 
          valor: 100.0, 
          dataHora: "2024-01-15T10:30:00-03:00" 
        }.to_json,
        format: :json
      
      expect(response).to have_http_status(:created)
    end

    it 'rejeita transação com valor negativo' do
      post :create, 
        body: { 
          valor: -50.0, 
          dataHora: "2024-01-15T10:30:00-03:00" 
        }.to_json,
        format: :json
      
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'rejeita transação com data futura' do
      post :create, 
        body: { 
          valor: 100.0, 
          dataHora: "2030-01-15T10:30:00-03:00" 
        }.to_json,
        format: :json
      
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'rejeita JSON inválido' do
      post :create, 
        body: 'invalid json',
        format: :json
      
      expect(response).to have_http_status(:bad_request)
    end

    it 'rejeita sem campos obrigatórios' do
      post :create, 
        body: { valor: 100.0 }.to_json, # falta dataHora
        format: :json
      
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'DELETE /transacao' do
    it 'limpa todas as transações' do
      delete :destroy
      expect(response).to have_http_status(:ok)
    end
  end
end