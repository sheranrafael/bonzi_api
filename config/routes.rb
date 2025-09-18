Rails.application.routes.draw do
  post 'transacao', to: 'transacoes#create'
  delete 'transacao', to: 'transacoes#destroy'
  get 'estatistica', to: 'estatisticas#index'
end