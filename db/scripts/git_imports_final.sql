                
insert into fdps(name,active,location_id,woreda,zone,region,created_at,updated_at) values ('Gashamo',true,11824,'Gashamo','Jarar','Somali','2017-01-20','2017-01-20');
insert into fdps(name,active,location_id,woreda,zone,region,created_at,updated_at) values ('Gebisa',true,406,'Mesela','W.Hararghe','Oromia','2017-01-20','2017-01-20');
insert into fdps(name,active,location_id,woreda,zone,region,created_at,updated_at) values ('Mender 104',true,634,'','Pawi','Beneshangul Gumuz','2017-01-20','2017-01-20');
insert into fdps(name,active,location_id,woreda,zone,region,created_at,updated_at) values ('Mender 127',true,634,'','Pawi','Beneshangul Gumuz','2017-01-20','2017-01-20');


select (setval('transporters_id_seq',(select max(id) from transporters)));
insert into transporters(name,code,created_at,updated_at) values ('Hailemariam Mazengia','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Nur Hussien','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Assefa Tamer Dry Freight Private Transport','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Bekelecha Transport SH.Co.','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Biftu Transport','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Getas TransPort','New','2017-01-20','2017-01-20');

COPY (select * from git_imports where project_code is null)
TO 'D:/CATS/gins_without_project_code.csv' DELIMITER ',' CSV HEADER;

COPY (select * from git_imports where gin is null) TO 'D:/CATS/gins_without_gin_no.csv' DELIMITER ',' CSV HEADER;

COPY (select * from git_imports where fdp is null and woreda is null and zone is null)
TO 'D:/CATS/gins_without_location.csv' DELIMITER ',' CSV HEADER;

delete from git_imports where id > 35247;
delete from git_imports where fdp is null and woreda is null and zone is null;
delete from git_imports where gin is null;
delete from git_imports where project_code is null;



update git_imports set commodity_type = 'Oil' where commodity_type in ('oil','OIL','Oil');
update git_imports set commodity_type = 'Vegitable Oil' where commodity_type in ('oil','v-Oil','V-OIL','v.Oil','V-oil','V.oil','oil','v-oil','vegetable Oil','Vegetable Oil','OIL','V.Oil','V-Oil','Oil');
update git_imports set commodity_type = 'Pulse' where commodity_type in ('pulse','PULSE','k/pulse');
update git_imports set commodity_type = 'Red Haricot Beans' where commodity_type in ('Red beans','red beans','Red Beans','red Harricot Beans','Red harikot bean','Red Haricot Bean');
update git_imports set commodity_type = 'White Haricot Beans' where commodity_type in ('White beans','white beans');
update git_imports set commodity_type = 'Yellow Split Peas' where commodity_type in ('yellow Split Piece','yellow split peans','Yellow Split Piece','Yellow split piece','Yellow Split Peas','S/Peas','Yellow split Beans');
update git_imports set commodity_type = 'Maize ' where commodity_type in ('MAIZE','maize','Maize');
update git_imports set commodity_type = 'FAMIX' where commodity_type in ('Famxis','Famix');
update git_imports set commodity_type = 'Wheat' where commodity_type in ('WHEAT','wheat');
update git_imports set commodity_type = 'Peas' where commodity_type in ('Chicepea');
update git_imports set commodity_type = 'Beans' where commodity_type in ('beans');
update git_imports set commodity_type = 'CSB' where commodity_type in ('csb');
update git_imports set commodity_type = 'CSB+' where commodity_type in ('csb+');
update git_imports set commodity_type = 'Cream Beans' where commodity_type in ('cream beans');
update git_imports set commodity_type = 'Cream Pulse' where commodity_type= 'Cream pulse';
update git_imports set commodity_type = 'Peas' where commodity_type in ('peas');
update git_imports set commodity_type = 'Sorghum' where commodity_type in ('Sorgum');
update git_imports set commodity_type = 'Soya Beans' where commodity_type in ('soy beans','soya bean');

update git_imports set commodity_class = 'Creal' where commodity_class in ('Creal','Cerial','cereal','Grain','Cereal');
update git_imports set commodity_class = 'Blended Food' where commodity_class in ('blended Food','Blended food','csb','CSB','Csb');
update git_imports set commodity_class = 'Pulse' where commodity_class in ('pulse');
update git_imports set commodity_class = 'Oil' where commodity_class in ('oil','V.Oil','V.oil','v.oil');


select * from (select count(*), commodity_class,commodity_type, name from git_imports left outer join commodity_categories 
on git_imports.commodity_class = commodity_categories.name group by commodity_class,commodity_type, name) as c where c.commodity_class is null;

update git_imports set commodity_class = 'Oil' where commodity_class is null and commodity_type =  ('Vegitable Oil');
update git_imports set commodity_class = 'Blended Food' where commodity_class is null and commodity_type =  ('CSB');
update git_imports set commodity_class = 'Pulse' where commodity_class is null and commodity_type in  ('Pulse','Red Haricot Beans','Yellow Split Peas');
update git_imports set commodity_class = 'Creal' where commodity_class is null and commodity_type in ('Grain','Wheat');

update git_imports set transporter = 'A.99 Dry Cargo PLC' where transporter = 'a.99 Dry Cargo PLC';
update git_imports set transporter = 'Asmamaw Layke Pvt. Freight Transport' where transporter = 'Asmamaw Layke Local';
update git_imports set transporter = 'Asmamaw Meles Local Inland FPT' where transporter = 'Asmamaw Melese Local';
update git_imports set transporter = 'Awel Ansha PFT' where transporter = 'Awel Ansha Local';
update git_imports set transporter = 'Bekele Wolde Local Inland  F.P. Transport' where transporter like '%Bekele%';
update git_imports set transporter = 'Birhan Cross Border Level 2-A FTOA' where transporter in ('Birhan Cross Border', 'Birhan Cross Border Level-2AFTOA');
update git_imports set transporter = 'East Africa renaissance cross border freight transporter' where transporter = 'East Africa Renaissance Cross';
update git_imports set transporter = 'Emergency Relief Trapnsport Enterprise' where transporter = 'Emergency Relief Transport';
update git_imports set transporter = 'Enait Gibe Cross Border Level 2 FTOA' where transporter = 'Enait Gibe Cross Border';
update git_imports set transporter = 'Fetan Freight Transport Owners Ass.' where transporter = 'Fetan Cross Border';
update git_imports set transporter = 'Fekadu Abebe Local Inland F.P. Transport' where transporter = 'Fikadu Abebe';
update git_imports set transporter = 'Gibe Freight Transport Owners Ass.' where transporter =  'Gibe Freight Transport';
update git_imports set transporter = 'Fekeru Garedew Local Level 4  F.D.P.T' where transporter = 'Fikru Garedew Local';
update git_imports set transporter =  'Habtamu Tamene Local Level 4 D.F.P.T'  where transporter in ('Habtamu Tamene Transport ','HABTAMU TAMENE LOCAL');
update git_imports set transporter =  'Habtamu Tamene Local Level 4 D.F.P.T'  where transporter in ('hosana','Hosaena Freight Transport','Hosana','Hossana Frieght Transport');
update git_imports set transporter =  'Hailemariam Mazengia'  where transporter = 'Hailemariam Mazengia ';
update git_imports set transporter = 'Mequaninit Eshete Local Level 4 FPT' where transporter ='Mequaninit Eshete Local';
update git_imports set transporter = 'MERAF Level 1 Across Border FTA' where transporter in ('Miraf Level 1 Across Border','MIraf Level 1 Across Border','Miraf Level 1 Across Border','MIraf Level 1 Across Border','MERAF Level 1 Across Border FTAT');
update git_imports set transporter = 'Shewaye W/Mariam Local Inland D.F.P.T.' where transporter like '%Shewa%';
update git_imports set transporter = 'Shewaye W/Mariam Local Inland D.F.P.T.' where transporter = 'Shawaye weldemaryam';
update git_imports set transporter = 'Shikur Abubekere Local Inland Level 4 F.P.T' where transporter = 'Shikur Abubeker Local';
update git_imports set transporter = 'Shikur Abubekere Local Inland Level 4 F.P.T' where transporter in ('Umer','Umer Hassen D.R.F.P.T');
update git_imports set transporter = 'Yerom Getinet Local Inland F.P.T' where transporter in ('Yerom','Yerom Getenet Local Inland F.P.T','Yerom Getinet Local Inland P.F.T ');

select count(*), transporter, name from git_imports left outer join transporters on git_imports.transporter = transporters.name group by transporter,name order by transporter;

update git_imports set project_code = 'China 10000 Mt' where project_code= '10,000mt China Government';
update git_imports set project_code = 'Government purchase 405000mt' where project_code in (E'405,000mt government purchase',E'Gov\'t Purchase 405,000 Mt',
                                                                               E'Gov\'t Purchase 405,000 Mt.',E'Gov\'t Purchase 405000 Mt'
                                                                               ,'government Purchase 405,000MT','Government Purchase 405,000MT'
                                                                               ,'GOVERNMENT PURCHASE 405000MT','government Purchase 405,000MT',
                                                                               'Government Purchase 405,000MT','GOVERNMENT PURCHASE 405000MT');

update git_imports set project_code = 'EFSRA 10000 Mt.' where project_code in ('EFSRA 10000 Mt','EFSRA 10000 MT.','FSRA 10000Mt');
update git_imports set project_code = 'EFSRA' where project_code in ('FSRA','FSRA ');
update git_imports set project_code =  'WFP-25000' where project_code in ('wfp25000mt','WFP25,000mt','WFP 25.000MT');
update git_imports set project_code =  'Government Local Purchase' where project_code in ('Government  Purchase ','gOVERNMENT PURCHASE',
                                        'Government Purchase','GOVERNMENT PURCHASE','government local purchase',
                                         E'Gov\'t Purchase','Government Purchase ','Govrenment Purchase');
update git_imports set project_code =  'WFP' where project_code in ('wfp','WFP');

update git_imports set project_code = 'DRMFSS Purchase/VegetableOil' where project_code = 'DRMFSS PURCHASE/VEGETABLEOIL';
update git_imports set project_code = 'DRMFSS Purchase 3000 Mt.'  where project_code in ('DRMFSS PURCHASE 3000 MT','DRMFSS Purchase 3000 Mt./WFP loan 4592.6 ','government local purchase 3000mt');
update git_imports set project_code = 'Government purchase 405000mt ' where project_code in ('DRMFSS Purchase 405,000 Mt','Government purchase 405000mt');
update git_imports set project_code = 'EFSRA 50000 Mt.' where project_code in ('EFSRA 50000 MT.','FSRA 5000MT');
update git_imports set project_code = 'FSCD45300Mt/2'  where project_code = 'FSCD45300MT/2';
update git_imports set project_code = 'EFSRA 10000 Mt.' where project_code = 'FSRA 10000Mt';
update git_imports set project_code = 'Government purchase 2751mt ' where project_code in (E'Gov\'t Purchase 2751 Mt.','GOVERNMENT PURCHASE 2751MT');
update git_imports set project_code = 'WFP 50000 mt ' where project_code = 'wfp 50,000mt';
update git_imports set project_code = 'Govenment Purchase/499,536Mt' where project_code in ('499,536/17,425mt government purchase','499,536/19,000mt government purchase','499,536/23,600mt government purchase');
update git_imports set project_code = 'EFSRA/Wheat' where project_code = 'EFSRA';
update git_imports set project_code = 'FSCD 70000' where project_code = 'FSCD'; 
update git_imports set project_code = 'Government purchase 405000mt ' where project_code = E'Gov\'t Purchase 405,000 Mt. and Gov\'t Purchase \/UNION\/';

update git_imports set project_code = 'Government Purchase/Union/Pulse' where project_code = 'local government purchase unions' and commodity_type in ('Beans','Cream Beans','Red Haricot Beans','Soya Beans','White Haricot Beans');
update git_imports set project_code = 'Government Purchase/Union/VOil' where project_code = 'local government purchase unions' and commodity_type = 'Vegitable Oil';
update git_imports set project_code = 'Government Purchase/Union/Cereal' where project_code = 'local government purchase unions' and commodity_type in ('Maize','Wheat');
update git_imports set project_code = 'WFP/VOil' where project_code in ('WFP/NDRMC','WFP Stock');

update git_imports set project_code = 'Government Purchase/Pulse' where project_code =  'Government purchase 2751mt ' and commodity_type in ('Pulse','Red Haricot Beans','Yellow Split Peas');
update git_imports set project_code = 'EFSRA/Maize' where project_code =  'EFSRA 10000 Mt.' and commodity_type = 'Maize ';
update git_imports set project_code = 'FSCD/Maize' where project_code in ('FSCD45300Mt/2','FSCD45300MT/2') and commodity_type in ('Maize ','Maize');
update git_imports set project_code = 'Government Purchase/Union/Pulse' where project_code =  E'Gov\'t Purchase \/UNION\/'
    and commodity_type in ('Cream Pulse','Peas','Pulse','Red Haricot Beans','White Haricot Beans','Yellow Split Peas');
update git_imports set project_code = 'Government Purchase/Union/Cereal' where project_code =  'local government purchase unions' and commodity_type  = 'Maize ';

update git_imports set project_code = 'Government Purchase/Union/VOil' where project_code =  E'Gov\'t Purchase \/UNION\/' and commodity_type = 'Vegitable Oil';
update git_imports set project_code = 'Government Purchase/Cereal' where project_code in  ('Government purchase 405000mt','Government purchase 405000mt ') and commodity_type in ('Maize ','Maize','Sorghum','Grain','Rice');
update git_imports set project_code = 'Government Purchase/Pulse' where project_code  in  ('Government purchase 405000mt','Government purchase 405000mt ') and commodity_type in ('Beans ','Beans','Peas','Pulse','Red Haricot Beans','Yellow Split Peas');
update git_imports set project_code = 'Government Purchase/BlendedFood' where project_code  in  ('Government purchase 405000mt','Government purchase 405000mt ') and commodity_type in ('CSB','FAMIX');
update git_imports set project_code = 'Government Purchase/VOil' where project_code in  ('Government purchase 405000mt','Government purchase 405000mt ') and commodity_type = 'Vegitable Oil';
update git_imports set project_code = 'WFP/Pulse' where project_code =  'WFP-25000' and commodity_type in ('Beans','Red Haricot Beans','Yellow Split Peas');
update git_imports set project_code = 'WFP/Cereal' where project_code =  'WFP-25000' and commodity_type in ('Maize');
update git_imports set project_code = 'WFP/VOil' where project_code =  'WFP-25000' and commodity_type in ('Vegitable Oil');
update git_imports set project_code = 'WFP/Pulse' where project_code =  'WFP' and commodity_type in ('Red Haricot Beans','Yellow Split Peas');
update git_imports set project_code = 'WFP/Cereal' where project_code =  'WFP' and commodity_type in ('Maize','Sorghum','Wheat');
update git_imports set project_code = 'WFP/VOil' where project_code =  'WFP' and commodity_type in ('Vegitable Oil');


update git_imports set project_code =  'DRMFSS Purchase/ CSB' where project_code in ('DRMFSS Purchase','DRMFSS','NDRMC Purchase','NDRMC PURCHASE') and commodity_type = 'CSB';
update git_imports set project_code =  'DRMFSS Purchase/VegetableOil' where project_code in ('DRMFSS Purchase','DRMFSS','NDRMC Purchase','NDRMC PURCHASE') and commodity_type = 'Vegitable Oil';
update git_imports set project_code =  'DRMFSS Purchase/Pulse' where project_code in ('DRMFSS Purchase','DRMFSS','NDRMC Purchase','NDRMC PURCHASE') and commodity_type in ('Pulse','Yellow Split Peas');
update git_imports set project_code =  'DRMFSS Purchase/BlendedFood' where project_code in ('DRMFSS Purchase','DRMFSS','NDRMC Purchase','NDRMC PURCHASE') and commodity_type in ('FAMIX');
update git_imports set project_code =  'DRMFSS Purchase/Wheat' where project_code = 'DRMFSS' and commodity_type = 'Wheat';

update git_imports set project_code =  'Government Purchase/Cereal' where project_code = 'Government Local Purchase' and commodity_type in ('Wheat','Maize','Maize ');
update git_imports set project_code =  'Government Purchase/BlendedFood' where project_code = 'Government Local Purchase' and commodity_type in ('CSB','FAMIX');
update git_imports set project_code =  'Government Purchase/Pulse' where project_code = 'Government Local Purchase' and commodity_type in ('Pulse','Red Haricot Beans','Yellow Split Peas','White Haricot Beans');
update git_imports set project_code =  'Government Purchase/VOil' where project_code = 'Government Local Purchase' and commodity_type = 'Vegitable Oil';
update git_imports set project_code = 'DRMFSS Purchase/Wheat' where project_code =  'DRMFSS Purchase 3000 Mt.' and commodity_type in ('Wheat');
update git_imports set project_code = 'EFSRA/Maize' where project_code =  'EFSRA 10000 Mt.' and commodity_type in ('Maize');

delete from git_imports where id > 35247;
delete from git_imports where gin is null;
delete from git_imports where project_code is null;


update git_imports set fdp= 'Abawergna' where fdp = 'Abaweregna';
update git_imports set fdp= 'Abobo town' where fdp = 'Abobo Town';
update git_imports set fdp= 'Abomesa' where fdp = 'Abomissa';
update git_imports set fdp= 'Abona' where fdp = 'abona';
update git_imports set fdp= 'Adis Hiwot' where fdp = 'Addis Hiwot';
update git_imports set fdp= 'Adde' where fdp in ('Ade','Ade ');
update git_imports set fdp = 'Adiharga' where fdp = 'Ade/Ha/age';
update git_imports set fdp= 'Adeleborobr' where fdp = 'Adele borobr';
update git_imports set fdp= 'Adele mecha' where fdp = 'Adele Mecha';
update git_imports set fdp= 'Adiarkay' where fdp = 'Adi-arkay';
update git_imports set fdp= 'Adequa' where fdp = 'Adiqa';
update git_imports set fdp= 'Adis Alem' where fdp = 'adis alem';
update git_imports set fdp= 'Ajibar' where fdp in ('ajibar','AJIBAR');
update git_imports set fdp= 'Ajikomagenteya' where fdp = 'Ajikomegenteya';
update git_imports set fdp= 'Alge' where fdp = 'Alege';
update git_imports set fdp= 'Alem Ketema' where fdp = 'Alem ketema';
update git_imports set fdp= 'Alem tena' where fdp = 'Alem Tena';
update git_imports set fdp= 'Eliwha' where fdp = 'Aliweha';
update git_imports set fdp= 'ILLia' where fdp = 'AliYa';
update git_imports set fdp= ' Amba 17' where fdp = 'Amba 17';
update git_imports set fdp= 'Angacha' where fdp = 'Anegacha';
update git_imports set fdp= 'Anka' where fdp = 'Aneka Diguna';
update git_imports set fdp= 'Aneno shesho' where fdp = 'Aneno Shesho';
update git_imports set fdp= 'Angella' where fdp = 'Angela';
update git_imports set fdp= 'Anomiti' where fdp = 'Anona Mite';
update git_imports set fdp= 'Arba' where fdp in ('Araba','Areba');
update git_imports set fdp= 'Arda Galma' where fdp = 'Arada Galma';
update git_imports set fdp= 'Altama' where fdp = 'Aratama';
update git_imports set fdp= 'Arbachafa' where fdp = 'Arba Chafe';
update git_imports set fdp= 'Albore' where fdp = 'Arbore';

update git_imports set fdp= 'Ardatare' where fdp = 'Aredatere';
update git_imports set fdp= 'Hara Jertie' where fdp = 'Arejarte';
update git_imports set fdp= 'Argada haredimtu' where fdp = 'Argada Harodimtu';
update git_imports set fdp= 'Armuma wonte' where fdp = 'Armuma Wonte';
update git_imports set fdp= 'Aseko' where fdp = 'Asako';
update git_imports set fdp= 'Asboda' where fdp = 'Aseboda';
update git_imports set fdp= 'Asabahari' where fdp = 'Asesehari';
update git_imports set fdp= 'Arba' where fdp = 'Awash Arba';
update git_imports set fdp= 'Awueumer' where fdp = 'Awumer';
update git_imports set fdp= 'Oylali' where fdp = 'Ayeyaleli';
update git_imports set fdp= 'B/ alekerm' where fdp = 'B/Alemkeram';
update git_imports set fdp= 'Badah amo' where fdp = 'Badahamo';
update git_imports set fdp= 'Bedeyi' where fdp = 'Badiyi';
update git_imports set fdp= 'Bhima' where fdp = 'Bahima';
update git_imports set fdp= 'Bake Kalate' where fdp = 'Bake Kelate';
update git_imports set fdp= 'Bale Bukesa' where fdp = 'Balebukla';
update git_imports set fdp= 'Bolo' where fdp = 'Balo';
update git_imports set fdp= 'B/Dimtu' where fdp = 'Bare Dimtu';
update git_imports set fdp= 'Beresa' where fdp = 'Barisa';
update git_imports set fdp= 'Bolyiche' where fdp = 'Be Deche';
update git_imports set fdp= 'Bakaredaar' where fdp = 'Bekariedear';
update git_imports set fdp= 'Belbeleti' where fdp in ('Belbelti','Belebeleti','Belebeliti');
update git_imports set fdp= 'Bokoji Dawaro' where fdp = 'Beqoji Dawero';
update git_imports set fdp= 'Berade' where fdp = 'Bered';
update git_imports set fdp= 'Beder' where fdp = 'Bidre';
update git_imports set fdp= 'Biraasa ' where fdp = 'Biiraasa';
update git_imports set fdp= 'Boiti' where fdp = 'Bodeti';
update git_imports set fdp= 'Boke tiko' where fdp in ('boke tiko','boke tiko','boke tiqo');
update git_imports set fdp= 'Bekol' where fdp = 'Bokol';
update git_imports set fdp= 'Bobor' where fdp = 'Borbor';
update git_imports set fdp= 'Bube' where fdp = 'bube';
update git_imports set fdp= 'Bubua' where fdp = 'Bubuaa';
update git_imports set fdp= 'Buii' where fdp = 'buii';
update git_imports set fdp= 'bulaia kejewa' where fdp = 'Bulalakrjawa';

update git_imports set fdp= 'Bule hora' where fdp = 'Bule Hora';
update git_imports set fdp= 'Bulbu' where fdp = 'Bulibule';
update git_imports set fdp= 'Bulkl' where fdp = 'Bulki';
update git_imports set fdp= 'Hulukochakasa' where fdp = 'Buluko Chakasa';
update git_imports set fdp= 'Buradera' where fdp = 'Burader';
update git_imports set fdp= 'Buryiasa' where fdp in ('burayisa','Burayisa');
update git_imports set fdp= 'Buryiasa' where fdp like '%Burayisa%';
update git_imports set fdp= 'Buryiasa' where fdp = 'Bure Mudayitu';
update git_imports set fdp= 'Burka' where fdp in ('BurKa','burqa');
update git_imports set fdp= 'Burkalamafo' where fdp = 'Burka lemefo';
update git_imports set fdp= 'Butta dalacha goda' where fdp = 'Buta Dalacha gada';
update git_imports set fdp= 'Buta dokore' where fdp = 'Buta Dokore';
update git_imports set fdp= 'Buii' where fdp = 'Buyi';
update git_imports set fdp= 'Chancho' where fdp = 'Canco';
update git_imports set fdp= 'Chabi' where fdp = 'chabi';
update git_imports set fdp= 'Chopi Degaga' where fdp = 'Chabi Degaga';
update git_imports set fdp= 'Chabi gara gafa' where fdp in ('Chabi gara gafa','Chabi Gara','Chabi gara');
update git_imports set fdp= 'Chafejila' where fdp = 'Chafe jila';
update git_imports set fdp= 'Chelleleqa' where fdp = 'Chalalaka';
update git_imports set fdp= 'Charena Kekre' where fdp = 'Chare';
update git_imports set fdp= 'Chebi dida ngata' where fdp = 'Chebi dida naya';
update git_imports set fdp= 'Checheq' where fdp = 'Chechek';
update git_imports set fdp= 'Chesefasleni' where fdp = 'Chefasine';
update git_imports set fdp= 'Cherkaka' where fdp = 'Cherqeqa';
update git_imports set fdp= 'Chirora' where fdp = 'Chhorora';
update git_imports set fdp= 'Chefera' where fdp in ('Chifera','Chifera');
update git_imports set fdp= 'Chopi Degaga' where fdp = 'Chobi degaga';
update git_imports set fdp= 'Chabi gara gafa' where fdp = 'Chobi Gara';
update git_imports set fdp= 'Sidiha Fage' where fdp = 'Cidaha Fage';
update git_imports set fdp= 'Chole' where fdp = 'Cole';
update git_imports set fdp= 'DechaBela' where fdp = 'D/Bela';
update git_imports set fdp= 'D/Killofta' where fdp = 'D/kolefta';
update git_imports set fdp= 'D/medhanit' where fdp = 'D/Medhanit';
update git_imports set fdp= 'D/S/Husen' where fdp = 'D/S/husen';
update git_imports set fdp= ' D/temona' where fdp = 'D/Temona';
update git_imports set fdp= ' Dambe Adanesh' where fdp = 'Dambe Adanesha';
update git_imports set fdp= 'Dembel' where fdp = 'Dambel';
update git_imports set fdp= 'Damote mokonisa' where fdp = 'Damot Mokonisa';
update git_imports set fdp= 'Da/Gudo' where fdp = 'Danaba Gud';
update git_imports set fdp= 'debota' where fdp = 'Debota';
update git_imports set fdp= 'Dheebiti' where fdp = 'Debti';
update git_imports set fdp= 'Dafo' where fdp = 'defo';
update git_imports set fdp= 'Daka Dala' where fdp = 'Deka qala';
update git_imports set fdp= 'Delgnemur' where fdp = 'Delegnmur';
update git_imports set fdp= 'Demchi' where fdp = 'Demich';
update git_imports set fdp= 'Dimtu Raratti' where fdp = 'Demtu Rarti';
update git_imports set fdp= 'Dre' where fdp = 'Dere';
update git_imports set fdp= 'D/Saden' where fdp = 'Dere Seden';
update git_imports set fdp= 'Detabahiri' where fdp = 'Detbahiri';
update git_imports set fdp= 'Dhadim' where fdp = 'Dhadhim';
update git_imports set fdp= 'Dechoto' where fdp = 'Dicheto';

update git_imports set fdp= 'Didole Hara' where fdp = 'Didole hara';
update git_imports set fdp= 'Dergera' where fdp = 'Diergera';
update git_imports set fdp= 'Demeka' where fdp = 'Dimeka';
update git_imports set fdp= 'Dial wanja' where fdp = 'Dila Wanja';
update git_imports set fdp= 'Dimma town' where fdp = 'Dima Town';
update git_imports set fdp = 'digalu' where fdp = 'Digalu';
update git_imports set fdp= 'Dinakose' where fdp = 'Dinoqose';
update git_imports set fdp = 'Dobi' where fdp = 'Dobe';
update git_imports set fdp = 'Debu' where fdp = 'Dobu';
update git_imports set fdp = 'Doasha' where fdp = 'Doesha';
update git_imports set fdp = 'Dure Bafeno/mulate' where fdp = 'Dorebafano';
update git_imports set fdp = 'Doyochale' where fdp = 'Doyo Chale';
update git_imports set fdp = 'Derabado' where fdp = 'Drebady';
update git_imports set fdp = 'Dugda' where fdp = 'Dugduga';
update git_imports set fdp = 'Dul hode' where fdp = 'Dulhode';
update git_imports set fdp = 'Dul Shitalo' where fdp = 'Dulshitalo';
update git_imports set fdp = 'Dhumuga' where fdp = 'Dumuga';
update git_imports set fdp = 'Dunchaye' where fdp = 'Dunchai';
update git_imports set fdp = 'Duko' where fdp = 'Duqo';

update git_imports set fdp = 'Ejersa Goro' where fdp = 'e.goro';
update git_imports set fdp = 'Erer Woldiya' where fdp = 'E/wol\dia';
update git_imports set fdp = 'Ibot Tirora' where fdp = 'Ebotie Tinora';
update git_imports set fdp = 'Ejere' where fdp = 'Ejerie';
update git_imports set fdp = 'Elele' where fdp = 'Elala';
update git_imports set fdp = 'elosi' where fdp = 'Elosi';
update git_imports set fdp = 'Undufo' where fdp = 'Endufo';
update git_imports set fdp = 'Erder' where fdp = 'Erdar';
update git_imports set fdp = 'Etay' where fdp = 'Etaye';
update git_imports set fdp = 'Eulaw' where fdp = 'Eullaw';

update git_imports set fdp = 'Fechatu' where fdp in ('Fachatu','Fachetu','fechatu');
update git_imports set fdp = 'Ferrada' where fdp = 'Farada';
update git_imports set fdp = 'Fonko' where fdp = 'Fonqo';
update git_imports set fdp = 'Fugnan bira' where fdp = 'Fuganbira';
update git_imports set fdp = 'Funani Dima' where fdp = 'Funandima';
update git_imports set fdp = 'Furuma' where fdp = 'Furuna';

update git_imports set fdp = 'Gundomeskel' where fdp = 'G/Maskele';
update git_imports set fdp = 'Gayo' where fdp = 'Gaayo';
update git_imports set fdp = 'Gadulo' where fdp = 'Gaduli';
update git_imports set fdp = 'GaeloHeja' where fdp = 'GaeloHerpo';
update git_imports set fdp = 'Galafi ketema' where fdp = 'Galafi';
update git_imports set fdp = 'Gelemso' where fdp in ('Galamso','Galemso');
update git_imports set fdp = 'Golcha' where fdp = 'Galcha';
update git_imports set fdp = 'Galada agaleyi' where fdp = 'Galda Agalye';
update git_imports set fdp = 'G/Duksi' where fdp = 'Gamoduksi';
update git_imports set fdp = 'Gara Dima' where fdp = 'Gara dima';
update git_imports set fdp = 'Gordama' where fdp = 'Gargoma';
update git_imports set fdp = 'Gasara' where fdp = 'Gasera';
update git_imports set fdp = 'Gabeba' where fdp = 'gebiba';
update git_imports set fdp = 'Gechenie' where fdp = 'Gechene';
update git_imports set fdp = 'Gnde Woin' where fdp = 'Gemadweyn';
update git_imports set fdp = 'Geneto' where fdp = 'Gemeto';
update git_imports set fdp = 'Genghang Town' where fdp = 'Genegnaing';
update git_imports set fdp = 'Genale' where fdp = 'Gennle';
update git_imports set fdp = 'Gerenbodima' where fdp = 'Gereba dima';
update git_imports set fdp = 'Gereja' where fdp = 'Gerja';
update git_imports set fdp = 'Gesuba' where fdp = 'Gesupa';
update git_imports set fdp = 'Gewahe ketema' where fdp = 'Geweha';
update git_imports set fdp = 'Galema' where fdp = 'Glema';
update git_imports set fdp = 'Goda dera' where fdp = 'Goda Dera';
update git_imports set fdp = 'Go/mission' where fdp = 'Godere Mission';
update git_imports set fdp = 'Goeb aluto' where fdp = 'Goeb Aluto';
update git_imports set fdp = 'Gog Melestegna' where fdp = 'Gog Mlestgna';
update git_imports set fdp = 'Goola' where fdp = 'Gola';
update git_imports set fdp = 'Gelo' where fdp = 'Gole';
update git_imports set fdp = 'Gmgoma' where fdp = 'Gomogoma';
update git_imports set fdp = 'Gaunguwa' where fdp = 'Gongawa';
update git_imports set fdp = 'Gorele' where fdp = 'Gorayle';
update git_imports set fdp = 'Godo/Fafate' where fdp = E'Gudo Fafa\'e';
update git_imports set fdp = 'Guhala' where fdp = 'GUHALA';
update git_imports set fdp = 'Gurmudale' where fdp = 'Gurmudessie';
update git_imports set fdp = 'Gutu-onamo' where fdp = 'Gutu Onano';
update git_imports set fdp = 'Guyahe' where fdp = 'Guyah';

update git_imports set fdp = 'Hallicho' where fdp = 'Habicho';
update git_imports set fdp = 'Hadalle' where fdp = 'Hadelle';
update git_imports set fdp = 'Haddo' where fdp = 'Hado';
update git_imports set fdp = 'Halo goba ' where fdp in ('halo goba','Halo Goba','Halo goba');
update git_imports set fdp = 'Haleseya' where fdp = 'Halsayeya';
update git_imports set fdp = 'Hamusit' where fdp in ('hamusit','HAMUSIT');
update git_imports set fdp = 'Hantete' where fdp = 'Hantate';
update git_imports set fdp = 'Hara kelo' where fdp = 'Haraqkalo';
update git_imports set fdp = 'Harar WFP' where fdp = 'hararWFP';
update git_imports set fdp = 'Hardim' where fdp = 'hardim';
update git_imports set fdp = 'Hariro' where fdp = 'harero';
update git_imports set fdp = 'H/Gedab' where fdp = 'Hargedeb';
update git_imports set fdp = 'Haro adi' where fdp in ('haro adi','Haro Adi');
update git_imports set fdp = 'Haro dumal' where fdp = 'Haro Dumal';
update git_imports set fdp = 'Haro Gurati' where fdp in ('haro gurati','Harogurati','Harogutati');
update git_imports set fdp = 'Haro Obo' where fdp = 'Haro Oba';
update git_imports set fdp = 'Harsis' where fdp = 'Harsise';
update git_imports set fdp = 'Haseharo' where fdp = 'Hasieharo';
update git_imports set fdp = 'Hatura' where fdp = 'hatura';
update git_imports set fdp = 'Goba Koricha' where fdp = 'Hayamo';
update git_imports set fdp = 'Hedeli Buri' where fdp = 'Hidlibure';
update git_imports set fdp = 'Indato' where fdp = 'Hindato';
update git_imports set fdp = 'Omocho' where fdp = 'Homocho';
update git_imports set fdp = 'Hora seba' where fdp = 'Hora soba';
update git_imports set fdp = 'Horazehab' where fdp = 'Horazahab';
update git_imports set fdp = 'Hosaena' where fdp = 'Hosana';
update git_imports set fdp = 'Hurufaa Lalee' where fdp = 'Hurufaa Lolee';
update git_imports set fdp = 'Enseno' where fdp = 'Inseno';
update git_imports set fdp = 'Etalu' where fdp = 'Itelu';

update git_imports set fdp = 'j/mirga' where fdp = 'J/Mirga';
update git_imports set fdp = 'Jaragoro' where fdp = 'Jara Goro';
update git_imports set fdp = 'jela aluto' where fdp = 'Jela Aluto';
update git_imports set fdp = 'Jalodida' where fdp = 'Jelo dida';
update git_imports set fdp = 'Jemaya' where fdp = 'Jemeya';
update git_imports set fdp = 'Jena' where fdp = 'Jenna';
update git_imports set fdp = 'Jilbo' where fdp = 'jilbo';
update git_imports set fdp = 'Janjibar' where fdp = 'Jinjibar';
update git_imports set fdp = 'Jibri' where fdp = 'Jirbi';

update git_imports set fdp = 'Kafis-idali' where fdp = 'Kafisadeli';
update git_imports set fdp = 'Kerjul' where fdp = 'Kajul';
update git_imports set fdp = 'kekuta' where fdp = 'Kakuta';
update git_imports set fdp = 'Kangaten' where fdp = 'Kangatin';
update git_imports set fdp = 'Kara' where fdp = 'kara';
update git_imports set fdp = 'karokorcho' where fdp = 'Karakorch';
update git_imports set fdp = 'Kassa Gita' where fdp = 'Kasageta';
update git_imports set fdp = 'Kebero ' where fdp = 'Kebero';
update git_imports set fdp = 'Ketete' where fdp = 'Ketetit';
update git_imports set fdp = 'Ktcha' where fdp = 'Kitcha';
update git_imports set fdp = 'Keyansho' where fdp = 'Kiyansho';
update git_imports set fdp = 'Klass Bure' where fdp = 'Klat Buri';
update git_imports set fdp = 'Kogneriay' where fdp in ('Kopriay','Kogneriyaye');
update git_imports set fdp = 'kokori' where fdp = 'Kokori';
update git_imports set fdp = 'Kore' where fdp = 'kore';
update git_imports set fdp = 'Korgange' where fdp = 'Korgange Town';
update git_imports set fdp = 'Kurfa' where fdp = 'kurfa';
update git_imports set fdp = 'Kurufetu' where fdp = 'Kuroftu';
update git_imports set fdp = 'Kortugne' where fdp = 'Kurtogn';
update git_imports set fdp = 'Kele' where fdp = 'Kyle';

update git_imports set fdp = 'lajo' where fdp = 'Lajo';
update git_imports set fdp = 'Lbore' where fdp = 'Lebere';
update git_imports set fdp = 'Lado' where fdp = 'Ledo';
update git_imports set fdp = 'Lela hobcho' where fdp = 'Lela Honcho';
update git_imports set fdp = 'Ledegaredabuse' where fdp = 'Lodegaredabusa';
update git_imports set fdp = 'Lokorom' where fdp = 'Lokorlem';
update git_imports set fdp = 'Ly/bdeno' where fdp = 'Lygnwbedeno';

update git_imports set fdp = 'Mehalmeda' where fdp in ('M/meda','M/Meda');
update git_imports set fdp = 'Meda' where fdp = 'Mada';
update git_imports set fdp = 'magna daratu' where fdp = 'Magna Daratu';
update git_imports set fdp = 'Melka Aman' where fdp = 'MalkaAmana';
update git_imports set fdp = 'Maqi' where fdp = 'Maqii';
update git_imports set fdp = 'Marabe mrmarsa' where fdp = 'Marabe Marmarsa';
update git_imports set fdp = 'Martu tiisa' where fdp = 'Martutilisa';
update git_imports set fdp = 'Metar Town' where fdp = 'Matar';
update git_imports set fdp = 'mechata' where fdp = 'Mechata';
update git_imports set fdp = 'Machitu' where fdp = 'Mechitu';
update git_imports set fdp = 'Medina' where fdp = 'MEDINA';
update git_imports set fdp = 'Mageneta' where fdp = 'Megenta';
update git_imports set fdp = ' Mekane  Brihan' where fdp = 'Mekane Â Brihan';
update git_imports set fdp = ' Mekane  Brihan' where fdp like '%Mekane%Brihan%';
update git_imports set fdp = 'Mikawa' where fdp = 'Mekawa';
update git_imports set fdp = 'mekonisa' where fdp = 'Mekonisa';
update git_imports set fdp = 'Meseka(selesa)' where fdp = 'Meleka';
update git_imports set fdp = 'Melgano qaulaka' where fdp = 'Melgano Qawlanka';
update git_imports set fdp = 'Malka Arba' where fdp = 'Melka Arba';
update git_imports set fdp = 'Malka Buta' where fdp = 'Melka Buta';
update git_imports set fdp = 'Melka Guba' where fdp = 'MelkaGuba';
update git_imports set fdp = 'Menisa wacho' where fdp = 'Menisa Wacho';
update git_imports set fdp = 'Mertulemariyam' where fdp = 'Mertolmaryiam';
update git_imports set fdp = 'Mesal' where fdp in ('mesela','Mesela');
update git_imports set fdp = 'Meskid' where fdp = 'Mesgid';
update git_imports set fdp = 'Metar Town' where fdp = 'Metar';
update git_imports set fdp = 'Meyaye' where fdp in ('meyaye','meyeye');
update git_imports set fdp = 'Michata' where fdp in ('michata','micheta');
update git_imports set fdp = 'Mille' where fdp = 'Mile';
update git_imports set fdp = 'Milkaye' where fdp = 'milikayi';
update git_imports set fdp = 'Mino' where fdp = 'mino';
update git_imports set fdp = 'Mole' where fdp = 'mole';
update git_imports set fdp = 'Muka Turi' where fdp = 'Muketure';
update git_imports set fdp = 'Mulisa' where fdp in ('mulisa','Mulissa');
update git_imports set fdp = 'Morosito' where fdp = 'Mursuto';

update git_imports set fdp = 'Negele Metama' where fdp = 'Na/metema';
update git_imports set fdp = 'Nakiya' where fdp = 'Nakya';
update git_imports set fdp = 'Nanig Dera' where fdp = 'Naniga dera';
update git_imports set fdp = 'Namayara Na Eregea Elita' where fdp = 'NEMAERA';
update git_imports set fdp = 'nebeneb' where fdp = 'Nibnib';

update git_imports set fdp = 'Ocholoch' where fdp = 'Ocholocho';
update git_imports set fdp = 'Hawi Gudina' where fdp = 'Odabultu';
update git_imports set fdp = 'odo wutate' where fdp = 'Odo Wutate';
update git_imports set fdp = 'Ogolcho' where fdp = 'Ogalcho';
update git_imports set fdp = 'Okolitu' where fdp = 'Okoltu';
update git_imports set fdp = 'Olankomi' where fdp = 'Olonkomi';

update git_imports set fdp = 'Pukdi' where fdp = 'Pukydi';
update git_imports set fdp = 'Puldeng' where fdp = 'Pulding';
update git_imports set fdp = 'Pegngnag' where fdp = 'Pungnang Town';

update git_imports set fdp = 'Qonna Motumma' where fdp = 'QonaMotuma';
update git_imports set fdp = 'Kore' where fdp = 'qore';

update git_imports set fdp = 'Rate Barkonch' where fdp = 'Ratie Borkonchi';
update git_imports set fdp = 'Ree' where fdp = 'Rea';
update git_imports set fdp = 'Mazoriya' where fdp = 'Regdina Mazoria';
update git_imports set fdp = 'Robit' where fdp = 'Robit / Arbaya';
update git_imports set fdp = 'Rogge' where fdp = 'Roge';
update git_imports set fdp = 'Rufo chancho' where fdp = 'Rufo Chancho';

update git_imports set fdp = 'Samaro' where fdp = 's';
update git_imports set fdp = 's/kudusa' where fdp = 'S/Kudusa';
update git_imports set fdp = 'Sabat' where fdp in ('sabat','Sabati');
update git_imports set fdp = 'Sabure' where fdp = 'Sabore';
update git_imports set fdp = 'Sadiqa' where fdp = 'Saddika';
update git_imports set fdp = 'Saka kalo' where fdp = 'Saka Kalo';
update git_imports set fdp = 'Sakina' where fdp = 'sakina';
update git_imports set fdp = 'Sahani' where fdp = 'Satani';
update git_imports set fdp = 'Sayyo' where fdp = 'Sayo';
update git_imports set fdp = 'Sabat' where fdp in ('sebati','Sebati');
update git_imports set fdp = 'Segno' where fdp = 'Segeno';
update git_imports set fdp = 'Selga 21' where fdp = 'Selga 20';
update git_imports set fdp = 'Sekota' where fdp = 'Seqota';
update git_imports set fdp = 'Sheycha' where fdp = 'Shaecha';
update git_imports set fdp = ' Shakso shone' where fdp in ('Shakso shone','Shakso Shone');
update git_imports set fdp = 'Sunko' where fdp = 'Shanko';
update git_imports set fdp = 'Shaawee' where fdp = 'Shawe';
update git_imports set fdp = 'Shilasaf' where fdp in ('Shelafaf','SHILAFAF');
update git_imports set fdp = 'Shelella' where fdp = 'Shelela';
update git_imports set fdp = 'Shanaka' where fdp = 'Sheneka';
update git_imports set fdp = 'Shewrobit' where fdp in ('Shewarebit','Shewarobit');
update git_imports set fdp = 'Sekoyeta' where fdp = 'Siekoyta';
update git_imports set fdp = 'Sikie' where fdp = 'Sikole';
update git_imports set fdp = 'Sofi' where fdp in ('sofi');
update git_imports set fdp = 'Sofe Umer' where fdp = 'Sofi Umar';
update git_imports set fdp = 'Sororo' where fdp = 'sororo';
update git_imports set fdp = 'Soyamasura' where fdp = 'Soyome sor';
update git_imports set fdp = 'Tsetse adinunu' where fdp = 'Steste Agurnunu';
update git_imports set fdp = 'Sunko' where fdp = 'sunko';
update git_imports set fdp = 'Surri' where fdp in ('Suri','surri');
update git_imports set fdp = 'Seula ketema' where fdp = 'Suula';

update git_imports set fdp = 'T/hiywot' where fdp = 'T/Hiwot';
update git_imports set fdp = 'Tedecha' where fdp = 'Tadacha';
update git_imports set fdp = 'Teyife' where fdp in ('Taife','teyife');
update git_imports set fdp = ' Tangaye Koma' where fdp = 'Tangakoma';
update git_imports set fdp = 'Taoo' where fdp = 'Tao';
update git_imports set fdp = 'Tayemn' where fdp in ('Taymen','Taymen','TAYMEN');
update git_imports set fdp = 'Tegni' where fdp = 'Tegne';
update git_imports set fdp = 'Toyba' where fdp = 'Teyiba';
update git_imports set fdp = 'Tile Mido' where fdp = 'Tilemado';
update git_imports set fdp = 'Terengule' where fdp = 'Tirngole';
update git_imports set fdp = 'Tokumajarso & Inama Tolera' where fdp = 'Tokumajarso Inama Tolera';
update git_imports set fdp = 'Tullo' where fdp = 'Tula';
update git_imports set fdp = 'Tulagorbe' where fdp = 'Tulagorbye';
update git_imports set fdp = 'Tumetumkar' where fdp = 'Tumetmukar';
update git_imports set fdp = 'Tumet Oube' where fdp = 'Tumte ube';
update git_imports set fdp = 'Tumeticha' where fdp = 'Tumticha';

update git_imports set fdp = 'Ute' where fdp = 'ute';
update git_imports set fdp = 'W/barisa' where fdp = 'W/Barisa';
update git_imports set fdp = 'w/kacara' where fdp = 'W/Kacara';
update git_imports set fdp = 'Wacha' where fdp = 'wachu';
update git_imports set fdp = 'Wachbudima' where fdp = 'Wachudima';
update git_imports set fdp = 'Walenso' where fdp = 'Walensu';
update git_imports set fdp = 'Warajarso' where fdp = 'Warajarsa';
update git_imports set fdp = 'Were' where fdp = 'Ware';
update git_imports set fdp = 'Waytileyta' where fdp = 'Waytalyta';
update git_imports set fdp = 'Wedged' where fdp = 'Wejid';
update git_imports set fdp = 'Weldiya' where fdp = 'weldiya';
update git_imports set fdp = 'Weltah meka' where fdp = 'Weltah Meked';
update git_imports set fdp = 'Welthah meshire' where fdp = 'Weltah Meshire';
update git_imports set fdp = 'Wereilu' where fdp = 'Werellu';
update git_imports set fdp = 'Warar' where fdp = 'Werer';
update git_imports set fdp = 'Wogdi' where fdp = 'wogdi';
update git_imports set fdp = 'Wedged' where fdp = 'Wojid';
update git_imports set fdp = 'Woldya' where fdp = 'Woldiya';
update git_imports set fdp = 'Erer Woldiya' where fdp = 'E/woldia';
update git_imports set fdp = 'Waltai gobu' where fdp = 'Wolty Goba';
update git_imports set fdp = 'Wqen' where fdp = 'Woqen';
update git_imports set fdp = 'Awra Woreda Center' where fdp = 'Woreda Maekel';
update git_imports set fdp = 'Weama' where fdp = 'Woyima';
update git_imports set fdp = 'Wubie' where fdp in ('wube','Wube');

update git_imports set fdp = 'Yirgalem' where fdp = 'Yergalem';
update git_imports set fdp = 'yeri' where fdp = 'Yeri';
update git_imports set fdp = 'Yegem' where fdp = 'yigem';
update git_imports set fdp = 'Erer Hwaye' where fdp is null and region = 'Harari' and woreda = 'Erer Hwaye';



select setval('dispatches_id_seq',(select max(id) from dispatches) );
select setval('dispatch_items_id_seq',(select max(id) from dispatch_items));


/*

select count(*), commodity_type, name from git_imports left outer join commodities 
on git_imports.commodity_type = commodities.name group by commodity_type, name

select * from (select count(*), commodity_class,commodity_type, name from git_imports left outer join commodity_categories 
on git_imports.commodity_class = commodity_categories.name group by commodity_class,commodity_type, name) as c where c.commodity_class is null;

select * from (select count(*), fdp, git_imports.region,git_imports.zone,git_imports.woreda , name
               from git_imports left outer join fdps on git_imports.fdp = fdps.name 
               group by fdp,git_imports.region,git_imports.zone,git_imports.woreda,name) as f
               where f.name is null order by fdp;

select count(*),git_imports.project_code, git_imports.commodity_type, projects.project_code,projects.commodity_source
from git_imports left outer join projects on git_imports.project_code = projects.project_code 
group by git_imports.project_code, git_imports.commodity_type, projects.project_code, projects.commodity_source

*/


