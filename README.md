# API de Transações e Estatísticas🤙

API REST desenvolvida em Ruby on Rails. Processa transações financeiras e calcula estatísticas em tempo real.

### Funcionalidades

- `POST /transacao` - Recebe transações financeiras com validações
- `DELETE /transacao` - Remove todas as transações armazenadas
- `GET /estatistica` - Retorna estatísticas das transações dos últimos 60 segundos

### Requisitos Atendidos

-  API REST com endpoints exatos especificados
-  Armazenamento em memória (sem banco de dados)
-  Validações rigorosas das transações
-  Respostas HTTP conforme especificado
-  Formato JSON estrito
-  Múltiplos commits mostrando evolução
-  Testes automatizados com RSpec

### Tecnologias Utilizadas

- **Ruby** 3.4.5
- **Ruby on Rails** 8.0.2.1
- **RSpec** - Testes automatizados
- **Rack CORS** - Controle de acesso
- **Puma** - Servidor web

### Instalação e Execução

#### Pré-requisitos
- Ruby 3.1.2 ou superior
- Bundler gem

#### Passo a passo

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/transacoes-api.git
cd transacoes-api```