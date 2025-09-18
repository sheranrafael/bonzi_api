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
      Rails.logger.info "Estatísticas calculadas: #{transacoes_recentes.size} transações nos últimos 60s"
    end

    # Calcular estatísticas
    calcular_estatisticas(transacoes_recentes)
  end

  private

  def calcular_estatisticas(transacoes)
    if transacoes.empty?
      render json: { count: 0, sum: 0.0, avg: 0.0, min: 0.0, max: 0.0 }
    else
      valores = transacoes.map { |t| t[:valor] }
      stats = {
        count: valores.size,
        sum: valores.sum.round(2),
        avg: (valores.sum / valores.size).round(2),
        min: valores.min.round(2),
        max: valores.max.round(2)
      }
      Rails.logger.debug "Estatísticas: #{stats}"
      render json: stats
    end
  end
end