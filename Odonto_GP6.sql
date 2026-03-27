CREATE DATABASE Odonto;
CREATE SCHEMA sistema;
SET search_path TO sistema;

-------------------------------- CRIAÇÃO DAS TABELAS E CONEXÕES --------------------------------
CREATE TABLE PACIENTE 
( 
 id_paciente SERIAL PRIMARY KEY,
 nome_paciente VARCHAR(100) NOT NULL,  
 cpf VARCHAR(11) UNIQUE NOT NULL,  
 data_nascimento DATE NOT NULL,  
 telefone VARCHAR(20) NOT NULL,  
 email VARCHAR(100) NOT NULL
); 

CREATE TABLE DENTISTA 
( 
 id_dentista SERIAL PRIMARY KEY,  
 nome_dentista VARCHAR(100) NOT NULL,  
 cpf VARCHAR(11) NOT NULL,  
 especialidade VARCHAR(100) NOT NULL,  
 cro VARCHAR(20) NOT NULL
); 

CREATE TABLE PROCEDIMENTO 
( 
 duracao VARCHAR(100) NOT NULL,  
 descricao TEXT NOT NULL,  
 nome_procedimento VARCHAR(100) NOT NULL,  
 id_procedimento SERIAL PRIMARY KEY 
); 

CREATE TABLE ENDERECO 
( 
 logradouro VARCHAR(100) NOT NULL,
 numero INT NOT NULL,
 cidade VARCHAR(100) NOT NULL,
 complemento VARCHAR(100),     
 cep VARCHAR (100) NOT NULL,  
 id_endereco SERIAL PRIMARY KEY  
); 

CREATE TABLE HORARIO_ATENDIMENTO 
( 
 id_dentista INT NOT NULL,  
 horario TIMESTAMP NOT NULL
);
ALTER TABLE HORARIO_ATENDIMENTO ADD FOREIGN KEY(id_dentista) REFERENCES DENTISTA (id_dentista)
ON DELETE CASCADE;

CREATE TABLE CONSULTA 
( 
 id_consulta SERIAL PRIMARY KEY,   
 id_paciente INT NOT NULL,
 id_dentista INT NOT NULL,  
 descricao_conteudo TEXT NOT NULL,  
 prescricao TEXT,
 data_hora TIMESTAMP NOT NULL
);
ALTER TABLE CONSULTA ADD FOREIGN KEY(id_paciente) REFERENCES PACIENTE (id_paciente);
ALTER TABLE CONSULTA ADD FOREIGN KEY(id_dentista) REFERENCES DENTISTA (id_dentista);

CREATE TABLE PACIENTE_ENDERECO 
( 
 id_paciente INT,
 id_endereco INT,
 PRIMARY KEY(id_paciente, id_endereco)
);
ALTER TABLE PACIENTE_ENDERECO ADD FOREIGN KEY(id_paciente) REFERENCES PACIENTE (id_paciente)
ON DELETE CASCADE;
ALTER TABLE PACIENTE_ENDERECO ADD FOREIGN KEY(id_endereco) REFERENCES ENDERECO (id_endereco)
ON DELETE CASCADE;

CREATE TABLE CONSULTA_PROCEDIMENTO 
( 
 id_procedimento INT,
 id_consulta INT,
 PRIMARY KEY(id_procedimento, id_consulta)
);
ALTER TABLE CONSULTA_PROCEDIMENTO ADD FOREIGN KEY(id_procedimento) REFERENCES PROCEDIMENTO (id_procedimento)
ON DELETE CASCADE;
ALTER TABLE CONSULTA_PROCEDIMENTO ADD FOREIGN KEY(id_consulta) REFERENCES CONSULTA (id_consulta)
ON DELETE CASCADE;

-------------------------------- INSERÇÃO DE VALORES TESTE --------------------------------

INSERT INTO PACIENTE (nome_paciente, cpf, data_nascimento, telefone, email) VALUES
('Ana Silva', '12345678901', '1985-04-15', '21999991111', 'ana.silva@email.com'),
('Bruno Costa', '23456789012', '1990-08-22', '11988882222', 'bruno.costa@email.com'),
('Carla Souza', '34567890123', '1978-11-05', '31977773333', 'carla.souza@email.com'),
('Diego Alves', '45678901234', '1982-02-28', '41966664444', 'diego.alves@email.com'),
('Elena Gomes', '56789012345', '1995-07-10', '51955555555', 'elena.gomes@email.com'),
('Fabio Rocha', '67890123456', '1965-12-03', '61944446666', 'fabio.rocha@email.com'),
('Gisele Martins', '78901234567', '2000-01-18', '71933337777', 'gisele.martins@email.com'),
('Henrique Lima', '89012345678', '1988-09-25', '81922228888', 'henrique.lima@email.com'),
('Isabela Dias', '90123456789', '1992-05-30', '91911119999', 'isabela.dias@email.com'),
('João Castro', '01234567890', '1975-03-14', '21900000000', 'joao.castro@email.com'),
('Karina Mendes', '11223344556', '1980-06-19', '11912345678', 'karina.mendes@email.com'),
('Lucas Nunes', '22334455667', '1998-10-08', '31987654321', 'lucas.nunes@email.com'),
('Marina Pinto', '33445566778', '1986-12-25', '41956781234', 'marina.pinto@email.com'),
('Nicolas Silva', '44556677889', '2002-04-02', '51943218765', 'nicolas.silva@email.com'),
('Olivia Reis', '55667788990', '1970-08-11', '61934567890', 'olivia.reis@email.com');

INSERT INTO DENTISTA (nome_dentista, cpf, especialidade, cro) VALUES
('Dr. Carlos Eduardo', '11122233344', 'Ortodontia', 'CRO-RJ 10001'),
('Dra. Fernanda Lima', '22233344455', 'Endodontia', 'CRO-SP 20002'),
('Dr. Ricardo Alves', '33344455566', 'Implantodontia', 'CRO-MG 30003'),
('Dra. Juliana Costa', '44455566677', 'Odontopediatria', 'CRO-RS 40004'),
('Dr. Marcelo Silva', '55566677788', 'Cirurgia Bucomaxilofacial', 'CRO-PR 50005'),
('Dra. Amanda Rocha', '66677788899', 'Periodontia', 'CRO-SC 60006'),
('Dr. Thiago Mendes', '77788899900', 'Clínico Geral', 'CRO-BA 70007'),
('Dra. Beatriz Santos', '88899900011', 'Ortodontia', 'CRO-PE 80008'),
('Dr. Leandro Pinto', '99900011122', 'Endodontia', 'CRO-CE 90009'),
('Dra. Camila Nogueira', '00011122233', 'Odontopediatria', 'CRO-GO 10010'),
('Dr. Vitor Martins', '12121212121', 'Implantodontia', 'CRO-DF 11011'),
('Dra. Letícia Carvalho', '23232323232', 'Prótese Dentária', 'CRO-ES 12012'),
('Dr. Gustavo Ribeiro', '34343434343', 'Clínico Geral', 'CRO-AM 13013'),
('Dra. Sofia Almeida', '45454545454', 'Periodontia', 'CRO-PA 14014'),
('Dr. Rafael Azevedo', '56565656565', 'Harmonização Orofacial', 'CRO-MT 15015');

INSERT INTO PROCEDIMENTO (nome_procedimento, descricao, duracao) VALUES
('Avaliação Inicial', 'Consulta de avaliação geral, anamnese e planejamento do tratamento.', '30 minutos'),
('Limpeza (Profilaxia)', 'Remoção de placa bacteriana, tártaro e polimento coronário.', '45 minutos'),
('Aplicação de Flúor', 'Aplicação tópica de flúor em gel para fortalecimento do esmalte e prevenção de cáries.', '20 minutos'),
('Restauração em Resina', 'Remoção de tecido cariado e preenchimento com resina composta fotopolimerizável.', '40 minutos'),
('Clareamento a Laser', 'Sessão de clareamento dental em consultório utilizando gel clareador e fonte de luz.', '1 hora'),
('Tratamento de Canal (Incisivo)', 'Acesso endodôntico, instrumentação, desinfecção e obturação de dente anterior.', '1 hora e 15 minutos'),
('Tratamento de Canal (Molar)', 'Tratamento endodôntico complexo em dente posterior com múltiplas raízes.', '2 horas'),
('Extração de Siso (Incluso)', 'Cirurgia para remoção de terceiro molar não irrompido, com osteotomia e sutura.', '1 hora e 30 minutos'),
('Extração Simples', 'Exodontia de dente com mobilidade ou raiz residual, sem necessidade de corte ósseo.', '40 minutos'),
('Instalação de Implante', 'Cirurgia para fixação de pino de titânio no osso maxilar/mandibular.', '1 hora e 30 minutos'),
('Coroa de Porcelana', 'Cimentação definitiva de coroa protética em cerâmica pura sobre dente ou implante.', '1 hora'),
('Manutenção Ortodôntica', 'Troca de borrachinhas, fios e ajustes no aparelho fixo do paciente.', '30 minutos'),
('Raspagem Periodontal', 'Remoção profunda de cálculos subgengivais sob anestesia local.', '1 hora'),
('Gengivectomia', 'Cirurgia plástica gengival para correção de sorriso gengival ou hiperplasia.', '1 hora e 15 minutos'),
('Moldagem para Prótese', 'Obtenção de modelo de trabalho utilizando alginato ou silicone de adição.', '30 minutos');

INSERT INTO ENDERECO (logradouro, numero, complemento, cep, cidade) VALUES
('Rua das Flores', 123, 'Apto 101', '01001-000', 'São Paulo'),
('Avenida Paulista', 1000, 'Bloco B, Sala 50', '01310-100', 'São Paulo'),
('Rua XV de Novembro', 500, NULL, '80020-310', 'Curitiba'),
('Avenida Atlântica', 2500, 'Cobertura 01', '22041-001', 'Rio de Janeiro'),
('Rua da Praia', 10, NULL, '88010-000', 'Florianópolis'),
('Alameda dos Anjos', 333, 'Casa 2', '30140-070', 'Belo Horizonte'),
('Travessa da Paz', 42, NULL, '90010-001', 'Porto Alegre'),
('Rodovia BR-101', 1500, 'Galpão 3', '89219-600', 'Joinville'),
('Praça da Sé', 1, 'Sala 404', '01001-001', 'São Paulo'),
('Rua das Laranjeiras', 77, NULL, '22240-004', 'Rio de Janeiro'),
('Avenida Brasil', 5000, NULL, '13015-000', 'Campinas'),
('Rua do Comércio', 888, 'Loja 5', '40010-000', 'Salvador'),
('Beco do Batman', 99, NULL, '05433-010', 'São Paulo'),
('Avenida Afonso Pena', 2020, 'Apto 502', '79002-075', 'Campo Grande'),
('Rua das Acácias', 150, 'Frente', '70000-000', 'Brasília');

INSERT INTO CONSULTA (id_paciente, id_dentista, data_hora, descricao_conteudo, prescricao) VALUES
(1, 3, '2026-03-20 09:00:00', 'Paciente relatou dor ao mastigar no lado direito. Suspeita de fratura radicular.', 'Ibuprofeno 400mg de 8/8h por 3 dias.'),
(2, 1, '2026-03-21 10:30:00', 'Avaliação inicial para instalação de aparelho ortodôntico. Solicitada documentação.', NULL),
(2, 2, '2026-03-22 14:00:00', 'Troca de curativo endodôntico no dente 21. Paciente não relatou dor desde a última sessão.', NULL),
(4, 5, '2026-03-23 15:30:00', 'Criança colaborativa. Realizada profilaxia e aplicação de flúor em todos os elementos.', 'Orientação de escovação supervisionada pelos pais.'),
(5, 5, '2026-03-24 11:00:00', 'Avaliação para extração de siso incluso (dente 48). Região levemente edemaciada.', 'Raio-X Panorâmico e Tomografia da mandíbula.'),
(13, 6, '2026-03-25 08:30:00', 'Sangramento gengival leve relatado durante a escovação. Feita raspagem supragengival.', 'Fio dental diário e enxaguante bucal sem álcool por 15 dias.'),
(7, 7, '2026-03-25 16:00:00', 'Restauração antiga no dente 46 quebrou. Realizada nova restauração em resina composta.', NULL),
(9, 2, '2026-03-26 09:15:00', 'Sessão de aplicação de toxina botulínica para controle de bruxismo severo.', 'Não abaixar a cabeça ou deitar nas próximas 4 horas.'),
(9, 9, '2026-03-26 14:45:00', 'Canal finalizado no dente 14. Realizada obturação definitiva e selamento provisório.', 'Amoxicilina 500mg de 8/8h por 7 dias.'),
(1, 10, '2026-03-27 10:00:00', 'Retorno preventivo anual. Nenhum indício de cárie. Saúde bucal em ótimo estado.', NULL),
(11, 11, '2026-03-28 11:30:00', 'Cirurgia de instalação de implante de titânio na região do dente 35. Procedimento sem intercorrências.', 'Dipirona 1g de 6/6h em caso de dor. Gelo no local.'),
(7, 12, '2026-03-29 13:00:00', 'Prova da coroa de porcelana pura. Cor e adaptação aprovadas pela paciente. Retorna para cimentação.', NULL),
(13, 1, '2026-03-30 15:00:00', 'Queixa de sensibilidade extrema ao frio. Diagnosticada retração gengival no dente 14.', 'Usar creme dental específico para dentes sensíveis.'),
(14, 8, '2026-04-01 09:30:00', 'Manutenção mensal do aparelho fixo. Troca do fio ortodôntico e dos elásticos.', NULL),
(13, 1, '2026-04-02 14:00:00', 'Raspagem periodontal profunda sob anestesia na arcada inferior.', 'Paracetamol 750mg se houver dor. Evitar alimentos duros hoje.'),
(3, 1, '2026-02-21 10:45:00', 'Avaliação inicial para instalação de aparelho ortodôntico. Solicitada documentação.', NULL),
(13, 1, '2026-02-24 10:30:00', 'Avaliação inicial para instalação de aparelho ortodôntico. Solicitada documentação.', NULL);

INSERT INTO PACIENTE_ENDERECO (id_paciente, id_endereco) VALUES
(1, 1), (1,2), (2, 10), (3, 2), (4, 3), (5, 4), (6, 5), (7, 6), (8, 7), (9, 8), 
(10, 9), (11, 10), (12, 11), (13, 12), (14, 13), (14, 15), (15, 14); 

INSERT INTO HORARIO_ATENDIMENTO (id_dentista, horario) VALUES
(1, '2026-03-30 08:00:00'), -- Dr. Carlos às 08h
(1, '2026-03-30 09:00:00'), -- Dr. Carlos às 09h
(2, '2026-03-30 10:00:00'), -- Dra. Fernanda às 10h
(3, '2026-03-30 11:00:00'), -- Dr. Ricardo às 11h
(4, '2026-03-30 14:00:00'), -- Dra. Juliana às 14h
(5, '2026-03-31 08:00:00'), -- Dr. Marcelo às 08h
(6, '2026-03-31 09:00:00'), -- Dra. Amanda às 09h
(7, '2026-03-31 10:00:00'), -- Dr. Thiago às 10h
(8, '2026-03-31 11:00:00'), -- Dra. Beatriz às 11h
(9, '2026-04-01 14:00:00'), -- Dr. Leandro às 14h
(10, '2026-04-01 15:00:00'), -- Dra. Camila às 15h
(11, '2026-04-01 16:00:00'), -- Dr. Vitor às 16h
(12, '2026-04-02 08:00:00'), -- Dra. Letícia às 08h
(13, '2026-04-02 09:00:00'), -- Dr. Gustavo às 09h
(14, '2026-04-02 10:00:00'); -- Dra. Sofia às 10h

INSERT INTO CONSULTA_PROCEDIMENTO (id_procedimento, id_consulta) VALUES
(1, 1), (2, 1), (1, 2),  (15, 2), (6, 3), (4, 3), (2, 4), (3, 4), (1, 5), 
(8, 5), (13, 6), (2, 7), (4, 7), (1, 8), (5, 8), (7, 9), (1, 10), (2, 10), 
(10, 11), (15, 11), (11, 12), (4, 13), (12, 14), (13, 15), (14, 15); 

-------------------------------- Requisitos não Funcionais --------------------------------
-- Index
CREATE INDEX idx_dentista
ON dentista(id_dentista);

CREATE INDEX idx_paciente
ON paciente(id_paciente);

CREATE INDEX idx_paciente_endereco
ON paciente_endereco(id_paciente, id_endereco);

-- Update

UPDATE SISTEMA.ENDERECO SET 
logradouro = 'Rua Visconde de pirajá',
numero = 550,
complemento = 'Apto 101',
cep = '22410-002',
cidade = 'Rio de Janeiro'
WHERE id_endereco = 13; --ATUALIZA UM ENDEREÇO COMPLETO

UPDATE SISTEMA.CONSULTA SET
prescricao = 'Dipirona 1g, tomar 1 comprimido de 3/3h por 2 dias' -- ATUALIZA APENAS UM ATRIBUTO PRESCRIÇÃO
WHERE id_consulta = 1;

UPDATE SISTEMA.HORARIO_ATENDIMENTO SET
horario = '2026-03-31 11:00:00'  --ATUALIZA O HORARIO DE ATENDIMENTO DO DOUTOR THIAGO MENDES
WHERE id_dentista = 7;

-- Delete

-- REQUISITOS NÃO FUNCIONAIS - EXCLUSÃO DE 3 REGISTROS DA TABELA CONSULTAS
delete from sistema.horario_atendimento
where id_dentista = 2;
select * from sistema.horario_atendimento;
--No dia 30/03/2026, o dentista de id_dentista = 2 não pode comparecer a consulta e solicitou o cancelamento.

delete from sistema.procedimento
where id_procedimento = 5;
select * from sistema.procedimento;
--A clínica não realiza  mais esse tipo de procedimento(clareamneto a laser).

delete from sistema.endereco
where id_endereco = 1;
select * from sistema.procedimento;
--Endereço expirado. CEP inválido.

-------------------------------- CONSULTAS --------------------------------

-- CONSULTA 01
SELECT d.especialidade, count(d.especialidade)
FROM dentista d
JOIN consulta c
ON d.id_dentista = c.id_dentista
GROUP BY d.especialidade;

-- CONSULTA 02
select sd.id_dentista, sd.nome_dentista, coalesce(count(sc.id_consulta), 0) as total_consulta
from sistema.dentista sd
left join sistema.consulta sc on sd.id_dentista = sc.id_dentista
group by sd.id_dentista
order by total_consulta desc;

-- CONSULTA 03
SELECT p.id_paciente, p.nome_paciente, count(id_consulta) qtd
from paciente p
LEFT JOIN consulta c
ON p.id_paciente = c.id_paciente
GROUP BY p.id_paciente
ORDER BY qtd desc;


-- CONSULTA 04
create view view_consultas_ordenadas as
select 
    c.id_consulta, 
    p.nome_paciente, 
    d.nome_dentista, 
    c.data_hora as data_consulta, 
    string_agg(pr.nome_procedimento, ', ') as procedimentos_realizados
from sistema.consulta c
join sistema.paciente p on c.id_paciente = p.id_paciente
join sistema.dentista d on c.id_dentista = d.id_dentista
join sistema.consulta_procedimento cp on c.id_consulta = cp.id_consulta
join sistema.procedimento pr on cp.id_procedimento = pr.id_procedimento
group by 
    c.id_consulta, 
    p.nome_paciente, 
    d.nome_dentista, 
    c.data_hora
order by 
    data_consulta desc;

SELECT * FROM view_consultas_ordenadas;
	
-- CONSULTA 05

SELECT Round(avg(qtd), 2) AS media_de_consultas_por_dentista
FROM(
	SELECT count(c.id_dentista) qtd
	FROM dentista d
	LEFT JOIN consulta c
	ON d.id_dentista = c.id_dentista
	GROUP BY d.id_dentista
	ORDER BY d.id_dentista);
