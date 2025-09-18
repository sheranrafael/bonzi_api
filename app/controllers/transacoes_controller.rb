class TransacoesController < ApplicationController
  # Armazenamento em memória
  @@transacoes = []
  @@mutex = Mutex.new

  # POST /transacao
  def create
    transacao_params = params.permit(:valor, :dataHora)
    
    # Validar JSON
    unless transacao_params[:valor] && transacao_params[:dataHora]
      return render status: :bad_request
    end

    # Validar tipos
    valor = transacao_params[:valor].to_f
    data_hora = DateTime.parse(transacao_params[:dataHora]) rescue nil
    
    unless data_hora
      return render status: :bad_request
    end

    # Validar regras de negócio
    if valor < 0 || data_hora > DateTime.now
      return render status: :unprocessable_entity
    end

    # Salvar transação
    @@mutex.synchronize do
      @@transacoes << {
        valor: valor,
        dataHora: data_hora
      }
    end

    render status: :created
  end

  # DELETE /transacao
  def destroy
    @@mutex.synchronize do
      @@transacoes.clear
    end
    
    render status: :ok
  end
end