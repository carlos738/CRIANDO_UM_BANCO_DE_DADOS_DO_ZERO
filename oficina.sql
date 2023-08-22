create database oficina;
use oficina;

-- CRIANDO A TABLE CLIENTE

create table cliente(
idcliente int auto_increment primary key,
nome varchar (35) not null,
endereco varchar(65) not null,
email varchar(45),
contato varchar(40),
documento varchar(25)
);
select * from cliente order by documento;
desc cliente;

-- CRIANDO TABLE VEÍCULO
create table veiculo(
idveiculo int auto_increment primary key,
    idcliente int,
    placa char(7),
    modelo varchar(40),
    marca varchar(40),
    ano int,
    cor varchar(20),
    constraint fk_veiculo_cliente foreign key (idcliente) references cliente (idcliente)   
);
desc veiculo;

-- CRIAR TABLE MECÂNICO
create table mecanico(
idmecanico int auto_increment primary key,
idveiculo int,
nome varchar(40) not null,
endereco varchar(55),
especialidade varchar(40),
constraint fk_mecanico_veiculo foreign key(idveiculo)references veiculo(idveiculo)
);
select * from mecanico order by especialidade;
desc mecanico;

-- CRIAR A TABLE ORDEM DE SERVIÇO
create table ordemServico(
idordemServico int auto_increment primary key,
dataEmissao date,
desconto float,
autorizada boolean,
status varchar(55),
dataDeConclusao date
);
desc ordemServico;

-- CRIAR TABLE MECANICO_ORDEMSERVICO
create table mecanico_ordemServico(
idmecanico int,
idordemServico int,
constraint fk_ordemServico_mecanico foreign key
(idmecanico) references mecanico(idmecanico),
constraint fk_ordemServico_ordemServico foreign key(idordemServico)
references ordemServico(idordemServico)
 );
 select * from mecanico order by idmecanico;
 desc mecanico_ordemServico;
 
 
 -- CRIAR TABLE PECA
 
 create table peca(
 idpeca int auto_increment primary key,
 modeloCarro varchar(40) not null,
 anoCarro int not null,
 descricaoCarro varchar(45)not null,
 valor float not null
 );
desc peca;

-- CRIAR TABELA ITEM_ORDEM_SERVICO
create table item_ordemServico(
idordemServico int not null,
itemordemServico int not null,
valor float not null,
desconto float,
primary key pk_ordemServico(idordemServico,itemordemServico),
constraint fk_itemordemServico foreign key(idordemServico)
references ordemServico(idordemServico)
);
desc item_ordemServico;

-- alter tabel item_ordemServico add tipo boolean;

-- CRIAR TABEL MAO DE OBRA

create table maoDeObra(
idmaoDeObra int auto_increment primary key not null,
itemordemServico int not null,
descricao varchar(75) not null,
valor float not null
);

desc maoDeObra;
show tables;

insert into cliente(nome,endereco,contato,documento,email)values
('James Wong','Rua C',31254879811,00212144545,'so@gmail.com'),
('Clow Winter', 'Rua 10',31987987454,00001114447,'c@hotmail.com'),
('Clover Geter','Rua 7',7788797877,00000000321,'cg@gmail.com'),
('Marin Pink','Rua Q',12121212132,23434567876,'m@hotmail.com');

desc cliente;
select * from cliente;

insert into veiculo(placa,modelo,marca,ano,cor)
values(1,'BBV0121','FERRARI',2022,'VERMELHA'),
(3,'CCC0124','CORSA',2007,'PRETO'),
(5,'ASQ1122','GOL',1999,'AZUL'),
(4,'VCB0987','FORD ',2000,'BRANCO');

select * from veiculo;
select c.nome as Cliente, c.contato as Contato, v.placa, v.modelo from cliente c, veiculo v 
	where  c.idcliente = v.idcliente;
    
    desc mecanico;
insert into mecanico(idveiculo,nome,endereco,especialidade)
values(5,'mecânico2 OSVALOD','Rua J 45','Motor'),
(2,'mecânico3 José','Rua C 35','Aerodinâmica'),
(1,'mecânico1 Luiza','Rua D 45','CHEFE DE EQUIPE'),
(3,'mecânico4 Paulo','Rua o 8','Especialista em Eletrônica' );    
select * from mecanico;   
select * from mecanico order by idmecanico;
select m.nome,m.especialidade,v.placa,v.marca from mecanico as m, veiculo as v 
	where m.idveiculo = v.idveiculo;
select m.nome,m.especialidade,v.placa,v.marca from mecanico m inner join veiculo v
	where m.idveiculo = v.idveiculo;
    

  insert into ordemServico (dataEmissao, desconto, status, dataDeConclusao, autorizada) values
	('2022-09-03',9,'status ordem servico 1','2022-10-04',true),
    ('2022-07-03',12,'status ordem servico 2','2022-09-04',true),
    ('2022-09-13',10,'status ordem servico 3','2022-11-01',true),
    ('2022-09-15',32,'status ordem servico 4','2022-09-30',false),
    ('2022-09-22',17,'status ordem servico 5','2022-09-27',true);
  
    
    select * from ordemServico;
    select * from ordemServico order by  idordemServico;
    select * from mecanico;
    
    -- inserindo dados na tabela mecanico_ordemServico
    insert into mecanico_ordemServico values
	(2,6),
    (1,7),
    (3,8),
    (4,9),
    (2,10);
   
-- inserindo dados na tabela peca
insert into peca(descricaoCarro,modeloCarro,anoCarro,valor)
values('Peca 8','modelo carro 1',2020,111.11),
    ('Peca 3','modelo carro 5',2000,34),
    ('Peca 2','modelo carro 3',2000,2.22),
    ('Peca 6','modelo carro 2',1998,51.4),
    ('Peca 1','modelo carro 6',1997,66);
desc peca;
select * from peca;
delete from peca where idpeca >= 3;

-- inserindo dados na tabela item_ordemServico

insert into item_ordemServico (idordemServico, itemordemServico, valor , desconto) values
	(6,1,181.11,20),
    (6,2,232,2),
    (7,1,79,0),
    (8,1,288,0),
    (8,2,47,10),
    (8,3,111,0),
    (9,1,99,9),
    (10,1,1800,10);
    
    select * from item_ordemServico;
    
select o.idordemServico, i.itemordemServico,i.valor,i.desconto from ordemServico o, 
	item_ordemServico i where o.idordemServico = i.idordemServico;
  
  
  -- INSERINDO DADO NA TABELA maoDeObra
  
   insert into maoDeObra (itemordemServico, descricao, valor) values
	(1,'descricao mao de obra 1',291),
    (2,'descricao mao de obra 2',22),
    (3,'descricao mao de obra 3',3.733),
    (4,'descricao mao de obra 4',464);
select * from maoDeObra
inner join  maoDeObra o on o.idmaoDeObra = o.idmaoDeObra;


-- RECUPERAÇÃO SIMPLES COM SELECT STATEMENT;
SELECT * FROM oficina.maoDeObra;
select *from oficina.mecanico;
   select *from oficina.veiculo; 
   
   -- FILTROS COM WHERE STATEMENT
   SELECT * FROM oficina.cliente where nome like '2';
   
   -- CRIE EXPRESSÕES PARA GERAR ATRIBUTOS DERIVADOS
 -- select (sum(ValorPeca)+sum(ValorMaoDeObra)) as ValorTotal from oficina.Servico;


-- DEFINIR ORDENAÇÕES DOS DADOS COM ORDER BY
-- SELECT descricaoCarro, (Valorpeca+ValormaoDeObra)as total from
-- oficina.cliente order by total desc;

-- Condições de filtros aos grupos – HAVING Statement
select idpeca from oficina.peca group by idpeca having count(idpeca)<3;

-- Criar junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
select c.Nome
    from oficina.cliente c;
    
    
    
   
    
	
