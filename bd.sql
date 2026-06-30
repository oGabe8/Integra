create database cantina character set utf8mb4 collate utf8mb4_unicode_ci;
use cantina;

-- Tabela Alunos com os campos de saúde integrados
create table alunos (
id_aluno int auto_increment primary key,
nome varchar(100) not null,
matricula varchar(30) not null unique,
senha varchar(50) not null,
turma varchar(30) not null default 'nao informada',
status_cadastro varchar(20) not null default 'ativo',
comorbidades varchar(255) default '',
atestado_arquivo varchar(255) default '',
data_cadastro timestamp default current_timestamp
) engine=innodb default charset=utf8mb4;


-- Tabela  Admins
create table usuarios (
id_usuario int auto_increment primary key,
nome varchar(100) not null,
login varchar(50) not null unique,
senha varchar(50) not null,
perfil enum('admin', 'nutricionista') not null
) engine=innodb default charset=utf8mb4;


-- Tabela Cardápio semanal
create table cardapio (
id_cardapio int auto_increment primary key,
dia_semana varchar(30) not null,
refeicao_principal varchar(255) not null,
acompanhamentos varchar(255) default '',
fruta_sobremesa varchar(100) default ''
) engine=innodb default charset=utf8mb4;


-- Tabela Agendamentos
create table agendamentos (
id_grid_reserva int auto_increment primary key,
id_aluno int not null,
id_cardapio int not null,
data_reserva timestamp default current_timestamp,
status_reserva varchar(20) not null default 'confirmado',
foreign key (id_cardapio) references cardapio(id_cardapio),
foreign key (id_aluno) references alunos(id_aluno) on delete cascade
) engine=innodb default charset=utf8mb4;


-- Tabela avisos
create table avisos (
id_aviso int auto_increment primary key,
titulo varchar(100) not null,
conteudo text not null,
tipo_icone varchar(20) default 'bell',
data_publicacao timestamp default current_timestamp,
ativo tinyint(1) default 1
) engine=innodb default charset=utf8mb4;


-- Tabela Estoque
create table estoque (
id_item int auto_increment primary key,
nome_item varchar(100) not null,
quantidade_disponivel int not null default 0,
unidade_medida varchar(10) not null default 'unidade'
) engine=innodb default charset=utf8mb4;


-- Carga de dados iniciais

-- Usuários Admins
insert into usuarios (id_usuario, nome, login, senha, perfil) values
(1, 'administrador', 'admin', 'admin123', 'admin'),
(2, 'ana nutricionista', 'nutri', 'nutri123', 'nutricionista');


-- Alunos com Comorbidades e Restrições já preenchidas
insert into alunos (id_aluno, nome, matricula, senha, turma, status_cadastro, comorbidades, atestado_arquivo) values
(1, 'Lucas Camacho', '123', '123', '3º ano a', 'ativo', 'Diabetes, Intolerancia a lactose, Hipertensão', 'atestado.pdf'),
(2, 'Maria silva', '456', '456', '2º ano b', 'ativo', 'Intolerancia a lactose', ''),
(3, 'Jao costa', '789', '789', '1º ano c', 'ativo', '', ''),
(4, 'Ana beatriz', '001', '001', '1º ano a', 'ativo', '', ''),
(5, 'Lucas pereira', '002', '002', '2º ano a', 'ativo', 'Alergia a amendoim', ''),
(6, 'Fernanda oliveira', '003', '003', '3º ano b', 'ativo', '', ''),
(7, 'Rafael santos', '004', '004', '2º ano c', 'ativo', '', ''),
(8, 'Juliana martins', '005', '005', '1º ano b', 'ativo', 'Diabetes', ''),
(9, 'Pedro alves', '006', '006', '3º ano c', 'ativo', '', ''),
(10, 'Camila rodrigues', '007', '007', '2º ano b', 'ativo', '', ''),
(11, 'Thiago nascimento', '008', '008', '1º ano a', 'ativo', '', ''),
(12, 'Larissa ferreira', '009', '009', '3º ano a', 'ativo', '', '');


-- Cardápio semanal travado com ids do sistema
insert into cardapio (id_cardapio, dia_semana, refeicao_principal, acompanhamentos, fruta_sobremesa) values
(1, 'Segunda-Feira', 'Frango Grelhado', 'Arroz, Feijão e salada verde', '🍌 Banana'),
(2, 'Terça-Feira', 'Macarrao ao Molho', 'Salada verde e cenoura', '🍊 Laranja'),
(3, 'Quarta-Feira', 'Bife Acebolado', 'Arroz, lentilha e cenoura cozida','  🍎Maçã'),
(4, 'Quinta-Feira', 'Peixe Assado', 'Arroz, feijão e brócolis', '🍈 Melão'),
(5, 'Sexta-Feira', 'Frango à Parmegiana', 'Arroz, feijão e purê de batata', '🍮 Gelatina');


-- Mural de avisos da pág inicial
insert into avisos (id_aviso, titulo, conteudo, tipo_icone) values
(1, 'Distribuicao de Lanches', 'Amanha a distribuição comecara ás 10h no refeitorio principal.', 'bell'),
(2, 'Cardapio Especial', 'Preparamos um dia da saude nesta semana com frutas e sucos naturais!', 'star'),
(3, 'Lembrete Importante', 'Atualize seu cadastro na secretaria caso mude de turma.', 'info'),
(4, 'Semana da Nutricao', 'De 15 a 19 de junho teremos palestras sobre alimentação saudável para todos os alunos.', 'leaf'),
(5, 'Novo Horário', 'A partir de segunda-feira o refeitório abre ás 11h30 e fecha ás 12h15.', 'clock');


-- Itens do Estoque
insert into estoque (id_item, nome_item, quantidade_disponivel, unidade_medida) values
(1, 'Arroz', 50, 'KG'),
(2, 'Feijao', 30, 'KG'),
(3, 'Frango', 25, 'KG'),
(4, 'Azeite', 10, 'Litro'),
(5, 'Macarrao', 20, 'KG'),
(6, 'Sal', 5, 'KG'),
(7, 'Banana', 100, 'Unidade'),
(8, 'Laranja', 80, 'Unidade'),
(9, 'Leite', 15, 'Litro'),
(10, 'Pão de forma', 40, 'Unidade'),
(11, 'Tomate', 4, 'KG'),
(12, 'Alface', 8, 'Unidade');
commit;