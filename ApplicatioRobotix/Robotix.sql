drop database if exists Robotix;
create database Robotix;

use Robotix;

create table administradores(
	correoAd varchar(100),
    nombreAd varchar(100),
    contraseñaAd varchar(30)
);

create table maestros(
	correoM varchar(100),
    nombreM varchar(100),
    contraseñaM varchar(30)
);

create table alumnos(
	correoAl varchar(100),
    nombreAl varchar(100),
    grupo varchar(4),
    boleta int,
    contraseñaAl varchar(30)
);

create table computadoras(
NumeroPC int,
Lab varchar(40),
Hora int,
Alumno varchar(100));

select * from administradores;
select * from maestros;
select * from alumnos;
select * from computadoras;