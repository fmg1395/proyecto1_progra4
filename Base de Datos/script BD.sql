DROP SCHEMA IF EXISTS banco_caiman ;

CREATE SCHEMA IF NOT EXISTS banco_caiman
	DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
USE banco_caiman ;

DROP TABLE IF EXISTS banco_caiman.vinculadas;
DROP TABLE IF EXISTS banco_caiman.movimientos;
DROP TABLE IF EXISTS banco_caiman.cuentas;
DROP TABLE IF EXISTS banco_caiman.clientes;

CREATE TABLE IF NOT EXISTS banco_caiman.clientes (
  id VARCHAR(12) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  clave VARCHAR(8) NOT NULL,
  telefono int(10),
  PRIMARY KEY (id))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS banco_caiman.cuentas (
  id int auto_increment NOT NULL,
  cliente varchar(45) not null,
  moneda VARCHAR(3) NOT NULL,
  monto int,
  FOREIGN KEY (cliente) REFERENCES clientes(id),
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

alter table cuentas add constraint cnt_smbl check (moneda in ('CRC','EUR','USD'));
alter table cuentas add constraint mnt_lim check (monto>0);























