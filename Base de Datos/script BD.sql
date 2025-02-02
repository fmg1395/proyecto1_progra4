DROP SCHEMA IF EXISTS eif209_2001_p01b ;

CREATE SCHEMA IF NOT EXISTS eif209_2001_p01b
	DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
USE eif209_2001_p01b ;

DROP TABLE IF EXISTS eif209_2001_p01b.vinculadas;
DROP TABLE IF EXISTS eif209_2001_p01b.movimientos;
DROP TABLE IF EXISTS eif209_2001_p01b.cuentas;
DROP TABLE IF EXISTS eif209_2001_p01b.usuarios;

-- rol puede ser CLI de cliente o CAJ de cajero
CREATE TABLE IF NOT EXISTS eif209_2001_p01b.usuarios (
  id VARCHAR(12) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  clave VARCHAR(8) NOT NULL,
  rol VARCHAR(3) NOT NULL,
  telefono int(10),
  PRIMARY KEY (id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS eif209_2001_p01b.moneda (
  id varchar(3) NOT NULL,
  tipo_cambio int,
  PRIMARY KEY (id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS eif209_2001_p01b.tipo_cuentas
(id int(1) NOT NULL,
descripcion varchar(45),
PRIMARY KEY (id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS eif209_2001_p01b.intereses
(tipo_cuenta int(1),
moneda varchar(3),
tasa_interes DOUBLE,
FOREIGN KEY (tipo_cuenta) REFERENCES tipo_cuentas(id),
FOREIGN KEY (moneda) REFERENCES moneda(id),
PRIMARY KEY (tipo_cuenta,moneda))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS eif209_2001_p01b.cuentas (
  id int auto_increment NOT NULL,
  tipo_cuenta int(1) NOT NULL,
  cliente varchar(45) not null,
  moneda VARCHAR(3) NOT NULL,
  monto int,
  limite_transferencias int,
  FOREIGN KEY (tipo_cuenta) REFERENCES tipo_cuentas(id),
  FOREIGN KEY (cliente) REFERENCES usuarios(id),
  FOREIGN KEY (moneda) REFERENCES moneda(id),
  PRIMARY KEY (id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS eif209_2001_p01b.movimientos (
  id int auto_increment NOT NULL,
  cuenta_org int,
  cuenta_des int NOT NULL,
  monto int NOT NULL,
  fecha date NOT NULL,
  id_depos varchar(45) not null,
  nombre_depos varchar(45),
  detalle varchar(30),
  FOREIGN KEY (cuenta_des) REFERENCES cuentas(id),
  PRIMARY KEY (id))
ENGINE = InnoDB;
-- id_depos: ID del depositante
-- nombre_depos: nombre del depositante
-- en caso de que no sea una tranferencia en el mismo banco

CREATE TABLE IF NOT EXISTS eif209_2001_p01b.vinculadas (
  id_c1 int NOT NULL,
  id_c2 int NOT NULL,
  foreign key (id_c1) references cuentas(id),
  foreign key (id_c2) references cuentas(id),
  primary key(id_c1,id_c2))
ENGINE = InnoDB;

-- id_c1 y id_c2 
-- ID de las cuentas 1 y 2 que 
-- Estan vinculadas 

alter table moneda add constraint cnt_smbl check (id in ('CRC','EUR','USD'));
alter table usuarios add constraint rol_smbl check (rol in ('CLI','CAJ'));
alter table cuentas add constraint mnt_lim check (monto>=0);


INSERT INTO	usuarios
	(id,nombre,clave,rol,telefono)
	VALUES
	('116630575','Dafhnne', 'Daf@1','CLI',84125359),
	('116250948','Oscar', 'Osc@2','CLI',84981359),
	('504250570','Erick', 'Erk@3','CLI',69851254),
	('116050901','Frank', 'root','CAJ',84562578),
	('117490582','Enrique', 'root2','CAJ',12569872);
    
INSERT INTO tipo_cuentas
	(id,descripcion)
    VALUES
    (0,"corriente"),
    (1,"ahorros");
    
INSERT INTO moneda
	(id,tipo_cambio)
    VALUES
	('EUR',647.72),
    ('CRC',0),
    ('USD', 586);
    
INSERT INTO intereses 
	(tipo_cuenta,moneda,tasa_interes)
    VALUES
    (0,"CRC",0.02),
    (1,"CRC",0.02),
    (0,"USD",0.02),
    (1,"USD",0.02),
    (0,"EUR",0.02),
    (1,"EUR",0.02);
    
INSERT INTO cuentas
	(cliente,moneda,monto,tipo_cuenta,limite_transferencias)
    VALUES
    ('116050901','CRC',1000,1,5),
    ('117490582','USD',500000,0,6),
    ('504250570','EUR',200,1,7),
	('504250570','CRC',5480000,1,8),
	('504250570','USD',75,0,9);
    
	






















