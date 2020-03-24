DROP SCHEMA IF EXISTS banco_caiman ;

CREATE SCHEMA IF NOT EXISTS banco_caiman
	DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
USE banco_caiman ;

DROP TABLE IF EXISTS banco_caiman.vinculadas;
DROP TABLE IF EXISTS banco_caiman.movimientos;
DROP TABLE IF EXISTS banco_caiman.cuentas;
DROP TABLE IF EXISTS banco_caiman.usuarios;

CREATE TABLE IF NOT EXISTS banco_caiman.usuarios (
  id VARCHAR(12) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  clave VARCHAR(8) NOT NULL,
  rol VARCHAR(3) NOT NULL,
  telefono int(10),
  PRIMARY KEY (id))
ENGINE = InnoDB;

-- rol puede ser CLI de cliente o CAJ de cajero

CREATE TABLE IF NOT EXISTS banco_caiman.cuentas (
  id int auto_increment NOT NULL,
  cliente varchar(45) not null,
  moneda VARCHAR(3) NOT NULL,
  monto int,
  FOREIGN KEY (cliente) REFERENCES usuarios(id),
  PRIMARY KEY (id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS banco_caiman.movimientos (
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

CREATE TABLE IF NOT EXISTS banco_caiman.vinculadas (
  id_c1 int NOT NULL,
  id_c2 int NOT NULL,
  foreign key (id_c1) references cuentas(id),
  foreign key (id_c2) references cuentas(id),
  primary key(id_c1,id_c2))
ENGINE = InnoDB;

-- id_c1 y id_c2 
-- ID de las cuentas 1 y 2 que 
-- Estan vinculadas 

alter table cuentas add constraint cnt_smbl check (moneda in ('CRC','EUR','USD'));
alter table usuarios add constraint rol_smbl check (rol in ('CLI','CAJ'));
alter table cuentas add constraint mnt_lim check (monto>0);


INSERT INTO	usuarios
	(id,nombre,clave,rol,telefono)
	VALUES
	('116630575','Dafhnne', 'Daf@1','CLI',84125359),
	('116250948','Oscar', 'Osc@2','CLI',84981359),
	('504250570','Erick', 'Erk@3','CLI',69851254),
	('116050901','Frank', 'root','CAJ',84562578),
	('117490582','Enrique', 'root2','CAJ',12569872);
	






















