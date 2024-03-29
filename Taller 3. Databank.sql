CREATE DATABASE TALLER_03_DATABANK;

USE TALLER_03_DATABANK;

CREATE TABLE CLINICA(
	id INT PRIMARY KEY,
	nombre VARCHAR(50),
	direccion VARCHAR (50),
	telefono CHAR (12),
	email VARCHAR(50)
);

CREATE TABLE CONSULTORIO(
	id INT PRIMARY KEY,
	correlativo INT,
	descripcion VARCHAR(100),
	id_clinica INT
);

CREATE TABLE TIPO_PLAN(
	id INT PRIMARY KEY,
	tipo VARCHAR(16)
);

CREATE TABLE CLIENTE (
	id INT PRIMARY KEY,
	nombre VARCHAR(50),
	direccion VARCHAR(50),
	id_tipo_plan INT 
);

CREATE TABLE TELEFONO_CLIENTE (
	id INT PRIMARY KEY,
	telefono CHAR (12),
	id_cliente INT
);

CREATE TABLE CORREO_CLIENTE (
	id INT PRIMARY KEY,
	correo VARCHAR (64),
	id_cliente INT
);

CREATE TABLE CITA (
	id INT PRIMARY KEY,
	id_clinica INT,
	id_cliente INT,
	fecha DATETIME
);

CREATE TABLE EMERGENCIA (
	id INT PRIMARY KEY,
	id_clinica INT,
	id_cliente INT,
	fecha DATETIME,
	comentario VARCHAR (128)
);

CREATE TABLE MEDICO (
	id INT PRIMARY KEY,
	nombre VARCHAR(64),
	telefono CHAR(12),
	correo VARCHAR(64)
);

CREATE TABLE CONTRATO (
	id INT PRIMARY KEY,
	id_clinica INT,
	id_medico INT,
	horario varchar(32),
	fecha_contrato DATE,
	salario MONEY
);

CREATE TABLE MEDICAMENTO (
	id INT PRIMARY KEY,
	nombre VARCHAR(32),
	precio MONEY
);

CREATE TABLE CONSULTA (
	id INT PRIMARY KEY,
	fecha DATETIME,
	duracion VARCHAR(8),
	precio MONEY,
	id_consultorio INT,
	id_cliente INT
);

CREATE TABLE RECETA (
	id_consulta INT NOT NULL,
	id_medicamento INT NOT NULL
);

CREATE TABLE MEDICOXCONSULTA (
	id_consulta INT NOT NULL,
	id_medico INT NOT NULL,
	rol BIT -- 0: medico asistente, 1: medico principal
);
GO

ALTER TABLE CONSULTORIO ADD FOREIGN KEY (id_clinica) REFERENCES CLINICA(id);
ALTER TABLE CLIENTE ADD FOREIGN KEY(id_tipo_plan) REFERENCES TIPO_PLAN (id);
ALTER TABLE TELEFONO_CLIENTE ADD FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id);
ALTER TABLE CORREO_CLIENTE ADD FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id);
ALTER TABLE CITA ADD FOREIGN KEY (id_clinica) REFERENCES CLINICA (id);
ALTER TABLE CITA ADD FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id);
ALTER TABLE EMERGENCIA ADD FOREIGN KEY (id_clinica) REFERENCES CLINICA (id);
ALTER TABLE EMERGENCIA ADD FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id);
ALTER TABLE CONTRATO ADD FOREIGN KEY (id_clinica) REFERENCES CLINICA(id);
ALTER TABLE CONTRATO ADD FOREIGN KEY (id_medico) REFERENCES MEDICO(id);
ALTER TABLE CONSULTA ADD FOREIGN KEY (id_consultorio) REFERENCES CONSULTORIO (id);
ALTER TABLE CONSULTA ADD FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id);
ALTER TABLE RECETA ADD PRIMARY KEY (id_consulta, id_medicamento);
ALTER TABLE RECETA ADD FOREIGN KEY (id_consulta) REFERENCES CONSULTA (id);
ALTER TABLE RECETA ADD FOREIGN KEY (id_medicamento) REFERENCES MEDICAMENTO (id);
ALTER TABLE MEDICOXCONSULTA ADD PRIMARY KEY (id_consulta, id_medico);
ALTER TABLE MEDICOXCONSULTA ADD FOREIGN KEY (id_consulta) REFERENCES CONSULTA(id);
ALTER TABLE MEDICOXCONSULTA ADD FOREIGN KEY (id_medico) REFERENCES MEDICO(id);
GO

INSERT INTO CLINICA VALUES(1,'Curadent Clínicas Odontológicas','Ap #7008149 Tristique Street','+50377512758','egestas.blandit@hotmail.edu');
INSERT INTO CLINICA VALUES(2,'DentAid','5238 Fusce Rd.','+50377324877','facilisis.magna@outlook.ca');
INSERT INTO CLINICA VALUES(3,'Clínica Smiling','5055020 Dictum Road','+50372035854','cursus.et@aol.ca');
INSERT INTO CLINICA VALUES(4,'Avodent','578101 Justo. St.','+50379436461','ut.molestie@yahoo.ca');
INSERT INTO CLINICA VALUES(5,'DentalCare','P.O. Box 629, 5100 Nulla. Street','+50374345531','dis.parturient@outlook.com');
INSERT INTO CLINICA VALUES(6,'Kool Smiles','4033 Enim. Avenue','+50378379533','phasellus@icloud.ca');
INSERT INTO CLINICA VALUES(7,'Comfort Dental','P.O. Box 800, 5733 Leo. St.','+50370715783','ante.blandit@outlook.com');
INSERT INTO CLINICA VALUES(8,'Clínica Novodent','3439442 Eu Rd.','+50377162450','quis.turpis@google.org');
INSERT INTO CLINICA VALUES(9,'Centros Dentalys ','P.O. Box 931, 7292 Dignissim Rd.','+50376141593','etiam.bibendum@aol.org');
INSERT INTO CLINICA VALUES(10,'OdontiVal','Ap #9841480 Ipsum. Street','+50371722621','vivamus@yahoo.edu');

INSERT INTO CONSULTORIO VALUES(1,1,'Aliquam nisl. Nulla',1);
INSERT INTO CONSULTORIO VALUES(2,2,'dolor vitae dolor.',1);
INSERT INTO CONSULTORIO VALUES(3,3,'libero mauris,',1);
INSERT INTO CONSULTORIO VALUES(4,1,'elementum, dui quis',2);
INSERT INTO CONSULTORIO VALUES(5,1,'est, congue a, aliquet vel,',3);
INSERT INTO CONSULTORIO VALUES(6,2,'blandit mattis. Cras eget',3);
INSERT INTO CONSULTORIO VALUES(7,1,'in consectetuer ipsum nunc',4);
INSERT INTO CONSULTORIO VALUES(8,2,'inceptos hymenaeos. Mauris ut',4);
INSERT INTO CONSULTORIO VALUES(9,3,'mauris, rhoncus id, mollis nec, cursus',4);
INSERT INTO CONSULTORIO VALUES(10,1,'Nullam vitae diam. Proin dolor.',5);
INSERT INTO CONSULTORIO VALUES(11,2,'ac metus vitae velit',5);
INSERT INTO CONSULTORIO VALUES(12,1,'in magna. Phasellus dolor',6);
INSERT INTO CONSULTORIO VALUES(13,2,'leo, in lobortis tellus',6);
INSERT INTO CONSULTORIO VALUES(14,3,'diam. Duis',6);
INSERT INTO CONSULTORIO VALUES(15,1,'ante dictum mi, ac',7);
INSERT INTO CONSULTORIO VALUES(16,1,'ligula tortor, dictum eu, placerat',8);
INSERT INTO CONSULTORIO VALUES(17,2,'ut erat. Sed nunc est, mollis',8);
INSERT INTO CONSULTORIO VALUES(18,1,'montes, nascetur ridiculus mus. Proin vel',9);
INSERT INTO CONSULTORIO VALUES(19,1,'aptent taciti sociosqu',10);
INSERT INTO CONSULTORIO VALUES(20,2,'Sed congue, elit sed consequat',10);

INSERT INTO TIPO_PLAN VALUES(1,'Juvenil');
INSERT INTO TIPO_PLAN VALUES(2,'Adulto');
INSERT INTO TIPO_PLAN VALUES(3,'Familia');
INSERT INTO TIPO_PLAN VALUES(4,'Premium');

INSERT INTO CLIENTE VALUES(1,'Clark Hale','818-729 Nec Street',1);
INSERT INTO CLIENTE VALUES(2,'Lamar Vazquez','7860 Proin Avenue',1);
INSERT INTO CLIENTE VALUES(3,'Lucy Armstrong','456-3943 Euismod Rd.',1);
INSERT INTO CLIENTE VALUES(4,'Uma Barlow','Ap #873-4495 Proin Street',2);
INSERT INTO CLIENTE VALUES(5,'Autumn Elliott','P.O. Box 835, 5487 Blandit Rd.',3);
INSERT INTO CLIENTE VALUES(6,'Cade Harrington','Ap #982-8753 Purus. St.',2);
INSERT INTO CLIENTE VALUES(7,'Maxine Eaton','125-4377 Lectus. Ave',2);
INSERT INTO CLIENTE VALUES(8,'Gray Thompson','Ap #914-3442 Augue Street',1);
INSERT INTO CLIENTE VALUES(9,'Silas Walter','250-425 Nunc Rd.',2);
INSERT INTO CLIENTE VALUES(10,'Nehru Horn','7919 Orci, Av.',3);
INSERT INTO CLIENTE VALUES(11,'Dai Hodges','Ap #408-8063 Metus. Av.',2);
INSERT INTO CLIENTE VALUES(12,'Nero Gardner','833-6123 Mollis. Road',3);
INSERT INTO CLIENTE VALUES(13,'Keith Howe','854-220 Sociis Ave',1);
INSERT INTO CLIENTE VALUES(14,'Beverly Trevino','Ap #514-2446 Nunc Street',2);
INSERT INTO CLIENTE VALUES(15,'Ira Rios','P.O. Box 946, 4270 Ligula. St.',2);
INSERT INTO CLIENTE VALUES(16,'Dominique Callahan','871-2349 Mauris Rd.',3);
INSERT INTO CLIENTE VALUES(17,'Giacomo Leon','Ap #426-805 Phasellus Rd.',2);
INSERT INTO CLIENTE VALUES(18,'Zephania Mcgee','Ap #939-9660 Curae Avenue',2);
INSERT INTO CLIENTE VALUES(19,'Benjamin Robles','Ap #540-5731 Phasellus Rd.',4);
INSERT INTO CLIENTE VALUES(20,'Katelyn Dennis','194-3315 Sit St.',2);
INSERT INTO CLIENTE VALUES(21,'Hunter Booth','930-158 Enim. St.',3);
INSERT INTO CLIENTE VALUES(22,'Amena Wheeler','Ap #106-5201 Convallis St.',1);
INSERT INTO CLIENTE VALUES(23,'Colby Delgado','1587 Lobortis Rd.',4);
INSERT INTO CLIENTE VALUES(24,'Philip Robbins','942-9922 Quisque Av.',2);
INSERT INTO CLIENTE VALUES(25,'Leroy Valentine','Ap #842-9680 Ultrices. Ave',1);
INSERT INTO CLIENTE VALUES(26,'Alisa Mueller','P.O. Box 432, 1503 Amet Rd.',4);
INSERT INTO CLIENTE VALUES(27,'Darryl Parsons','Ap #914-4419 Et Rd.',1);
INSERT INTO CLIENTE VALUES(28,'Hadassah Jackson','P.O. Box 719, 2739 Magnis St.',4);
INSERT INTO CLIENTE VALUES(29,'Helen Randall','P.O. Box 515, 6864 Neque Rd.',1);
INSERT INTO CLIENTE VALUES(30,'Hayfa York','P.O. Box 697, 9735 Eros St.',1);

INSERT INTO TELEFONO_CLIENTE VALUES(1,'+50378981723',1);
INSERT INTO TELEFONO_CLIENTE VALUES(2,'+50372949485',2);
INSERT INTO TELEFONO_CLIENTE VALUES(3,'+50370725273',2);
INSERT INTO TELEFONO_CLIENTE VALUES(4,'+50370293630',3);
INSERT INTO TELEFONO_CLIENTE VALUES(5,'+50373949842',4);
INSERT INTO TELEFONO_CLIENTE VALUES(6,'+50375573847',5);
INSERT INTO TELEFONO_CLIENTE VALUES(7,'+50373532543',5);
INSERT INTO TELEFONO_CLIENTE VALUES(8,'+50371165881',7);
INSERT INTO TELEFONO_CLIENTE VALUES(9,'+50373383933',9);
INSERT INTO TELEFONO_CLIENTE VALUES(10,'+50373266162',10);
INSERT INTO TELEFONO_CLIENTE VALUES(11,'+50373524209',11);
INSERT INTO TELEFONO_CLIENTE VALUES(12,'+50379835425',11);
INSERT INTO TELEFONO_CLIENTE VALUES(13,'+50370339723',11);
INSERT INTO TELEFONO_CLIENTE VALUES(14,'+50371383439',13);
INSERT INTO TELEFONO_CLIENTE VALUES(15,'+50378773656',13);
INSERT INTO TELEFONO_CLIENTE VALUES(16,'+50374515230',14);
INSERT INTO TELEFONO_CLIENTE VALUES(17,'+50375858226',15);
INSERT INTO TELEFONO_CLIENTE VALUES(18,'+50375564432',17);
INSERT INTO TELEFONO_CLIENTE VALUES(19,'+50376963574',19);
INSERT INTO TELEFONO_CLIENTE VALUES(20,'+50376288512',20);
INSERT INTO TELEFONO_CLIENTE VALUES(21,'+50379969060',21);
INSERT INTO TELEFONO_CLIENTE VALUES(22,'+50378323436',21);
INSERT INTO TELEFONO_CLIENTE VALUES(23,'+50375724856',23);
INSERT INTO TELEFONO_CLIENTE VALUES(24,'+50377433316',24);
INSERT INTO TELEFONO_CLIENTE VALUES(25,'+50373366251',24);
INSERT INTO TELEFONO_CLIENTE VALUES(26,'+50373648747',25);
INSERT INTO TELEFONO_CLIENTE VALUES(27,'+50377251849',25);
INSERT INTO TELEFONO_CLIENTE VALUES(28,'+50377398382',29);
INSERT INTO TELEFONO_CLIENTE VALUES(29,'+50372187722',30);
INSERT INTO TELEFONO_CLIENTE VALUES(30,'+50371721869',30);

INSERT INTO CORREO_CLIENTE VALUES(1,'pellentesque.habitant.morbi@outlook.com',1);
INSERT INTO CORREO_CLIENTE VALUES(2,'sed.sem@yahoo.ca',1);
INSERT INTO CORREO_CLIENTE VALUES(3,'nulla.donec.non@outlook.com',1);
INSERT INTO CORREO_CLIENTE VALUES(4,'erat.eget@icloud.com',2);
INSERT INTO CORREO_CLIENTE VALUES(5,'eu@google.edu',3);
INSERT INTO CORREO_CLIENTE VALUES(6,'a@protonmail.net',7);
INSERT INTO CORREO_CLIENTE VALUES(7,'velit.aliquam@outlook.net',8);
INSERT INTO CORREO_CLIENTE VALUES(8,'curabitur.consequat@hotmail.couk',8);
INSERT INTO CORREO_CLIENTE VALUES(9,'lobortis@hotmail.couk',9);
INSERT INTO CORREO_CLIENTE VALUES(10,'magna.et@google.com',9);
INSERT INTO CORREO_CLIENTE VALUES(11,'enim.mi@outlook.couk',10);
INSERT INTO CORREO_CLIENTE VALUES(12,'lorem.luctus@yahoo.ca',11);
INSERT INTO CORREO_CLIENTE VALUES(13,'sed@aol.org',11);
INSERT INTO CORREO_CLIENTE VALUES(14,'auctor@protonmail.ca',11);
INSERT INTO CORREO_CLIENTE VALUES(15,'tempor@yahoo.net',12);
INSERT INTO CORREO_CLIENTE VALUES(16,'non.enim@outlook.ca',13);
INSERT INTO CORREO_CLIENTE VALUES(17,'libero.proin@aol.ca',14);
INSERT INTO CORREO_CLIENTE VALUES(18,'erat.vel@icloud.ca',14);
INSERT INTO CORREO_CLIENTE VALUES(19,'nam.porttitor.scelerisque@outlook.ca',14);
INSERT INTO CORREO_CLIENTE VALUES(20,'sed.orci@aol.org',15);
INSERT INTO CORREO_CLIENTE VALUES(21,'in@yahoo.com',15);
INSERT INTO CORREO_CLIENTE VALUES(22,'convallis.convallis@protonmail.com',15);
INSERT INTO CORREO_CLIENTE VALUES(23,'mattis.semper.dui@icloud.edu',16);
INSERT INTO CORREO_CLIENTE VALUES(24,'vivamus.molestie.dapibus@protonmail.org',17);
INSERT INTO CORREO_CLIENTE VALUES(25,'aliquam@google.net',17);
INSERT INTO CORREO_CLIENTE VALUES(26,'rutrum.magna@hotmail.ca',17);
INSERT INTO CORREO_CLIENTE VALUES(27,'parturient@hotmail.com',18);
INSERT INTO CORREO_CLIENTE VALUES(28,'nec.eleifend.non@outlook.net',18);
INSERT INTO CORREO_CLIENTE VALUES(29,'tortor.at@google.ca',18);
INSERT INTO CORREO_CLIENTE VALUES(30,'eget.nisi@yahoo.com',19);
INSERT INTO CORREO_CLIENTE VALUES(31,'id.nunc.interdum@hotmail.edu',22);
INSERT INTO CORREO_CLIENTE VALUES(32,'feugiat@outlook.org',22);
INSERT INTO CORREO_CLIENTE VALUES(33,'ornare.elit@aol.edu',24);
INSERT INTO CORREO_CLIENTE VALUES(34,'dignissim.lacus@outlook.org',24);
INSERT INTO CORREO_CLIENTE VALUES(35,'non.nisi.aenean@google.net',24);
INSERT INTO CORREO_CLIENTE VALUES(36,'at.fringilla@google.com',26);
INSERT INTO CORREO_CLIENTE VALUES(37,'ac.ipsum.phasellus@outlook.ca',27);
INSERT INTO CORREO_CLIENTE VALUES(38,'sem.egestas@protonmail.net',28);
INSERT INTO CORREO_CLIENTE VALUES(39,'cras.sed@aol.org',28);
INSERT INTO CORREO_CLIENTE VALUES(40,'nec.tellus.nunc@yahoo.ca',28);
INSERT INTO CORREO_CLIENTE VALUES(41,'vitae.semper@protonmail.edu',29);
INSERT INTO CORREO_CLIENTE VALUES(42,'non.sollicitudin@protonmail.couk',29);
INSERT INTO CORREO_CLIENTE VALUES(43,'felis@icloud.net',29);
INSERT INTO CORREO_CLIENTE VALUES(44,'sit@yahoo.edu',30);
INSERT INTO CORREO_CLIENTE VALUES(45,'sed.dolor.fusce@outlook.org',30);

INSERT INTO CITA VALUES(1,3,13, CONVERT(DATETIME, '1/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(2,1,13, CONVERT(DATETIME, '2/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(3,9,18, CONVERT(DATETIME, '2/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(4,8,24, CONVERT(DATETIME, '3/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(5,10,2, CONVERT(DATETIME, '3/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(6,1,17, CONVERT(DATETIME, '4/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(7,2,29, CONVERT(DATETIME, '5/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(8,5,27, CONVERT(DATETIME, '6/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(9,1,17, CONVERT(DATETIME, '6/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(10,3,30, CONVERT(DATETIME, '6/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(11,1,6, CONVERT(DATETIME, '7/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(12,6,4, CONVERT(DATETIME, '7/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(13,7,15, CONVERT(DATETIME, '8/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(14,5,13, CONVERT(DATETIME, '9/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(15,8,25, CONVERT(DATETIME, '12/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(16,10,3, CONVERT(DATETIME, '13/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(17,10,10, CONVERT(DATETIME, '13/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(18,9,11, CONVERT(DATETIME, '14/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(19,10,23, CONVERT(DATETIME, '14/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(20,2,9, CONVERT(DATETIME, '16/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(21,2,21, CONVERT(DATETIME, '16/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(22,4,21, CONVERT(DATETIME, '17/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(23,3,28, CONVERT(DATETIME, '17/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(24,4,29, CONVERT(DATETIME, '18/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(25,5,21, CONVERT(DATETIME, '18/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(26,9,25, CONVERT(DATETIME, '19/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(27,1,20, CONVERT(DATETIME, '20/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(28,8,23, CONVERT(DATETIME, '20/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(29,2,7, CONVERT(DATETIME, '20/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(30,1,8, CONVERT(DATETIME, '20/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(31,6,5, CONVERT(DATETIME, '21/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(32,2,19, CONVERT(DATETIME, '23/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(33,4,11, CONVERT(DATETIME, '23/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(34,7,19, CONVERT(DATETIME, '23/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(35,9,14, CONVERT(DATETIME, '23/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(36,3,8, CONVERT(DATETIME, '24/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(37,10,5, CONVERT(DATETIME, '24/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(38,4,24, CONVERT(DATETIME, '25/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(39,3,25, CONVERT(DATETIME, '26/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(40,3,10, CONVERT(DATETIME, '26/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(41,3,7, CONVERT(DATETIME, '26/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(42,4,26, CONVERT(DATETIME, '28/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(43,9,9, CONVERT(DATETIME, '28/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(44,10,9, CONVERT(DATETIME, '28/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(45,9,3, CONVERT(DATETIME, '28/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(46,4,30, CONVERT(DATETIME, '29/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(47,3,27, CONVERT(DATETIME, '29/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(48,7,28, CONVERT(DATETIME, '29/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(49,10,19, CONVERT(DATETIME, '29/5/2022 9:00:00:000', 103));
INSERT INTO CITA VALUES(50,8,17, CONVERT(DATETIME, '29/5/2022 9:00:00:000', 103));

INSERT INTO EMERGENCIA VALUES(1,5,12, CONVERT(DATETIME, '5/5/2022 9:00:00:000', 103),'ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor.');
INSERT INTO EMERGENCIA VALUES(2,4,17, CONVERT(DATETIME, '7/5/2022 9:00:00:000', 103),'eu eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec');
INSERT INTO EMERGENCIA VALUES(3,5,10, CONVERT(DATETIME, '13/5/2022 9:00:00:000', 103),'lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper, velit in');
INSERT INTO EMERGENCIA VALUES(4,5,11, CONVERT(DATETIME, '17/5/2022 9:00:00:000', 103),'sit amet nulla. Donec non justo. Proin non massa non');
INSERT INTO EMERGENCIA VALUES(5,9,7, CONVERT(DATETIME, '20/5/2022 9:00:00:000', 103),'egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est,');
INSERT INTO EMERGENCIA VALUES(6,10,24, CONVERT(DATETIME, '21/5/2022 9:00:00:000', 103),'Donec vitae erat vel pede blandit congue. In scelerisque scelerisque');
INSERT INTO EMERGENCIA VALUES(7,8,3, CONVERT(DATETIME, '26/5/2022 9:00:00:000', 103),'dictum placerat, augue. Sed molestie. Sed id risus quis diam');
INSERT INTO EMERGENCIA VALUES(8,10,4, CONVERT(DATETIME, '26/5/2022 9:00:00:000', 103),'ut quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula.');
INSERT INTO EMERGENCIA VALUES(9,4,24, CONVERT(DATETIME, '28/5/2022 9:00:00:000', 103),'Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi');
INSERT INTO EMERGENCIA VALUES(10,9,6, CONVERT(DATETIME, '28/5/2022 9:00:00:000', 103),'enim, sit amet ornare lectus justo eu arcu. Morbi sit');

INSERT INTO MEDICO VALUES(1,'Rudyard Miles','+50376438433','et.netus@yahoo.org');
INSERT INTO MEDICO VALUES(2,'Ira Benton','+50375115779','ut.tincidunt.orci@hotmail.couk');
INSERT INTO MEDICO VALUES(3,'Mark Abbott','+50373130313','ut.cursus@hotmail.com');
INSERT INTO MEDICO VALUES(4,'Colin Henson','+50378787151','sit.amet.dapibus@yahoo.net');
INSERT INTO MEDICO VALUES(5,'Arthur Jefferson','+50375835325','blandit.congue.in@aol.net');
INSERT INTO MEDICO VALUES(6,'Trevor Contreras','+50326761358','quisque@hotmail.ca');
INSERT INTO MEDICO VALUES(7,'Silas Shepard','+50375894687','nulla.in@outlook.org');
INSERT INTO MEDICO VALUES(8,'Isaac Barry','+50322918544','integer.eu.lacus@aol.org');
INSERT INTO MEDICO VALUES(9,'Jeanette Frederick','+50328526855','aliquam.ultrices@protonmail.couk');
INSERT INTO MEDICO VALUES(10,'Beatrice Ramirez','+50327066010','elit.pede@hotmail.net');
INSERT INTO MEDICO VALUES(11,'Ingrid Mcclain','+50372124388','felis.eget@hotmail.edu');
INSERT INTO MEDICO VALUES(12,'Felix Watson','+50373374372','natoque.penatibus@yahoo.org');
INSERT INTO MEDICO VALUES(13,'Eugenia Dotson','+50378632179','ullamcorper.viverra.maecenas@hotmail.com');
INSERT INTO MEDICO VALUES(14,'Haviva Mcclure','+50373021649','in.mi@protonmail.net');
INSERT INTO MEDICO VALUES(15,'Eric Vasquez','+50322433810','vulputate.posuere.vulputate@icloud.couk');

INSERT INTO CONTRATO VALUES(1,1,4,'8:00:00 - 15:30:00', CONVERT (DATE, '27/4/2019', 103),1800);
INSERT INTO CONTRATO VALUES(2,7,3,'8:00:00 - 15:30:00', CONVERT (DATE, '17/4/2021', 103),1602);
INSERT INTO CONTRATO VALUES(3,5,14,'8:00:00 - 15:30:00', CONVERT (DATE, '8/1/2018', 103),1057);
INSERT INTO CONTRATO VALUES(4,1,11,'8:00:00 - 12:00:00', CONVERT (DATE, '24/7/2019', 103),1445);
INSERT INTO CONTRATO VALUES(5,10,13,'8:00:00 - 12:00:00', CONVERT (DATE, '4/9/2021', 103),1495);
INSERT INTO CONTRATO VALUES(6,10,1,'1:00:00 - 16:00:00', CONVERT (DATE, '24/6/2018', 103),1077);
INSERT INTO CONTRATO VALUES(7,9,9,'8:00:00 - 15:30:00', CONVERT (DATE, '28/11/2016', 103),1605);
INSERT INTO CONTRATO VALUES(8,10,11,'8:00:00 - 15:30:00', CONVERT (DATE, '10/3/2017', 103),1155);
INSERT INTO CONTRATO VALUES(9,8,10,'8:00:00 - 15:30:00', CONVERT (DATE, '24/2/2020', 103),1932);
INSERT INTO CONTRATO VALUES(10,5,6,'8:00:00 - 12:00:00', CONVERT (DATE, '27/3/2019', 103),1298);
INSERT INTO CONTRATO VALUES(11,9,3,'8:00:00 - 12:00:00', CONVERT (DATE, '19/12/2019', 103),1549);
INSERT INTO CONTRATO VALUES(12,9,7,'1:00:00 - 16:00:00', CONVERT (DATE, '8/10/2019', 103),1142);
INSERT INTO CONTRATO VALUES(13,6,7,'8:00:00 - 15:30:00', CONVERT (DATE, '13/7/2017', 103),1435);
INSERT INTO CONTRATO VALUES(14,1,10,'8:00:00 - 15:30:00', CONVERT (DATE, '1/10/2022', 103),1752);

INSERT INTO MEDICAMENTO VALUES(1,'Amoxicilina',3.80);
INSERT INTO MEDICAMENTO VALUES(2,'Sulbactam  ',22.77);
INSERT INTO MEDICAMENTO VALUES(3,'Ampicilina',17.84);
INSERT INTO MEDICAMENTO VALUES(4,'Penicilina',12.88);
INSERT INTO MEDICAMENTO VALUES(5,'Piperacilina',20.19);
INSERT INTO MEDICAMENTO VALUES(6,'Ticarcilina',11.69);
INSERT INTO MEDICAMENTO VALUES(7,'Eritromicina',4.10);
INSERT INTO MEDICAMENTO VALUES(8,'Tetraciclina',20.90);
INSERT INTO MEDICAMENTO VALUES(9,'Clindamicina',9.66);
INSERT INTO MEDICAMENTO VALUES(10,'Metronidazol',17.56);
INSERT INTO MEDICAMENTO VALUES(11,'Gentamicina',35.97);
INSERT INTO MEDICAMENTO VALUES(12,'Ácido clavulánico',10.89);
INSERT INTO MEDICAMENTO VALUES(13,'Tazobactam',26.43);
INSERT INTO MEDICAMENTO VALUES(14,'Ácido clavulánico',3.35);

INSERT INTO CONSULTA VALUES(1, CONVERT(DATETIME, '01/05/2022 9:00:00:000', 103),'2:00:00',19.99,13,13);
INSERT INTO CONSULTA VALUES(2, CONVERT(DATETIME, '02/05/2022 9:00:00:000', 103),'2:00:00',9.99,3,13);
INSERT INTO CONSULTA VALUES(3, CONVERT(DATETIME, '02/05/2022 9:00:00:000', 103),'2:00:00',39.99,3,18);
INSERT INTO CONSULTA VALUES(4, CONVERT(DATETIME, '03/05/2022 9:00:00:000', 103),'2:00:00',300.00,11,24);
INSERT INTO CONSULTA VALUES(5, CONVERT(DATETIME, '03/05/2022 9:00:00:000', 103),'2:00:00',39.99,4,2);
INSERT INTO CONSULTA VALUES(6, CONVERT(DATETIME, '04/05/2022 9:00:00:000', 103),'2:00:00',19.99,11,17);
INSERT INTO CONSULTA VALUES(7, CONVERT(DATETIME, '05/05/2022 9:00:00:000', 103),'2:00:00',9.99,4,29);
INSERT INTO CONSULTA VALUES(8, CONVERT(DATETIME, '05/05/2022 9:00:00:000', 103),'2:00:00',39.99,11,12);
INSERT INTO CONSULTA VALUES(9, CONVERT(DATETIME, '06/05/2022 9:00:00:000', 103),'2:00:00',39.99,10,27);
INSERT INTO CONSULTA VALUES(10, CONVERT(DATETIME, '06/05/2022 9:00:00:000', 103),'2:00:00',19.99,4,17);
INSERT INTO CONSULTA VALUES(11, CONVERT(DATETIME, '06/05/2022 9:00:00:000', 103),'2:00:00',19.99,16,30);
INSERT INTO CONSULTA VALUES(12, CONVERT(DATETIME, '07/05/2022 9:00:00:000', 103),'2:00:00',9.99,19,6);
INSERT INTO CONSULTA VALUES(13, CONVERT(DATETIME, '07/05/2022 9:00:00:000', 103),'2:00:00',19.99,12,4);
INSERT INTO CONSULTA VALUES(14, CONVERT(DATETIME, '07/05/2022 9:00:00:000', 103),'2:00:00',300.00,5,17);
INSERT INTO CONSULTA VALUES(15, CONVERT(DATETIME, '08/05/2022 9:00:00:000', 103),'2:00:00',300.00,14,15);
INSERT INTO CONSULTA VALUES(16, CONVERT(DATETIME, '09/05/2022 9:00:00:000', 103),'2:00:00',19.99,17,13);
INSERT INTO CONSULTA VALUES(17, CONVERT(DATETIME, '12/05/2022 9:00:00:000', 103),'2:00:00',9.99,6,25);
INSERT INTO CONSULTA VALUES(18, CONVERT(DATETIME, '13/05/2022 9:00:00:000', 103),'2:00:00',39.99,16,3);
INSERT INTO CONSULTA VALUES(19, CONVERT(DATETIME, '13/05/2022 9:00:00:000', 103),'2:00:00',300.00,20,10);
INSERT INTO CONSULTA VALUES(20, CONVERT(DATETIME, '13/05/2022 9:00:00:000', 103),'2:00:00',39.99,11,10);
INSERT INTO CONSULTA VALUES(21, CONVERT(DATETIME, '14/05/2022 9:00:00:000', 103),'2:00:00',19.99,16,11);
INSERT INTO CONSULTA VALUES(22, CONVERT(DATETIME, '14/05/2022 9:00:00:000', 103),'2:00:00',9.99,4,23);
INSERT INTO CONSULTA VALUES(23, CONVERT(DATETIME, '16/05/2022 9:00:00:000', 103),'2:00:00',39.99,8,9);
INSERT INTO CONSULTA VALUES(24, CONVERT(DATETIME, '16/05/2022 9:00:00:000', 103),'2:00:00',39.99,17,21);
INSERT INTO CONSULTA VALUES(25, CONVERT(DATETIME, '17/05/2022 9:00:00:000', 103),'2:00:00',19.99,17,21);
INSERT INTO CONSULTA VALUES(26, CONVERT(DATETIME, '17/05/2022 9:00:00:000', 103),'2:00:00',19.99,19,28);
INSERT INTO CONSULTA VALUES(27, CONVERT(DATETIME, '17/05/2022 9:00:00:000', 103),'2:00:00',9.99,18,11);
INSERT INTO CONSULTA VALUES(28, CONVERT(DATETIME, '18/05/2022 9:00:00:000', 103),'2:00:00',19.99,14,29);
INSERT INTO CONSULTA VALUES(29, CONVERT(DATETIME, '18/05/2022 9:00:00:000', 103),'2:00:00',300.00,6,21);
INSERT INTO CONSULTA VALUES(30, CONVERT(DATETIME, '19/05/2022 9:00:00:000', 103),'2:00:00',300.00,2,25);
INSERT INTO CONSULTA VALUES(31, CONVERT(DATETIME, '20/05/2022 9:00:00:000', 103),'2:00:00',19.99,13,20);
INSERT INTO CONSULTA VALUES(32, CONVERT(DATETIME, '20/05/2022 9:00:00:000', 103),'2:00:00',9.99,3,23);
INSERT INTO CONSULTA VALUES(33, CONVERT(DATETIME, '20/05/2022 9:00:00:000', 103),'2:00:00',39.99,10,7);
INSERT INTO CONSULTA VALUES(34, CONVERT(DATETIME, '20/05/2022 9:00:00:000', 103),'2:00:00',300.00,19,8);
INSERT INTO CONSULTA VALUES(35, CONVERT(DATETIME, '20/05/2022 9:00:00:000', 103),'2:00:00',39.99,18,7);
INSERT INTO CONSULTA VALUES(36, CONVERT(DATETIME, '21/05/2022 9:00:00:000', 103),'2:00:00',19.99,3,5);
INSERT INTO CONSULTA VALUES(37, CONVERT(DATETIME, '21/05/2022 9:00:00:000', 103),'2:00:00',9.99,18,24);
INSERT INTO CONSULTA VALUES(38, CONVERT(DATETIME, '23/05/2022 9:00:00:000', 103),'2:00:00',39.99,1,19);
INSERT INTO CONSULTA VALUES(39, CONVERT(DATETIME, '23/05/2022 9:00:00:000', 103),'2:00:00',39.99,16,11);
INSERT INTO CONSULTA VALUES(40, CONVERT(DATETIME, '23/05/2022 9:00:00:000', 103),'2:00:00',19.99,6,19);
INSERT INTO CONSULTA VALUES(41, CONVERT(DATETIME, '23/05/2022 9:00:00:000', 103),'2:00:00',19.99,10,14);
INSERT INTO CONSULTA VALUES(42, CONVERT(DATETIME, '24/05/2022 9:00:00:000', 103),'2:00:00',9.99,6,8);
INSERT INTO CONSULTA VALUES(43, CONVERT(DATETIME, '24/05/2022 9:00:00:000', 103),'2:00:00',19.99,16,5);
INSERT INTO CONSULTA VALUES(44, CONVERT(DATETIME, '25/05/2022 9:00:00:000', 103),'2:00:00',300.00,19,24);
INSERT INTO CONSULTA VALUES(45, CONVERT(DATETIME, '26/05/2022 9:00:00:000', 103),'2:00:00',300.00,3,25);
INSERT INTO CONSULTA VALUES(46, CONVERT(DATETIME, '26/05/2022 9:00:00:000', 103),'2:00:00',19.99,5,10);
INSERT INTO CONSULTA VALUES(47, CONVERT(DATETIME, '26/05/2022 9:00:00:000', 103),'2:00:00',9.99,1,7);
INSERT INTO CONSULTA VALUES(48, CONVERT(DATETIME, '26/05/2022 9:00:00:000', 103),'2:00:00',39.99,14,3);
INSERT INTO CONSULTA VALUES(49, CONVERT(DATETIME, '26/05/2022 9:00:00:000', 103),'2:00:00',300.00,20,4);
INSERT INTO CONSULTA VALUES(50, CONVERT(DATETIME, '28/05/2022 9:00:00:000', 103),'2:00:00',39.99,19,26);
INSERT INTO CONSULTA VALUES(51, CONVERT(DATETIME, '28/05/2022 9:00:00:000', 103),'2:00:00',19.99,10,9);
INSERT INTO CONSULTA VALUES(52, CONVERT(DATETIME, '28/05/2022 9:00:00:000', 103),'2:00:00',9.99,13,9);
INSERT INTO CONSULTA VALUES(53, CONVERT(DATETIME, '28/05/2022 9:00:00:000', 103),'2:00:00',39.99,9,3);
INSERT INTO CONSULTA VALUES(54, CONVERT(DATETIME, '28/05/2022 9:00:00:000', 103),'2:00:00',39.99,8,24);
INSERT INTO CONSULTA VALUES(55, CONVERT(DATETIME, '28/05/2022 9:00:00:000', 103),'2:00:00',19.99,20,6);
INSERT INTO CONSULTA VALUES(56, CONVERT(DATETIME, '29/05/2022 9:00:00:000', 103),'2:00:00',19.99,1,30);
INSERT INTO CONSULTA VALUES(57, CONVERT(DATETIME, '29/05/2022 9:00:00:000', 103),'2:00:00',9.99,7,27);
INSERT INTO CONSULTA VALUES(58, CONVERT(DATETIME, '29/05/2022 9:00:00:000', 103),'2:00:00',19.99,5,28);
INSERT INTO CONSULTA VALUES(59, CONVERT(DATETIME, '29/05/2022 9:00:00:000', 103),'2:00:00',300.00,9,19);
INSERT INTO CONSULTA VALUES(60, CONVERT(DATETIME, '29/05/2022 9:00:00:000', 103),'2:00:00',300.00,3,17);

INSERT INTO RECETA VALUES(1,1);
INSERT INTO RECETA VALUES(1,9);
INSERT INTO RECETA VALUES(1,13);
INSERT INTO RECETA VALUES(1,12);
INSERT INTO RECETA VALUES(2,11);
INSERT INTO RECETA VALUES(2,4);
INSERT INTO RECETA VALUES(2,5);
INSERT INTO RECETA VALUES(3,1);
INSERT INTO RECETA VALUES(3,4);
INSERT INTO RECETA VALUES(4,1);
INSERT INTO RECETA VALUES(4,3);
INSERT INTO RECETA VALUES(4,9);
INSERT INTO RECETA VALUES(4,12);
INSERT INTO RECETA VALUES(5,8);
INSERT INTO RECETA VALUES(5,4);
INSERT INTO RECETA VALUES(6,11);
INSERT INTO RECETA VALUES(6,9);
INSERT INTO RECETA VALUES(6,10);
INSERT INTO RECETA VALUES(6,8);
INSERT INTO RECETA VALUES(7,12);
INSERT INTO RECETA VALUES(7,13);
INSERT INTO RECETA VALUES(8,10);
INSERT INTO RECETA VALUES(9,11);
INSERT INTO RECETA VALUES(9,9);
INSERT INTO RECETA VALUES(10,3);
INSERT INTO RECETA VALUES(11,9);
INSERT INTO RECETA VALUES(11,1);
INSERT INTO RECETA VALUES(11,2);
INSERT INTO RECETA VALUES(11,3);
INSERT INTO RECETA VALUES(12,2);
INSERT INTO RECETA VALUES(12,13);
INSERT INTO RECETA VALUES(13,3);
INSERT INTO RECETA VALUES(13,13);
INSERT INTO RECETA VALUES(13,8);
INSERT INTO RECETA VALUES(14,3);
INSERT INTO RECETA VALUES(14,13);
INSERT INTO RECETA VALUES(15,11);
INSERT INTO RECETA VALUES(15,13);
INSERT INTO RECETA VALUES(15,8);
INSERT INTO RECETA VALUES(16,10);
INSERT INTO RECETA VALUES(17,9);
INSERT INTO RECETA VALUES(17,3);
INSERT INTO RECETA VALUES(17,8);
INSERT INTO RECETA VALUES(18,8);
INSERT INTO RECETA VALUES(19,2);
INSERT INTO RECETA VALUES(20,5);
INSERT INTO RECETA VALUES(20,9);
INSERT INTO RECETA VALUES(20,14);
INSERT INTO RECETA VALUES(22,3);
INSERT INTO RECETA VALUES(22,14);
INSERT INTO RECETA VALUES(22,7);
INSERT INTO RECETA VALUES(23,3);
INSERT INTO RECETA VALUES(23,8);
INSERT INTO RECETA VALUES(23,2);
INSERT INTO RECETA VALUES(24,14);
INSERT INTO RECETA VALUES(24,12);
INSERT INTO RECETA VALUES(24,13);
INSERT INTO RECETA VALUES(25,14);
INSERT INTO RECETA VALUES(25,7);
INSERT INTO RECETA VALUES(25,1);
INSERT INTO RECETA VALUES(25,5);
INSERT INTO RECETA VALUES(25,11);
INSERT INTO RECETA VALUES(26,8);
INSERT INTO RECETA VALUES(27,3);
INSERT INTO RECETA VALUES(27,11);
INSERT INTO RECETA VALUES(27,13);
INSERT INTO RECETA VALUES(29,8);
INSERT INTO RECETA VALUES(30,2);
INSERT INTO RECETA VALUES(30,3);
INSERT INTO RECETA VALUES(31,12);
INSERT INTO RECETA VALUES(31,3);
INSERT INTO RECETA VALUES(31,4);
INSERT INTO RECETA VALUES(31,14);
INSERT INTO RECETA VALUES(32,9);
INSERT INTO RECETA VALUES(32,12);
INSERT INTO RECETA VALUES(32,8);
INSERT INTO RECETA VALUES(32,2);
INSERT INTO RECETA VALUES(32,1);
INSERT INTO RECETA VALUES(33,12);
INSERT INTO RECETA VALUES(33,9);
INSERT INTO RECETA VALUES(33,10);
INSERT INTO RECETA VALUES(33,11);
INSERT INTO RECETA VALUES(34,11);
INSERT INTO RECETA VALUES(34,4);
INSERT INTO RECETA VALUES(34,14);
INSERT INTO RECETA VALUES(34,5);
INSERT INTO RECETA VALUES(36,13);
INSERT INTO RECETA VALUES(36,9);
INSERT INTO RECETA VALUES(36,11);
INSERT INTO RECETA VALUES(37,13);
INSERT INTO RECETA VALUES(37,2);
INSERT INTO RECETA VALUES(37,8);
INSERT INTO RECETA VALUES(37,5);
INSERT INTO RECETA VALUES(37,14);
INSERT INTO RECETA VALUES(38,11);
INSERT INTO RECETA VALUES(38,12);
INSERT INTO RECETA VALUES(38,13);
INSERT INTO RECETA VALUES(39,12);
INSERT INTO RECETA VALUES(39,9);
INSERT INTO RECETA VALUES(40,7);
INSERT INTO RECETA VALUES(40,1);
INSERT INTO RECETA VALUES(40,4);
INSERT INTO RECETA VALUES(41,11);
INSERT INTO RECETA VALUES(41,3);
INSERT INTO RECETA VALUES(41,10);
INSERT INTO RECETA VALUES(42,13);
INSERT INTO RECETA VALUES(43,6);
INSERT INTO RECETA VALUES(43,4);
INSERT INTO RECETA VALUES(43,14);
INSERT INTO RECETA VALUES(43,1);
INSERT INTO RECETA VALUES(44,6);
INSERT INTO RECETA VALUES(44,13);
INSERT INTO RECETA VALUES(44,1);
INSERT INTO RECETA VALUES(45,5);
INSERT INTO RECETA VALUES(46,5);
INSERT INTO RECETA VALUES(46,12);
INSERT INTO RECETA VALUES(46,6);
INSERT INTO RECETA VALUES(46,2);
INSERT INTO RECETA VALUES(47,2);
INSERT INTO RECETA VALUES(47,3);
INSERT INTO RECETA VALUES(47,10);
INSERT INTO RECETA VALUES(48,5);
INSERT INTO RECETA VALUES(48,7);
INSERT INTO RECETA VALUES(49,5);
INSERT INTO RECETA VALUES(49,4);
INSERT INTO RECETA VALUES(50,4);
INSERT INTO RECETA VALUES(50,7);
INSERT INTO RECETA VALUES(51,11);
INSERT INTO RECETA VALUES(51,4);
INSERT INTO RECETA VALUES(51,3);
INSERT INTO RECETA VALUES(51,12);
INSERT INTO RECETA VALUES(52,6);
INSERT INTO RECETA VALUES(52,4);
INSERT INTO RECETA VALUES(53,13);
INSERT INTO RECETA VALUES(53,10);
INSERT INTO RECETA VALUES(54,6);
INSERT INTO RECETA VALUES(54,12);
INSERT INTO RECETA VALUES(54,13);
INSERT INTO RECETA VALUES(54,11);
INSERT INTO RECETA VALUES(54,14);
INSERT INTO RECETA VALUES(56,12);
INSERT INTO RECETA VALUES(57,5);
INSERT INTO RECETA VALUES(58,7);
INSERT INTO RECETA VALUES(58,3);
INSERT INTO RECETA VALUES(59,4);
INSERT INTO RECETA VALUES(59,5);
INSERT INTO RECETA VALUES(59,10);
INSERT INTO RECETA VALUES(60,11);
INSERT INTO RECETA VALUES(60,8);
INSERT INTO RECETA VALUES(60,3);

INSERT INTO MEDICOXCONSULTA VALUES(1,9,1);
INSERT INTO MEDICOXCONSULTA VALUES(2,6,1);
INSERT INTO MEDICOXCONSULTA VALUES(3,6,1);
INSERT INTO MEDICOXCONSULTA VALUES(4,12,1);
INSERT INTO MEDICOXCONSULTA VALUES(4,7,0);
INSERT INTO MEDICOXCONSULTA VALUES(5,11,1);
INSERT INTO MEDICOXCONSULTA VALUES(6,2,1);
INSERT INTO MEDICOXCONSULTA VALUES(7,8,1);
INSERT INTO MEDICOXCONSULTA VALUES(8,14,1);
INSERT INTO MEDICOXCONSULTA VALUES(9,12,1);
INSERT INTO MEDICOXCONSULTA VALUES(10,7,1);
INSERT INTO MEDICOXCONSULTA VALUES(11,1,1);
INSERT INTO MEDICOXCONSULTA VALUES(12,6,1);
INSERT INTO MEDICOXCONSULTA VALUES(13,5,1);
INSERT INTO MEDICOXCONSULTA VALUES(14,3,1);
INSERT INTO MEDICOXCONSULTA VALUES(15,1,1);
INSERT INTO MEDICOXCONSULTA VALUES(15,6,0);
INSERT INTO MEDICOXCONSULTA VALUES(16,15,1);
INSERT INTO MEDICOXCONSULTA VALUES(17,3,1);
INSERT INTO MEDICOXCONSULTA VALUES(18,1,1);
INSERT INTO MEDICOXCONSULTA VALUES(18,12,0);
INSERT INTO MEDICOXCONSULTA VALUES(19,12,1);
INSERT INTO MEDICOXCONSULTA VALUES(20,3,1);
INSERT INTO MEDICOXCONSULTA VALUES(21,12,1);
INSERT INTO MEDICOXCONSULTA VALUES(22,7,1);
INSERT INTO MEDICOXCONSULTA VALUES(23,1,1);
INSERT INTO MEDICOXCONSULTA VALUES(24,8,1);
INSERT INTO MEDICOXCONSULTA VALUES(25,12,1);
INSERT INTO MEDICOXCONSULTA VALUES(26,13,1);
INSERT INTO MEDICOXCONSULTA VALUES(27,6,1);
INSERT INTO MEDICOXCONSULTA VALUES(28,14,1);
INSERT INTO MEDICOXCONSULTA VALUES(28,11,0);
INSERT INTO MEDICOXCONSULTA VALUES(29,2,1);
INSERT INTO MEDICOXCONSULTA VALUES(30,7,1);
INSERT INTO MEDICOXCONSULTA VALUES(31,13,1);
INSERT INTO MEDICOXCONSULTA VALUES(32,13,1);
INSERT INTO MEDICOXCONSULTA VALUES(33,2,1);
INSERT INTO MEDICOXCONSULTA VALUES(34,12,1);
INSERT INTO MEDICOXCONSULTA VALUES(34,8,0);
INSERT INTO MEDICOXCONSULTA VALUES(35,6,1);
INSERT INTO MEDICOXCONSULTA VALUES(36,13,1);
INSERT INTO MEDICOXCONSULTA VALUES(36,8,0);
INSERT INTO MEDICOXCONSULTA VALUES(37,9,1);
INSERT INTO MEDICOXCONSULTA VALUES(38,11,1);
INSERT INTO MEDICOXCONSULTA VALUES(39,12,1);
INSERT INTO MEDICOXCONSULTA VALUES(40,12,1);
INSERT INTO MEDICOXCONSULTA VALUES(41,11,1);
INSERT INTO MEDICOXCONSULTA VALUES(42,10,1);
INSERT INTO MEDICOXCONSULTA VALUES(42,13,0);
INSERT INTO MEDICOXCONSULTA VALUES(43,10,1);
INSERT INTO MEDICOXCONSULTA VALUES(44,2,1);
INSERT INTO MEDICOXCONSULTA VALUES(44,6,0);
INSERT INTO MEDICOXCONSULTA VALUES(45,1,1);
INSERT INTO MEDICOXCONSULTA VALUES(46,4,1);
INSERT INTO MEDICOXCONSULTA VALUES(46,6,0);
INSERT INTO MEDICOXCONSULTA VALUES(47,3,1);
INSERT INTO MEDICOXCONSULTA VALUES(47,14,0);
INSERT INTO MEDICOXCONSULTA VALUES(48,11,1);
INSERT INTO MEDICOXCONSULTA VALUES(48,4,0);
INSERT INTO MEDICOXCONSULTA VALUES(49,3,0);
INSERT INTO MEDICOXCONSULTA VALUES(49,13,1);
INSERT INTO MEDICOXCONSULTA VALUES(50,6,1);
INSERT INTO MEDICOXCONSULTA VALUES(51,8,1);
INSERT INTO MEDICOXCONSULTA VALUES(52,6,1);
INSERT INTO MEDICOXCONSULTA VALUES(53,6,1);
INSERT INTO MEDICOXCONSULTA VALUES(53,9,0);
INSERT INTO MEDICOXCONSULTA VALUES(54,14,1);
INSERT INTO MEDICOXCONSULTA VALUES(55,13,1);
INSERT INTO MEDICOXCONSULTA VALUES(55,3,0);
INSERT INTO MEDICOXCONSULTA VALUES(56,3,1);
INSERT INTO MEDICOXCONSULTA VALUES(57,8,1);
INSERT INTO MEDICOXCONSULTA VALUES(58,12,1);
INSERT INTO MEDICOXCONSULTA VALUES(59,9,1);
INSERT INTO MEDICOXCONSULTA VALUES(60,7,1);
INSERT INTO MEDICOXCONSULTA VALUES(60,13,0);


