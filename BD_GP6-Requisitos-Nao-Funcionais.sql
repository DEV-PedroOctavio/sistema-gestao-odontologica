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