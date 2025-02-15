create database hotel

CREATE TABLE hospede (
     id SERIAL PRIMARY KEY,
     nome VARCHAR(100) NOT NULL,
     email VARCHAR(100) UNIQUE NOT NULL,
  	 
);

insert into hospede (nome, email) values 
('Dario Silva', 'dariosilva@gmail.com'),
('Julia Vegas', 'juliavegas@gmail.com'),
('Rebeca Santos', 'rebecasantos@gmail.com'),
('Maria Oliveira', 'mariaoliveira@gmail.com'),
('Carla Martins', 'carlamartins@gmail.com'),
('Roberta Campos', 'robertacampos@gmail.com')

select * from hospede

select nome, id from hospede where nome like '%Roberto%';

CREATE TABLE reserva (
   id SERIAL PRIMARY KEY,
   hospede_id INT NOT NULL,
   data_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (hospede_id) REFERENCES hospede(id) ON DELETE CASCADE
);

INSERT INTO reserva (hospede_id, data_reserva) VALUES
(1, '2025-02-10 12:30:00'),
(2, '2025-02-10 13:30:00'),
(3, '2025-02-10 12:30:00'),
(4, '2025-02-10 13:30:00'),
(5, '2025-02-11 14:30:00'),
(6, '2025-02-12 15:30:00'),
(7, '2025-02-13 16:30:00'),
(8, '2025-02-14 17:30:00')
(9, '2025-02-30' '20:30:00') -- para inserir log na tabela log_reservas

select * from reserva

CREATE TABLE quarto (
    id SERIAL PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    preco_diaria DECIMAL(10,2) NOT NULL
);

INSERT INTO quarto (numero, tipo, preco_diaria) VALUES
('101', 'Solteiro', 120.50),
('102', 'Duplo', 200.00),
('103', 'Casal', 250.75),
('104', 'Solteiro', 110.00),
('105', 'Duplo', 180.00),
('106', 'Casal', 260.50),
('107', 'Solteiro', 130.00),
('108', 'Duplo', 220.00)

select * from quarto

CREATE TABLE reserva_quarto (
    reserva_id INT,
    quarto_id INT,
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    quantidade_diarias INT NOT NULL,
    PRIMARY KEY (reserva_id, quarto_id),
    FOREIGN KEY (reserva_id) REFERENCES reserva(id),
    FOREIGN KEY (quarto_id) REFERENCES quarto(id),
    CHECK (data_checkout > data_checkin) 
);

INSERT INTO reserva_quarto (reserva_id, quarto_id, data_checkin, data_checkout, quantidade_diarias) VALUES
(1, 2, '2025-02-15', '2025-02-18', 3),
(1, 5, '2025-02-16', '2025-02-20', 4),
(2, 3, '2025-02-10', '2025-02-12', 2),
(2, 6, '2025-02-11', '2025-02-13', 2),
(3, 1, '2025-02-20', '2025-02-22', 2),
(3, 4, '2025-02-21', '2025-02-23', 2),
(3, 7, '2025-02-22', '2025-02-25', 3),
(1, 8, '2025-02-17', '2025-02-19', 2)

select * from reserva_quarto

SELECT 
    h.nome AS hospede_nome,
    r.id AS reserva_id,
    rq.data_checkin,
    rq.data_checkout,
    rq.quantidade_diarias,
    q.numero AS quarto_numero,
    q.tipo AS quarto_tipo,
    q.preco_diaria
FROM 
    Reserva r
JOIN 
    Hospede h ON r.hospede_id = h.id
JOIN 
    Reserva_Quarto rq ON r.id = rq.reserva_id
JOIN 
    Quarto q ON rq.quarto_id = q.id
WHERE 
    h.id = 4;  

SELECT 
    rq.data_checkin,
    rq.data_checkout,
    rq.quantidade_diarias,
    q.numero AS quarto_numero,
    q.tipo AS quarto_tipo,
    q.preco_diaria,
    h.nome AS hospede_nome,
    r.id AS reserva_id
FROM 
    Reserva_Quarto rq 
JOIN 
    Quarto q ON rq.quarto_id = q.id  
JOIN 
    Reserva r ON rq.reserva_id = r.id  
JOIN 
    Hospede h ON r.hospede_id = h.id;  


CREATE TABLE log_reservas (
    id SERIAL PRIMARY KEY,
    reserva_id INT,
    quarto_id INT,
    data_checkin DATE,
    data_checkout DATE,
    data_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    mensagem TEXT
);


CREATE OR REPLACE FUNCTION log_nova_reserva()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_reservas (reserva_id, quarto_id, data_checkin, data_checkout, mensagem)
    VALUES (
        NEW.reserva_id,
        NEW.quarto_id,
        NEW.data_checkin,
        NEW.data_checkout,
        'Reserva inserida para o quarto ' || NEW.quarto_id || ' de ' || NEW.data_checkin || ' até ' || NEW.data_checkout
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_log_reserva
AFTER INSERT ON reserva_quarto
FOR EACH ROW
EXECUTE FUNCTION log_nova_reserva();


----para teste de quando inserir dados na tabela log_reservas trigger é acionado----

INSERT INTO reserva_quarto (reserva_id, quarto_id, data_checkin, data_checkout, quantidade_diarias)
VALUES (4, 4, '2025-03-01', '2025-03-05', 2);
-------------------------------------------------------------------------------------
select * from log_reservas