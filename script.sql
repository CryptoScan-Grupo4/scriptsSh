CREATE DATABASE IF NOT EXISTS CryptoScan;
USE CryptoScan;

CREATE TABLE Token (
idToken INT PRIMARY KEY AUTO_INCREMENT,
token VARCHAR(45),
dataEmitida timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Token (token) VALUES
	('123');


CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR(45),
telEmpresa CHAR(10),
cepEmpresa CHAR(9),
numEndereco VARCHAR(10),
cpnjEmpresa VARCHAR(45),
fkToken INT,
FOREIGN KEY (fkToken) REFERENCES Token(idToken)
);

INSERT INTO Empresa (nomeEmpresa, fkToken)  VALUES 
	('Minera&Minera', 1);

CREATE TABLE TipoConta(
idTipoConta INT PRIMARY KEY AUTO_INCREMENT,
tipoConta VARCHAR(45)
);

INSERT INTO TipoConta (tipoConta) VALUES 
	('ADM'),
    ('Funcionario');

CREATE TABLE Funcionario (
idFuncionario INT AUTO_INCREMENT,
nomeFuncionario VARCHAR(45),
rgFuncionario CHAR(10),
cpfFuncionario VARCHAR(45),
emailFuncionario VARCHAR(45),
Senha VARCHAR(45),
fkTipoConta INT,
fkEmpresa INT,
FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
FOREIGN KEY (fkTipoConta) REFERENCES TipoConta(idTipoConta),
PRIMARY KEY(idFuncionario, fkTipoConta)
);

INSERT INTO Funcionario (nomeFuncionario, emailFuncionario, Senha, fkEmpresa ,fkTipoConta) VALUES
	('Lucas Santos' , 'lucas@email.com', '123', 1  , 1),
	('Hamilton Silva' , 'hamilton@email.com' , '123' , 1 , 2);


CREATE TABLE Setor (
idSetor INT AUTO_INCREMENT,
Andar VARCHAR(45),
fkEmpresa INT,
fkFuncionarioResponsavel INT,
FOREIGN KEY (fkFuncionarioResponsavel) REFERENCES Funcionario(idFuncionario),
FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
PRIMARY KEY(idSetor, fkEmpresa)	
);

INSERT INTO Setor VALUES 
	(NULL, '3' , 1, 1),
	(NULL, '4' , 1, NULL),
	(NULL, '5' , 1, NULL);
    

CREATE TABLE Computador(
idComputador INT AUTO_INCREMENT,
serialComputador VARCHAR(45),
statusAtividade VARCHAR(10),
fkEmpresa INT,
fkSetor INT,
FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
FOREIGN KEY (fkSetor) REFERENCES Setor(idSetor),
PRIMARY KEY (idComputador, fkEmpresa)
);

INSERT INTO Computador VALUES 
	(NULL, '455' , 'On'  , 1, 1),
	(NULL, '244',  'Off' , 1, 1),
	(NULL, '255',  'Off' , 1, 1);
    
CREATE TABLE Setup(
idSetup INT AUTO_INCREMENT,
fkComputador INT,
dataCriacao timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (idSetup, fkComputador),
FOREIGN KEY (fkComputador) REFERENCES Computador(idComputador)
);

INSERT INTO Setup (idSetup , fkComputador) VALUES
	(NULL , 1),
	(NULL , 1),
	(NULL , 1),
	(NULL , 1);
    
CREATE TABLE Componente(
idComponente INT PRIMARY KEY auto_increment,
nomeModelo VARCHAR(45),
modeloComponente VARCHAR(45),
tipoComponente VARCHAR(45),
fkSetup INT,
FOREIGN KEY (fkSetup) REFERENCES Setup(idSetup)
);

INSERT INTO Componente (nomeModelo, modeloComponente, tipoComponente, fkSetup) VALUES
	('Intel',  'I9' , 'Processador' , 1 ),
	('Fury', 'DDR5 32GB' , 'Memoria RAM' , 1 ),
	('Fury' , 'DDR5 32GB' , 'Memoria RAM' , 1 ),
	('HD' , 'Seagate' , 'HD' , 1 ),
	('Internet' , NULL , 'Internet - Dowload' , 1 ),
	('Internet' , NULL , 'Internet - Upload' , 1 ),
   	('GPU' , NULL, 'Placa de video', 1);
    
    
CREATE TABLE UnidadeComponente(
idUnidadeComponente INT AUTO_INCREMENT,
unidadeComponente VARCHAR(45),
totalComponente FLOAT,
fkComponente INT,
FOREIGN KEY (fkComponente) REFERENCES Componente (idComponente),
PRIMARY KEY (idUnidadeComponente, fkComponente)
);


CREATE TABLE Medida(
idMedida INT AUTO_INCREMENT,
medida FLOAT,
dataHoraMedida timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
fkComponente INT,
fkSetup INT,
FOREIGN KEY (fkComponente) REFERENCES Componente(idComponente),
FOREIGN KEY (fkSetup) REFERENCES Setup(idSetup),
PRIMARY KEY(idMedida,fkComponente, fkSetup)
);



