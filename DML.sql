-- inserción de tablas
insert into objetos (nombre, descripcion, tipo_objeto) values 
('espada', 'espada de plata para combatir a los feroces enemigos', 'arma'),
('martillo', 'martillo ideal para usarlo como arma si tienes fuerza', 'arma');
select * from objetos;

insert into comida (nombre, descripcion) values 
('lúgamo', 'un hongo curativo de sabor dulce que regenera salud durante un breve período'),
('amargol', 'un hongo venenoso que inflige daño progresivo al objetivo durante un tiempo'),
('aceronox', 'hongo brillante que incrementa la velocidad de movimiento'),
('carne de lobo sombra', 'cura, pero provoca una ligera sensación de dolor muscular'),
('escamas de camalús', 'proporciona resistencia al veneno, pero con posibilidad de parálisis'),
('potentia', 'verdura que aumenta la potencia de los ataques cuerpo a cuerpo'),
('resilix', 'fruta que otorga una mayor resistencia física y mágica');
select * from comida;

insert into materiales (nombre, descripcion) values 
('ferrox', 'metal resistente y versátil para armas y armaduras'),
('cobreza', 'metal rojizo ideal para la creación de herramientas y componentes'),
('cuartex', 'cuero de gran resistencia para armaduras ligeras'),
('pielmar', 'material adaptable obtenido de criaturas salvajes'),
('sylvium', 'madera de alta calidad utilizada para arcos y bastones'),
('rocath', 'roca dura y densa para construcción de fortalezas');
select * from materiales;

insert into efectos (nombre, descripcion) values 
('celeridad', 'aumenta la velocidad de movimiento del objetivo'),
('curación', 'regenera una cantidad de vida durante un tiempo determinado'),
('veneno', 'resta vida al objetivo durante un tiempo determinado'),
('dolor muscular', 'reduce la velocidad de movimiento por efectos como frío o veneno'),
('parálisis', 'el objetivo queda inmóvil temporalmente por acumulación de dolor muscular'),
('quemadura', 'causa daño continuo por contacto con fuego'),
('congelación', 'el objetivo se congela, quedando inmóvil y vulnerable');
select * from efectos;

insert into ubicaciones (nombre, descripcion, tipo_ubicacion) values 
('bosque de nyrith', 'lugar devastado por residuos mágicos tóxicos y criaturas mutadas', 'bosque'),
('pueblo de arinor', 'ruinas tras la explosión mágica de la guerra', 'pueblo'),
('la arena de eryx', 'duelos eternos de los guerreros más poderosos', 'arena');
select * from ubicaciones;

insert into criaturas (nombre, habilidad, descripcion, id_objeto, id_efecto) values 
('camalús', 'camuflaje', 'reptil con escamas que cambian de color para camuflarse', null, null),
('lobo sombra', 'conexión telepática', 'lobo pequeño y peligroso con conexión telepática', null, null),
('el lamento', 'magia oscura', 'espíritu maligno de magia oscura nacido de la gran guerra mágica', null, null);
select * from criaturas;

insert into magia (nombre, descripcion, tipo_magia, id_efecto) values 
('piromancia', 'magia de fuego que permite crear y controlar llamas', 'piromancia', null),
('criomancia', 'manipulación de temperaturas frías y creación de hielo', 'criomania', null),
('primus', 'magia básica y versátil con telequinesis y refuerzos', 'primus', null);
select * from magia;

insert into estilos_de_combates (nombre, descripcion) values 
('torblade', 'estilo de combate con espadas, rápido y potente'),
('bravuca', 'arte marcial de fuerza bruta y golpes continuos'),
('cielpidoh', 'estilo aéreo centrado en patadas rápidas y precisas');
select * from estilos_de_combates;

insert into razas (nombre, descripcion, habilidad_1, habilidad_2) values 
('humanos - ætherianos', 'raza versátil con adaptabilidad mágica y tecnológica', 'ímpetu arcano', 'carisma inspirador (en desarrollo)'),
('orcos - rakar''khan', 'guerreros corpulentos con conexión a la tierra y fuego', 'desafío imponente', 'comunión con la tierra (en desarrollo)'),
('animales - ferales', 'seres felinos, caninos y ursidos con instinto de caza', 'reflejos felinos', 'olfato rastreador (en desarrollo)'),
('dragones - drakonir', 'raza antigua con habilidades draconianas y transformación', 'aliento elemental', 'vuelo (en desarrollo)');
select * from razas;

-- consultas con operadores relacionales
select * from razas where nombre > 'elfo';
select * from objetos where tipo_objeto = 'arma';
select * from criaturas where length(habilidad) <= 10;
select * from ubicaciones where nombre like 'bosque%';

-- consultas con funciones de agrupamiento
select count(*) as total_ubicaciones from ubicaciones;
select avg(length(descripcion)) as promedio_longitud_descripcion from criaturas;
select max(id) as id_mas_alto from efectos;
select sum(id) as suma_ids_criaturas from criaturas;

-- consultas multitabla (join)
select r.nombre as raza, e.nombre as efecto
from razas r
left join efectos e on r.id_efecto = e.id;

select c.nombre as criatura, o.nombre as objeto
from criaturas c
left join objetos o on c.id_objeto = o.id;

select o.nombre as objeto, e.nombre as efecto
from objetos o
left join efectos e on o.id_efecto = e.id;

-- procedimiento almacenado para insertar razas con id_efecto opcional
delimiter //
create procedure insertar_raza(
    in nombrer varchar(255), 
    in habilidadr varchar(255), 
    in descripcionr text, 
    in id_objeto_r int, 
    in id_efecto_r int
)
begin
    insert into razas (nombre, habilidad_1, habilidad_2, descripcion, id_objeto, id_efecto) 
    values (nombrer, habilidadr, null, descripcionr, id_objeto_r, id_efecto_r);
end //
delimiter ;

-- funciones y cálculos matemáticos con if
select nombre, 
       if(tipo_objeto = 'arma', 'es un arma', 'no es un arma') as tipo_descripcion
from objetos;

select nombre, 
       if(habilidad = 'volar', 'puede volar', 'no puede volar') as habilidad_volar
from criaturas;

select nombre, 
       if(length(descripcion) > 20, 'descripción larga', 'descripción corta') as descripcion_tipo
from efectos;

-- update
-- desactivar el modo seguro
set sql_safe_updates = 0;

update ubicaciones
set tipo_ubicacion = 'bosque mágico'
where nombre = 'bosque encantado';

-- activar el modo seguro
set sql_safe_updates = 1;
