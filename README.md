# Projeto de Banco de Dados de Hotel

Este projeto tem como objetivo desenvolver um sistema de gerenciamento de reservas de um hotel utilizando PostgreSQL. O banco de dados inclui tabelas para hóspedes, reservas, quartos e logs de reservas, além de funções e triggers para automatizar o registro de operações.

## Estrutura do Banco de Dados

### Diagrama do Banco de Dados

![Diagrama do Banco de Dados](/diagram/chart.png)

### Tabela `hospede`

Armazena as informações dos hóspedes do hotel, como nome e email.

- **id**: Identificador único do hóspede (chave primária).
- **nome**: Nome do hóspede.
- **email**: Email do hóspede (único).

### Tabela `reserva`

Armazena as informações das reservas feitas pelos hóspedes.

- **id**: Identificador único da reserva (chave primária).
- **hospede_id**: Identificador do hóspede que fez a reserva (chave estrangeira).
- **data_reserva**: Data e hora em que a reserva foi feita.

### Tabela `quarto`

Armazena as informações dos quartos disponíveis no hotel.

- **id**: Identificador único do quarto (chave primária).
- **numero**: Número do quarto (único).
- **tipo**: Tipo do quarto (ex: Solteiro, Duplo, Casal).
- **preco_diaria**: Preço da diária do quarto.

### Tabela `reserva_quarto`

Armazena as informações das reservas de quartos feitas pelos hóspedes.

- **reserva_id**: Identificador da reserva (chave estrangeira).
- **quarto_id**: Identificador do quarto reservado (chave estrangeira).
- **data_checkin**: Data de check-in.
- **data_checkout**: Data de check-out.
- **quantidade_diarias**: Quantidade de diárias reservadas.

### Tabela `log_reservas`

Armazena os logs das operações relacionadas às reservas, como inserção e modificação de reservas.

- **id**: Identificador único do log (chave primária).
- **reserva_id**: Identificador da reserva (chave estrangeira).
- **quarto_id**: Identificador do quarto reservado (chave estrangeira).
- **data_checkin**: Data de check-in.
- **data_checkout**: Data de check-out.
- **data_operacao**: Data e hora da operação.
- **mensagem**: Mensagem descrevendo a operação realizada.

## Funcionalidades

### Função `log_nova_reserva()`

Insere um registro na tabela `log_reservas` sempre que uma nova reserva de quarto é inserida na tabela `reserva_quarto`.

### Trigger `trigger_log_reserva`

Trigger que chama a função `log_nova_reserva()` após a inserção de uma nova reserva na tabela `reserva_quarto`.

## Consultas SQL

### Consultas Básicas

- Seleção de todos os registros das tabelas `hospede`, `reserva`, `quarto` e `reserva_quarto`.
- Seleção de hóspedes pelo nome.
- Seleção de reservas por hóspede.

### Consultas Avançadas

- Junção de tabelas para obter detalhes das reservas de um hóspede específico.
- Junção de tabelas para obter detalhes de todas as reservas.

---

Este projeto exemplifica a criação e manipulação de um banco de dados de hotel em PostgreSQL, cobrindo desde a definição das tabelas e inserção de dados até a criação de funções, triggers e consultas avançadas.


## 📩 Contato
Atividade realizada por **Fábio Nogueira**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-1B1C1E?style=for-the-badge&logo=linkedin&logoColor=0077B5&border_color=fcf901)](https://www.linkedin.com/in/faanogueira/)
[![GitHub](https://img.shields.io/badge/GitHub-1B1C1E?style=for-the-badge&logo=linkedin&logoColor=0077B5&border_color=fcf901)](https://github.com/faanogueira)
[![Gmail](https://img.shields.io/badge/Gmail-1B1C1E?style=for-the-badge&logo=gmail&logoColor=C71610)](mailto:faanogueira@gmail.com)
[![WhatsApp](https://img.shields.io/badge/WhatsApp-1B1C1E?style=for-the-badge&logo=whatsapp&logoColor=green)](https://api.whatsapp.com/send?phone=5571983937557)

