class EstatisticasController < ApplicationController
  # GET /estatistica
  def index
    now = DateTime.now
    um_minuto_atras = now - 1.minute

    transacoes_recentes = []
    
    TransacoesController.class_variable_get(:@@mutex).synchronize do
      transacoes = TransacoesController.class_variable_get(:@@transacoes)
      transacoes_recentes = transacoes.select do |transacao|
        transacao[:dataHora] >= um_minuto_atras && transacao[:dataHora] <= now
      end
    end

    # Calcular estatísticas
    if transacoes_recentes.empty?
      render json: {
        count: 0,
        sum: 0.0,
        avg: 0.0,
        min: 0.0,
        max: 0.0
      }
    else
      valores = transacoes_recentes.map { |t| t[:valor] }
      
      render json: {
        count: valores.size,
        sum: valores.sum.round(2),
        avg: (valores.sum / valores.size).round(2),
        min: valores.min.round(2),
        max: valores.max.round(2)
      }
    end
  end
end