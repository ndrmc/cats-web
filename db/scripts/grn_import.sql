COPY (select * from grn_imports where project_code is null)
TO 'D:/CATS/grns_without_project_code.csv' DELIMITER ',' CSV HEADER;

delete from grn_imports where project_code is null;

update grn_imports set commodity_source = 'Local Purchase' 
where supplier = 'Government purchase' or 
project_code in ('local government purchase unions','Government Local Purchase','405,000mt government purchase',
                 E'Gov\'t pur 499536 mt','499,366/23,600MT Government Purchase','499,336/19,100MT Government Purchase',
                '499,536/17425MT Government Purchase',E'Government Purchase\/Union\/','499536/24496.26mt  Government Purchase',
                '499,536Mt Government Purchase',E'Gov\'t Purchase 2751 Mt.','Government purchase 4000mt.',
                 'FSRA/499MT Govrement Purchase',E'FSRA-88-15000MTgov\'t Purchase','1500mt Government Purchase','Gov.t Purches',
                '5,000mt local government purchase unions','Government Local 100mt');
                
update grn_imports set donor = 'WFP' where donor='Wfp';
update grn_imports set commodity_source = 'Donation' where donor = 'WFP' and origin in ('Port','Djibouti');
update grn_imports set supplier = 'Woreta EFSRA' where supplier = 'Wereta ESFRA';
update grn_imports set supplier = 'UNKNOWN' where supplier is null;

update grn_imports set commodity_type = 'Beans' where commodity_type in ('beans');
update grn_imports set commodity_type = 'Cream Beans' where commodity_type in ('cream beans');
update grn_imports set commodity_type = 'CSB' where commodity_type in ('csb','cSB','Csb','CSB ');
update grn_imports set commodity_type = 'CSB+' where commodity_type in ('csb+');
update grn_imports set commodity_type = 'FAMIX' where commodity_type in ('famix','Famix');
update grn_imports set commodity_type = 'Wheat Flour' where commodity_type in ('Flour','wheat flour');
update grn_imports set commodity_type = 'Maize ' where commodity_type in ('Maize');
update grn_imports set commodity_type = 'Red Haricot Beans' where commodity_type in ('red beans','Red beans','Red Beans');
update grn_imports set commodity_type = 'Rice' where commodity_type in ('rice');
update grn_imports set commodity_type = 'Sorghum' where commodity_type in ('sorghum');
update grn_imports set commodity_type = 'Soya Beans' where commodity_type in ('soy beans','Soy Beans','soya beans');
update grn_imports set commodity_type = 'Yellow Split Peas' where commodity_type in ('split peas');
update grn_imports set commodity_type = 'Vegitable Oil' where commodity_type in ('V.oil','V.Oil');
update grn_imports set commodity_type = 'Wheat' where commodity_type in ('wheat','WHEAT','wheat ');
update grn_imports set commodity_type = 'White Haricot Beans' where commodity_type in ('white beans');
update grn_imports set commodity_type = 'Fafa Relief' where commodity_type in ('FAFA');
update grn_imports set commodity_type = 'Mecarone' where commodity_type in ('Makroni');


update grn_imports set commodity_class = 'Creal' where commodity_class in ('Grain','Cereal','Rice');
update grn_imports set commodity_class = 'Supplementary Food' where commodity_class in ('Dates','Flour');
update grn_imports set commodity_class = 'Pulse' where commodity_class in ('pulse','CSB');
update grn_imports set commodity_class = 'Oil' where commodity_class in ('V.oil','V.Oil');


update grn_imports set transporter_name = 'Hossana Freight Transport' where transporter_name in ('Adis Melese[Hossena]','Ashenafi Tamerat[Hossana]',
                                                                                                 'Fekadu Bekelel[Hossena]','Berhanu shebbaw[Hossan]',
                                                                                                 'Germa Tofik[Hossena]','Gezahegn Focha[Hossna]',
                                                                                                 'Sisay Samueal[Hossena]',
                                                                                                 'Gulelat [Hossana]','Gezahgn focha[Hossan]','mehari Stigaye[Hossena]',
                                                                                                'Hosaena','Hosaena Freight TransPort','Hosana Transport',
                                                                                                'Hossaina','Melaku Bekele[Hossana]','Sisay Alemu[Hossena]',
                                                                                                'Yonas Begashaw[Hossana]','Yoseph Eshetu','Yoseph Eshetu[Hossana]');
update grn_imports set transporter_name = 'ALPHA' where transporter_name = ('Alpha');
update grn_imports set transporter_name = 'Asmamaw Meles Local Inland FPT' where transporter_name = ('Asmamaw Melese');
update grn_imports set transporter_name = 'Awol Ansha Agr. Devt. Grain Trade and Private Cargo Fright Transport' where transporter_name in ('Awel Ansha','Awel Ansha Local','AwoelTeransport');
update grn_imports set transporter_name = ('Emergency Relief Trapnsport Enterprise') where transporter_name in('Emergency','Emergency Relief Transport','Emergency Relief TransPort','Emergency Relife TransPort');
update grn_imports set transporter_name = ('Bekelecha Transport SH.Co.') where transporter_name in('Bekelcha','Bekelcha TransPort','Bekelcha TransPort');
update grn_imports set transporter_name = 'Bekele Wolde Local Inland  F.P. Transport' where transporter_name like '%Bekele %';
update grn_imports set transporter_name = 'BLUE NILE' where transporter_name = 'Blue nile transPort';
update grn_imports set transporter_name = 'DEJEN' where transporter_name in ('Dejen','Dejen Cross-Border','Dejen Cross-Border[Shahshemene','Dejen TransPort','Dejen Cross-Border[Wolayita');
update grn_imports set transporter_name = 'Fetan Freight Transport Owners Ass.' where transporter_name = 'Fetan Cross Border';
update grn_imports set transporter_name = 'Fekeru Garedew Local Level 4  F.D.P.T' where transporter_name in ('Fikru Garedew','Fikru Garedew Local');
update grn_imports set transporter_name = 'Ghion FT ' where transporter_name = 'Ghion FT';
update grn_imports set transporter_name = 'Gibe Freight Transport Owners Ass.' where transporter_name in ('Gibe','Gibe Boarder','Gibe Transport');
update grn_imports set transporter_name = 'GLOBAL' where transporter_name in ('Global ','Global Cross-Boarder');
update grn_imports set transporter_name = 'Selam Cross Border FTOA' where transporter_name = 'SELAM TransPort';
update grn_imports set transporter_name = 'Grand united' where transporter_name = 'Grand United TransPort';
update grn_imports set transporter_name = 'Habtamu Tamene Dry Freight Private Transport' where transporter_name = 'Habtamu Tamene Transport';
update grn_imports set transporter_name = 'MEDIN' where transporter_name = 'Medhin Cross-Border';
update grn_imports set transporter_name = 'Mequaninit Eshete Local Level 4 FPT' where transporter_name = 'Mequanint Eshete';
update grn_imports set transporter_name = 'Yohannes Kebede Local D.F.P.T' where transporter_name in ('Yohans Teranseport','Yohanes aKebede');
update grn_imports set transporter_name = 'Hailemariam Mazengia' where transporter_name in ('HaileMariam Mazengia','Hailemariam Mazengia ');
update grn_imports set transporter_name = 'Shikur Abubekere Local Inland Level 4 F.P.T' where transporter_name = 'Shikur Abubeker';
update grn_imports set transporter_name = 'Trans' where transporter_name = 'Trans TransPort';
update grn_imports set transporter_name = 'MYSERU' where transporter_name = 'Mayesru Cross-Border';
update grn_imports set transporter_name = 'TSEHAY' where transporter_name = 'Tsehay';
update grn_imports set transporter_name = 'MERAF Level 1 Across Border FTA' where transporter_name in ('Miraf Level 1 Across Border','Miraf Level 1 Across Border');
update grn_imports set transporter_name = 'Umer Hassen DFPT' where transporter_name ='Umer Hassen';
update grn_imports set transporter_name = 'Tikur Abay Transport P.L.C' where transporter_name like ('%TIKUR ABAY%');
update grn_imports set transporter_name = 'Abbarci Trans Co. Ltd' where transporter_name in ('abbarci TransPort');
update grn_imports set transporter_name = 'Abyssnia' where transporter_name in ('ABYSSINIA');


update grn_imports set project_code = 'Govenment Purchase/499,536Mt' where project_code in ('FSRA/499MT Govrement Purchase','499,336/19,100MT Government Purchase','499,366/23,600MT Government Purchase','499,536/17425MT Government Purchase','499,536Mt Government Purchase','499536/24496.26mt  Government Purchase',E'Gov\'t pur 499536 mt','Govenment Purchase/499,536Mt');
update grn_imports set project_code = 'Government purchase 405000mt ' where project_code in ('405,000mt government purchase');
update grn_imports set project_code = 'EFSRA' where project_code in ('FSRA');
update grn_imports set project_code =  'WFP' where project_code in ('wfp','WFP ','wFP');

update grn_imports set project_code =  'Government Purchase/BlendedFood' where project_code = 'Government Local Purchase' and commodity_type in ('CSB','CSB+','FAMIX');
update grn_imports set project_code =  'Government Purchase/VOil' where project_code in ('Government Local Purchase','Gov.t Purches') and commodity_type = 'Vegitable Oil';

update grn_imports set project_code = 'Government Purchase/Union/Pulse' where project_code in  (E'Government Purchase\/Union\/','local government purchase unions')
    and commodity_type in ('Cream Beans','Cream Pulse','Beans','Peas','Pulse','Red Haricot Beans','White Haricot Beans','Yellow Split Peas','Soya Beans');
update grn_imports set project_code = 'Government Purchase/Union/Cereal' where project_code =  'local government purchase unions' and commodity_type  in ('Maize ','Wheat') ;
update grn_imports set project_code = 'Government Purchase/Union/FoodSupplement' where project_code =  'local government purchase unions' and commodity_type  in ('Wheat Flour') ;

update grn_imports set project_code = 'WFP/Pulse' where project_code =  'WFP' and commodity_type in ('Red Haricot Beans','Beans');
update grn_imports set project_code = 'WFP/Cereal' where project_code =  'WFP' and commodity_type in ('Maize ','Wheat');
update grn_imports set project_code = 'WFP/VOil' where project_code =  'WFP' and commodity_type in ('Vegitable Oil');

update grn_imports set project_code = 'WFP 50000 mt ' where project_code in ('wfp 50,000mt');
update grn_imports set project_code = 'WFP-25000' where project_code in ('WFP 25,000mt');
update grn_imports set project_code = 'WFP-25000/7000' where project_code in ('wfp-25000/7000');
update grn_imports set project_code = 'WFP 1000Mt' where project_code in ('WFP 1000mt');
update grn_imports set project_code = 'WFP 50000 mt ' where project_code in ('WFP 50000 mt ');
update grn_imports set project_code = 'FSCD/Maize' where project_code = 'FSCD' and commodity_type = 'Maize ';
update grn_imports set project_code = 'FSCD/Wheat' where project_code = 'FSCD' and commodity_type = 'Wheat';
update grn_imports set project_code = 'EFSRA/Wheat' where project_code =  'EFSRA' and commodity_type in ('Wheat');

update grn_imports set project_code = 'DRMFSS Purchase 1500 Mt. /Union/' where project_code =  '1500mt Government Purchase';
update grn_imports set project_code = 'DRMFSS Purchase 5000' where project_code =  '5,000mt local government purchase unions';
update grn_imports set project_code = 'DRMFSS Purchase/ CSB' where project_code =  'DRMFSS' and commodity_type = 'CSB';
update grn_imports set project_code = 'Government purchase 2751mt ' where project_code =  E'Gov\'t Purchase 2751 Mt.';


/*
select * from (select count(*), hub, name
               from grn_imports left outer join hubs on grn_imports.hub = hubs.name 
               group by hub, name) as h
               where h.name is null order by hub;
update grn_imports set hub = 'Adama' where hub = 'Nazareth'

select count(*),grn_imports.project_code, grn_imports.commodity_type, projects.project_code,projects.commodity_source
from grn_imports left outer join projects on grn_imports.project_code = projects.project_code 
group by grn_imports.project_code, grn_imports.commodity_type, projects.project_code, projects.commodity_source;


select count(*), project_code, commodity_source from grn_imports
group by project_code,commodity_source order by count desc;

select * from (select count(*), commodity_class, name from grn_imports left outer join commodity_categories 
on grn_imports.commodity_class = commodity_categories.name group by commodity_class, name) as c where c.name is null;

select * from (select count(*), commodity_type, name from grn_imports left outer join commodities
on grn_imports.commodity_type = commodities.name group by commodity_type, name) as c where c.name is null;

select count(*), transporter_name, name from grn_imports left outer  join transporters 
on grn_imports.transporter_name = transporters.name group by transporter_name, name order by transporter_name asc;


*/