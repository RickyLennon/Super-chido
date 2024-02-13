drop database if exists Tarea_4;

create database Tarea_4;

use Tarea_4;

create table Orden(
    Id INT auto_increment primary key,
    Nom_art VARCHAR(30) default 'X',
    Tipo_art VARCHAR(30) default 'Y',
    Cantidad INT not null
);

create table Pagar(
    Precio_art FLOAT(5, 2) not null,
    Monto_trans FLOAT(5, 2) not null,
    Tipo_trans VARCHAR(30) default 'W', 
    Orden_Id INT references Orden (Id)
); 

create table Genero(
    GPR VARCHAR(30) default 'V' 
); 

create table Dia(
    Fecha DATE not null,
    Hora_venta VARCHAR(30) default 'Z' 
);

show tables;

describe Pagar;

insert into Orden (Nom_art, Tipo_art, Cantidad) values
       ('Aalopuri', 'Comida rapida', 13),
       ('Vadapav', 'Comida rapida', 15),
       ('Vadapav', 'Comida rapida', 1),
       ('Jugo caña de azucar', 'Bebidas', 6),
       ('Jugo caña de azucar', 'Bebidas', 8),
       ('Vadapav', 'Comida rapida', 10),
       ('Jugo caña de azucar', 'Bebidas', 9),
       ('Panipuri', 'Comida rapida', 14),
       ('Panipuri', 'Comida rapida', 1),
       ('Panipuri', 'Comida rapida', 5),
       ('Frankie', 'Comida rapida', 8),
       ('Vadapav', 'Comida rapida', 8),
       ('Panipuri', 'Comida rapida', 9),
       ('Frankie', 'Comida rapida', 4),
       ('Aalopuri', 'Comida rapida', 3),
       ('Sandwich', 'Comida rapida', 11),
       ('Panipuri', 'Comida rapida', 11),
       ('Panipuri', 'Comida rapida', 10),
       ('Panipuri', 'Comida rapida', 11),
       ('Cafe frio', 'Bebidas', 10);
              
select * from Orden;

insert into Pagar (Precio_art, Monto_trans, Tipo_trans, Orden_Id) values
       (20.00, 260.00, 'Cheque', 1),
       (20.00, 300.00, 'Efectivo', 2),
       (20.00, 20.00, 'Efectivo', 3),
       (25.00, 150.00, 'Virtual', 4),
       (25.00, 200.00, 'Virtual', 5),
       (20.00, 200.00, 'Efectivo', 6),
       (25.00, 225.00, 'Efectivo', 7),
       (20.00, 280.00, 'Virtual', 8),
       (20.00, 20.00, 'Efectivo', 9),
       (20.00, 100.00, 'Virtual', 10),
       (50.00, 400.00, 'Virtual', 11),
       (20.00, 160.00, 'Virtual', 12),
       (20.00, 180.00, 'Virtual', 13),
       (50.00, 200.00, 'Virtual', 14),
       (20.00, 60.00, 'Efectivo', 15),
       (60.00, 660.00, 'Cheque', 16),
       (20.00, 220.00, 'Efectivo', 17),
       (20.00, 200.00, 'Efectivo', 18),
       (20.00, 220.00, 'Efectivo', 19),
       (40.00, 400.00, 'Virtual', 20);
      
select * from Pagar;

insert into Genero (GPR) values
       ('Sr.'),
       ('Sr.'),
       ('Sr.'),
       ('Sr.'),
       ('Sr.'),
       ('Sr.'),
       ('Sr.'),
       ('Sr.'),
       ('Sra.'),
       ('Sr.'),
       ('Sra.'),
       ('Sra.'),
       ('Sra.'),
       ('Sr.'),
       ('Sra.'),
       ('Sra.'),
       ('Sra.'),
       ('Sra.'),
       ('Sra.'),
       ('Sr.');
      
select * from Genero;

insert into Dia (Fecha, Hora_venta) values
       ("2022-07-03", 'Noche'),
       ("2022-08-23", 'Tarde'),
       ("2022-11-20", 'Tarde'),
       ("2023-02-03", 'Noche'),
       ("2022-10-02", 'Tarde/noche'),
       ("2022-11-14", 'Tarde/noche'),
       ("2022-05-03", 'Tarde/noche'),
       ("2022-12-22", 'Noche'),
       ("2022-06-10", 'Manana'),
       ("2022-09-16", 'Tarde'),
       ("2022-12-01", 'Tarde'),
       ("2022-07-12", 'Noche'),
       ("2022-12-22", 'Tarde'),
       ("2022-11-25", 'Manana'),
       ("2023-02-03", 'Tarde/noche'),
       ("2022-04-14", 'Media noche'),
       ("2022-10-16", 'Manana'),
       ("2022-11-05", 'Noche'),
       ("2022-08-22", 'Noche'),
       ("2022-09-15", 'Noche');

select * from Dia;
