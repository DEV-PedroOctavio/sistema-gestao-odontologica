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