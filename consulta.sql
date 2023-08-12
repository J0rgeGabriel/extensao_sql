show databases ;
use aula_sql;


SELECT nome, salario, COALESCE(salario * 12, 0) AS "Salário anual", COALESCE(salario * 12, 0) + 10000
FROM jogador
WHERE COALESCE(salario * 12, 0) >= 1800000
ORDER BY "Salário anual" DESC;


SELECT UPPER(nome) AS TIME
,   LOWER(nome) AS 'Time de minusculo'
,   nome
,   estado
,   idTime
FROM    time
WHERE   UPPER(estado) = 'MG';

#quando o professor usar ISNULL eu uso o COALESCE
# porem o IS NOT NULL eu posso usar normalmente pois ele é universal
select 	nome
,		COALESCE(salario,0) * 12 as "Salario anual"
,		salario
,		idtime
from 	jogador
where 	idTime is not null;


SELECT idtime, nome, CONCAT(nome, '/', COALESCE(estado, 'Sem estado')) AS "time e estado"
FROM time;


select *
from jogador
where nome like '%l_';
-- <>%<> significa que vai puxar o nome do jogador que começa ou termina com determinada letra
-- %l_ significa que vai puxar o nome do jogador que a penultima letra é <L>


select 	nome
,		INSTR('r', nome)
,		substring(nome, INSTR(' ', nome), 3)
from 	jogador
where   nome like '% %';


SELECT nome,
     INSTR(nome, ' '),
     SUBSTR(nome, INSTR(nome, ' ') + 1, 2)
FROM jogador
WHERE INSTR(nome, ' ') > 0;
-- quando o professor usa CHARINDEX eu devo usar o INSTR


select j.nome AS jogador,
     salario,
     t.nome AS Time
from jogador j
inner join time t
on  j.idTime = t.idTime
where j.idTime = 1;


select 	j.nome as "Nome do Jogador"
,		j.salario
,		t.nome  as "Nome do Time"
,		p.nome as Posição
from 	jogador j
inner join time t
	on  j.idTime = t.idtime
inner join posicao p
	on j.idposicao = p.idposicao;


select 	*
from 	 jogador j	
left outer join time t       
	on  j.idTime = t.idtime;


select 	*
from 	 jogador j	
left join time t
	on  j.idTime = t.idtime;


SELECT *
FROM jogador j
LEFT JOIN time t ON j.idTime = t.idtime
UNION        #quando o professor usa professor usar FULL eu devo usar o UNION
SELECT *
FROM jogador j
RIGHT JOIN time t ON j.idTime = t.idtime;


-- criação da tabela parametro
CREATE TABLE parametro (
percDesconto NUMERIC(10,2)
);

-- inserindo um valor na tabela parametro
INSERT INTO parametro VALUES (0.2);

-- selecionando a tabela parametro
SELECT * FROM parametro;

SELECT j.nome, j.salario, p.percDesconto
FROM jogador j
CROSS JOIN parametro p;


select  nome
,		salario
,		upper(nome) as 'Nome em maiúsculo'
,		lower(nome) as 'Nome em minúsculo'
FROM	jogador;


select  sum(salario) as Soma
,		avg(salario) as Média
,		min(salario) as Menor
,		max(salario) as Maior
,		count(*) as 'Quantidade de jogadores'
FROM	jogador;     


SELECT 
avg(salario) AS "Média Salarial", 
min(salario) AS 'Menor Salário', 
max(salario) AS Maior, 
min(nome), 
max(nome), 
min(datanascimento), 
max(datanascimento), 
count(*) 'Quantidade de jogadores', 
SUM(salario) AS 'Soma dos Salários'
FROM jogador;


SELECT COUNT(*)
,      COUNT(idjogador)
,      COUNT(salario)
from jogador;


#para selecionar os dados
SELECT * FROM time;
#para fazer a consulta
SELECT COUNT(estado) FROM time;


SELECT * FROM jogador
ORDER BY idtime;

SELECT SUM(salario) AS `Soma dos salários`,
     MIN(salario) AS `Menor Salário`,
     MAX(salario) AS `Maior Salário`,
     COUNT(*) AS `Quantidade de jogadores`,
     t.nome
FROM jogador j
JOIN time t ON t.idtime = j.idtime
GROUP BY t.nome;


SELECT 
SUM(salario) as 'Soma dos salários',
MIN(salario) as 'Menor Salário',
MAX(salario) as 'Maior Salário',
COUNT(*) as 'Quantidade de jogadores',
p.nome
FROM 
jogador j
JOIN 
posicao p ON p.idposicao = j.idposicao
GROUP BY 
p.nome
HAVING 
COUNT(*) >= 3;


SELECT *
FROM jogador
ORDER BY nome
LIMIT 0, 100;


#Exibir todos os jogadores que possuem a mesma posição que o jogador do codigo 2
SELECT *
from jogador
where idposicao = 
(
     SELECT idPosicao
     from jogador
     where idjogador = 2
)
and idjogador <> 2       #<>: significa diferença;


#exibir a diferença entre salario de cada jogador e a media salarial de todos os jogadores
SELECT nome,
salario,
salario - (SELECT avg(salario) from jogador)
from jogador