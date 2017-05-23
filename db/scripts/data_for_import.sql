select setval('commodities_id_seq',(select max(id) from commodities));
select setval('organizations_id_seq',(select max(id) from organizations));
select setval('deliveries_id_seq',(select max(id) from deliveries));
select setval('delivery_details_id_seq',(select max(id) from delivery_details));
select setval('dispatches_id_seq',(select max(id) from dispatches) );
select setval('dispatch_items_id_seq',(select max(id) from dispatch_items));
select setval('receipts_id_seq',(select max(id) from receipts) );
select setval('receipt_lines_id_seq',(select max(id) from receipt_lines));
select setval('transporters_id_seq',(select max(id) from transporters));
select setval('operations_id_seq',(select max(id) from operations));

insert into fdps(name,active,location_id,woreda,zone,region,created_at,updated_at) values ('Akobo',true,257,'Akobo','Nuer','Gambella','2017-10-15','2017-10-15');
insert into fdps(name,active,location_id,woreda,zone,region,created_at,updated_at) values ('Gashamo',true,11824,'Gashamo','Jarar','Somali','2017-01-20','2017-01-20');
insert into fdps(name,active,location_id,woreda,zone,region,created_at,updated_at) values ('Gebisa',true,406,'Mesela','W.Hararghe','Oromia','2017-01-20','2017-01-20');
insert into fdps(name,active,location_id,woreda,zone,region,created_at,updated_at) values ('Mender 104',true,634,'','Pawi','Beneshangul Gumuz','2017-01-20','2017-01-20');
insert into fdps(name,active,location_id,woreda,zone,region,created_at,updated_at) values ('Mender 127',true,634,'','Pawi','Beneshangul Gumuz','2017-01-20','2017-01-20');


insert into transporters(name,code,created_at,updated_at) values ('Hailemariam Mazengia','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Nur Hussien','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Assefa Tamer Dry Freight Private Transport','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Bekelecha Transport SH.Co.','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Biftu Transport','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Getas TransPort','New','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('Genet Kebede','GK','2017-01-20','2017-01-20');
insert into transporters(name,code,created_at,updated_at) values ('UNKNOWN','UNKNOWN','2017-01-20','2017-01-20');

insert into operations(program_id,hrd_id,name,year,round,month,created_at,updated_at) values (1,4177,'2008 Round 9 Relief','2008',9,9,'2017-10-15','2017-10-15');
