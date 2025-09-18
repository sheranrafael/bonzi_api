# Transactions and Statistics API🤙

A REST API developed in Ruby on Rails based on Itaú selection process challenge. Processes financial transactions and calculates real-time statistics.

### Features

- `POST /transacao` - Receives financial transactions with validations
- `DELETE /transacao` - Receives financial transactions with validations
- `GET /estatistica` - Returns statistics for transactions from the last 60 seconds

### Requisitos Atendidos

-  REST API with exact endpoints as specified
-  In-memory storage (no database)
-  Rigorous transaction validations
-  HTTP responses as specified
-  Strict JSON format
-  Multiple commits showing evolution
-  Automated tests with RSpec

### Technologies Used

- **Ruby** 3.4.5
- **Ruby on Rails** 8.0.2.1
- **RSpec** - Automated testing
- **Rack CORS** - Access control
- **Puma** - Web server

### Installation and Execution

#### Prerequisites
- Ruby 3.1.2 or higher
- Bundler gem

#### Step by step

1. **Clone the repository
```bash
git clone https://github.com/sheranrafael/transacoes-api.git
cd transacoes-api
```
