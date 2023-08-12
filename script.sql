create database aula_sql;

use aula_sql;

### SCRIPT FUTEBOL ###
create table posicao(
                        idPosicao	int primary key
    ,	nome		varchar(20) not null
);

insert into posicao(idPosicao, nome)
values(1, 'Goleiro'), (2, 'Zagueiro'), (3, 'Meio-campo'), (4, 'Atacante');

create table time(
                    idTime	int primary key
    ,	nome	varchar(50) not null
    ,	estado	char(2)
);

insert into time(idTime, nome, estado)
values(1, 'Atlético', 'MG')
,	  (2, 'Cruzeiro', 'MG')
,	  (3, 'Flamengo', 'RJ');

create table jogador(
                        idJogador		int primary key
    ,	nome			varchar(100) not null
    ,	salario			numeric(10,2)
    ,	dataNascimento             datetime
    ,	idPosicao		int not null
    ,	idTime		              int null
    ,            FOREIGN KEY(idPosicao) REFERENCES posicao(idPosicao)
    ,            FOREIGN KEY(idTime) REFERENCES time(idTime)
);

insert into jogador(idJogador, nome, salario, dataNascimento, idPosicao, idTime)
values (1, 'Everson', 150000, '1995-10-01', 1, 1)
,	   (5, 'Diego Tardeli', null, '1991-05-03', 4, null)
,	   (2, 'Incrível Hulk', 850000, '1990-10-12', 4, 1)
,	   (3, 'Fábio', 100000, '1982-04-11', 1, 2)
,	   (4, 'Edu', 150000, '1983-09-10', 4, 2)
