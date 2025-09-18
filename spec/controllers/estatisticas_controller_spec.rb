require 'rails_helper'

RSpec.describe EstatisticasController, type: :controller do
  describe 'GET /estatistica' do
    it 'retorna estatísticas vazias quando não há transações' do
      get :index
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response).to eq({
        "count" => 0,
        "sum" => 0.0,
        "avg" => 0.0,
        "min" => 0.0,
        "max" => 0.0
      })
    end

    it 'calcula estatísticas corretamente' do
      # Adiciona transações diretamente no array
      transacoes = TransacoesController.class_variable_get(:@@transacoes)
      transacoes.clear # Limpa primeiro
      
      transacoes << { valor: 100.0, dataHora: DateTime.now - 30.seconds }
      transacoes << { valor: 200.0, dataHora: DateTime.now - 45.seconds }
      
      get :index
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      
      expect(json_response["count"]).to eq(2)
      expect(json_response["sum"]).to eq(300.0)
      expect(json_response["avg"]).to eq(150.0)
      expect(json_response["min"]).to eq(100.0)
      expect(json_response["max"]).to eq(200.0)
    end

    it 'ignora transações antigas' do
      transacoes = TransacoesController.class_variable_get(:@@transacoes)
      transacoes.clear
      
      # Transação recente (30 segundos atrás)
      transacoes << { valor: 100.0, dataHora: DateTime.now - 30.seconds }
      # Transação antiga (2 minutos atrás) - deve ser ignorada
      transacoes << { valor: 500.0, dataHora: DateTime.now - 2.minutes }
      
      get :index
      
      json_response = JSON.parse(response.body)
      expect(json_response["count"]).to eq(1) # Só a recente
      expect(json_response["sum"]).to eq(100.0)
    end
  end
end