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