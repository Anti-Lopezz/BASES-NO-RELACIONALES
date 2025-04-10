-- Creación de la base de datos
create database proyecto_delta;

use proyecto_delta;

-- creación de la tabla efectos
create table efectos (
    id int primary key auto_increment,
    nombre varchar(255) not null,
    descripcion text
);

-- creación de la tabla objetos
create table objetos (
    id int primary key auto_increment,
    nombre varchar(255) not null,
    descripcion text,
    tipo_objeto varchar(255) check (tipo_objeto in ('arma', 'armadura', 'efecto', 'comida', 'material')),
    id_efecto int,
    foreign key (id_efecto) references efectos(id)
);

-- creación de la tabla razas con vinculación a objetos y efectos
create table razas (
    id int primary key auto_increment,
    nombre varchar(255) not null,
    habilidad_1 varchar(255),
    habilidad_2 varchar(255),
    descripcion text,
    id_objeto int,
    id_efecto int,
    foreign key (id_objeto) references objetos(id),
    foreign key (id_efecto) references efectos(id)
);

-- creación de la tabla criaturas con vinculación a objetos y efectos
create table criaturas (
    id int primary key auto_increment,
    nombre varchar(255) not null,
    habilidad varchar(255),
    descripcion text,
    id_objeto int,
    id_efecto int,
    foreign key (id_objeto) references objetos(id),
    foreign key (id_efecto) references efectos(id)
);

-- creación de la tabla ubicaciones
create table ubicaciones (
    id int primary key auto_increment,
    nombre varchar(255) not null,
    tipo_ubicacion varchar(255),
    descripcion text
);

-- creación de la tabla comida con conexión a efectos
create table comida (
    id int primary key auto_increment,
    nombre varchar(255) not null,
    efecto varchar(255),
    descripcion text,
    id_efecto int,
    foreign key (id_efecto) references efectos(id)
);

-- creación de la tabla magia con conexión a efectos
create table magia (
    id int primary key auto_increment,
    nombre varchar(255) not null,
    descripcion text,
    tipo_magia varchar(255) check (tipo_magia in ('piromancia', 'criomania', 'primus', 'otros')),
    id_efecto int,
    foreign key (id_efecto) references efectos(id)
);

-- creación de la tabla materiales
create table materiales (
    id int primary key auto_increment,
    nombre varchar(255) not null,
    tipo_material varchar(255),
    descripcion text
);

-- creación de la tabla estilos_de_combates con conexiones a objetos, razas y criaturas
create table estilos_de_combates (
    id int primary key auto_increment,
    nombre varchar(255) not null,
    descripcion text,
    id_objeto int,
    id_raza int,
    id_criatura int,
    foreign key (id_objeto) references objetos(id),
    foreign key (id_raza) references razas(id),
    foreign key (id_criatura) references criaturas(id)
);


drop database proyecto_delta;