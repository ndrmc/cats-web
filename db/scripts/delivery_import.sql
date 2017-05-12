update delivery_imports set commodity_type = sub_commodity where commodity_type is null;
update delivery_imports set commodity_type = 'Vegitable Oil' where commodity_type in ('Vegtable oil','Vegetable Oil','Vegetabel oil','V.Oil');
update delivery_imports set commodity_type = 'Oil' where commodity_type = 'oil';
update delivery_imports set commodity_type = 'Blended food' where commodity_type in ('Blended Food','Mixed');

update delivery_imports set destination = 'Abobo town' where destination = 'Abobo Town';
update delivery_imports set destination = 'Alge' where destination = 'Alege';
update delivery_imports set destination = ' Amba 17' where destination = 'Amba 17';
update delivery_imports set destination = 'Angella' where destination = 'Angela';
update delivery_imports set destination = 'Armuma wonte' where destination = 'Armuma Wonte';
update delivery_imports set destination = 'Garda' where destination = 'Blagarda';
update delivery_imports set destination = 'Bulbu' where destination = 'Bulibule';
update delivery_imports set destination = 'Buradera' where destination = 'Burader';
update delivery_imports set destination = ' D/temona' where destination = 'D/temona';
update delivery_imports set destination = ' Dambe Adanesh' where destination = 'Dambe Adanesh';
update delivery_imports set destination = 'Daka Dala' where destination = 'Deka qala';
update delivery_imports set destination = 'Dial wanja' where destination = 'Dila Wanja';
update delivery_imports set destination = 'Dul hode' where destination = 'Dulhode';
update delivery_imports set destination = 'Dul Shitalo' where destination = 'Dulshitalo';
update delivery_imports set destination = 'Dunchaye' where destination = 'Dunchai';
update delivery_imports set destination = 'Duko' where destination = 'Duqo';
update delivery_imports set destination = 'Ibot Tirora' where destination = 'Ebotie Tinora';
update delivery_imports set destination = 'Ejere' where destination = 'Ejerie';
update delivery_imports set destination = 'Erer Woldiya' where destination = 'Erer Woldya';
update delivery_imports set destination = 'Etay' where destination = 'Etaye';
update delivery_imports set destination = 'Fital' where destination = 'Fitale';
update delivery_imports set destination = 'Gundomeskel' where destination = 'G/Maskele';
update delivery_imports set destination = 'Genghang Town' where destination = 'Genegnaing';
update delivery_imports set destination = 'Gerenbodima' where destination in ('Gereba dima','Gereba dima','Gereba Dima');
update delivery_imports set destination = 'Gesuba' where destination = 'Gesupa';
update delivery_imports set destination = 'Galema' where destination = 'Glema';
update delivery_imports set destination = 'Go/mission' where destination = 'Godere Mission';
update delivery_imports set destination = 'Goge ' where destination = 'Goge';
update delivery_imports set destination = 'Halo goba ' where destination = 'Halo goba';
update delivery_imports set destination = 'Hara kelo' where destination = 'Haraqkalo';
update delivery_imports set destination = 'hida' where destination = 'Hida';
update delivery_imports set destination = 'Hiwane ' where destination = 'Hiwane';
update delivery_imports set destination = 'Hora seba' where destination = 'Hora soba';
update delivery_imports set destination = 'Horazehab' where destination = 'Horazahab';
update delivery_imports set destination = 'Kebero ' where destination = 'Kebero';
update delivery_imports set destination = 'kokori' where destination in ('Kokori','Kokori');
update delivery_imports set destination = 'Korgange' where destination = 'Korgange Town';
update delivery_imports set destination = 'Kortugne' where destination = 'Kurtogn';
update delivery_imports set destination = 'Metar Town' where destination in ('Matar','Metar');
update delivery_imports set destination = ' Mekane  Brihan' where destination like '%Mekane%Brihan%';
update delivery_imports set destination = 'Mikawa' where destination = 'Mekawa';
update delivery_imports set destination = ' Mekele 2' where destination = 'Mekele 2';
update delivery_imports set destination = 'Melka Guba' where destination = 'MelkaGuba';
update delivery_imports set destination = 'Muka Turi' where destination = 'Muketure';
update delivery_imports set destination = 'nebeneb' where destination = 'Nibnib';
update delivery_imports set destination = 'Pegngnag' where destination = 'Pungnang Town';
update delivery_imports set destination = 'Rufo chancho' where destination = 'Rufo Chancho';
update delivery_imports set destination = ' Shakso shone' where destination = 'Shakso shone';
update delivery_imports set destination = ' Tangaye Koma' where destination = 'Tangaye Koma';
update delivery_imports set destination = 'Wachbudima' where destination = 'Wachudima';
update delivery_imports set destination = 'Meta' where destination = 'Wayiber';
update delivery_imports set destination = 'yeri' where destination = 'Yeri';


update delivery_imports set transporter_name = 'Bekele Wolde Local Inland  F.P. Transport' where transporter_name like '%Bekele%Wolde%Local%Inland%F.P.%Transport';
update delivery_imports set transporter_name = 'Fekeru Garedew F.T' where transporter_name like '%Fekeru%Garedew%Local%Level%4%F.D.P.T';
update delivery_imports set transporter_name = 'UNKNOWN' where transporter_name is null;
update delivery_imports set transporter_name = 'UNKNOWN' where transporter_name = 'y';

update delivery_imports set allocation_year = '2008' where allocation_year = '2009';


/*select count(*), allocation_year, round, program from delivery_imports 
group by allocation_year, round, program order by allocation_year;

select count(*), transporter_name, name from delivery_imports
left outer join transporters on delivery_imports.transporter_name = transporters.name 
where name is null 
group by transporter_name,name order by transporter_name;

select count(*), commodity_type, name from delivery_imports left outer join commodities 
on delivery_imports.commodity_type = commodities.name group by commodity_type, name;

                       
select * from (select count(*), destination, name from delivery_imports left outer join fdps 
on delivery_imports.destination = fdps.name group by destination, name ) as d where d.name is null;*/