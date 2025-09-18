class TransacoesController < ApplicationController
  @@transacoes = []
  @@mutex = Mutex.new

  # POST /transacao
  def create
    begin
      # Ler e parsear o JSON
      json_data = JSON.parse(request.body.read)
      
      # Validar campos obrigatórios
      unless json_data['valor'] && json_data['dataHora']
        Rails.logger.warn "Campos obrigatórios faltando: #{json_data}"
        return render status: :bad_request
      end

      # Validar e converter tipos
      valor = json_data['valor'].to_f
      data_hora = DateTime.parse(json_data['dataHora']) rescue nil
      
      unless data_hora
        Rails.logger.warn "Data/Hora inválida: #{json_data['dataHora']}"
        return render status: :bad_request
      end

      # Validar regras de negócio
      if valor < 0
        Rails.logger.warn "Valor negativo não permitido: #{valor}"
        return render status: :unprocessable_entity
      end

      if data_hora > DateTime.now
        Rails.logger.warn "Data futura não permitida: #{data_hora}"
        return render status: :unprocessable_entity
      end

      # Salvar transação
      @@mutex.synchronize do
        @@transacoes << {
          valor: valor,
          dataHora: data_hora
        }
        Rails.logger.info "Transação salva: valor=#{valor}, data=#{data_hora}"
      end

      render status: :created

    rescue JSON::ParserError
      Rails.logger.error "JSON inválido recebido"
      render status: :bad_request
    end
  end

  # DELETE /transacao
  def destroy
    @@mutex.synchronize do
      count = @@transacoes.size
      @@transacoes.clear
      Rails.logger.info "Todas as #{count} transações foram removidas"
    end
    
    render status: :ok
  end
end