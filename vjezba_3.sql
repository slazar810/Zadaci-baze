drop database if exists vjezba_3;
create database vjezba_3 character set utf8;
use vjezba_3;


create table svekar(
    sifra int not null primary key auto_increment,
    novcica decimal(16,8) not null,
    suknja varchar(44) not null,
    bojakose varchar(36),
    prstena int,
    narukvica int not null,
    cura int not null
);



create table cura(
    sifra int not null primary key auto_increment,
    dukserica varchar(49),
    maraka decimal(13,7),
    drugiputa datetime,
    majica varchar(49),
    novcica decimal(15,8),
    ogrlica int not null
);

create table snasa(
    sifra int not null primary key auto_increment,
    introvertno bit,
    kuna decimal(15,6) not null,
    eura decimal(12,9) not null,
    treciputa datetime,
    ostavljena int not null
);



create table ostavljena(
    sifra int not null primary key auto_increment,
    kuna decimal(17,5),
    lipa decimal(15,6),
    majica varchar(36),
    modelnaocala varchar(31) not null,
    prijatelj int
);



create table punica(
    sifra int not null primary key auto_increment,
    asocijalno bit,
    kratkamajica varchar(44),
    kuna decimal(13,8) not null,
    vesta varchar(32) not null,
    snasa int
);

create table prijatelj(
    sifra int not null primary key auto_increment,
    kuna decimal(16,10),
    haljina varchar(37),
    lipa decimal(13,10),
    dukserica varchar(31),
    indiferentno bit not null
);

create table prijatelj_brat(
    sifra int not null primary key auto_increment,
    prijatelj int not null,
    brat int not null
);


create table brat (
    sifra int not null primary key auto_increment,
    jmbag char(11),
    ogrlica int not null,
    ekstrovertno bit not null
);

alter table svekar add foreign key (cura) references cura(sifra);
alter table snasa add foreign key (ostavljena) references ostavljena(sifra);
alter table ostavljena add foreign key (prijatelj) references prijatelj(sifra);
alter table prijatelj_brat add foreign key (prijatelj) references prijatelj(sifra);

alter table prijatelj_brat add foreign key (brat) references brat(sifra);
alter table punica add foreign key (snasa) references snasa(sifra);


#1. U tablice snasa, ostavljena i prijatelj_brat unesite po 3 retka.
select * from prijatelj;
describe prijatelj;
insert into prijatelj(sifra,indiferentno)values
(null, 1),
(null, 0),
(null, 0);

select * from brat;
describe brat;
insert into brat(sifra, ogrlica, ekstrovertno)values
(null, 3, 0),
(null, 6, 1),
(null, 2, 0);

select * from prijatelj_brat;
describe prijatelj_brat;
insert into prijatelj_brat(sifra, prijatelj, brat)values
(null, 1, 2),
(null, 2, 1),
(null, 3, 3);

select * from ostavljena;
describe ostavljena;
insert into ostavljena(sifra, modelnaocala)values
(null, 'Asaas'),
(null, 'Kdsaa'),
(null, 'sefefe');

select * from snasa;
describe snasa;
insert into snasa(sifra, kuna, eura, ostavljena)values
(null, 4555.99, 500.99, 1),
(null, 3233.99, 459.99, 2),
(null, 2555.99, 353.99, 3);

#2. U tablici svekar postavite svim zapisima kolonu suknja na
#vrijednost Osijek.

update svekar set suknja= 'Osijek';

#3. U tablici punica obrišite sve zapise čija je vrijednost kolone
#kratkamajica jednako AB.

delete from punica where kratkamajica='AB';

#4. Izlistajte majica iz tablice ostavljena uz uvjet da vrijednost kolone
#lipa nije 9,10,20,30 ili 35.

select majica from ostavljena where lipa !=9 and 10 and 20 and 30 and 35;

#5. Prikažite ekstroventno iz tablice brat, vesta iz tablice punica te
#kuna iz tablice snasa uz uvjet da su vrijednosti kolone lipa iz tablice
#ostavljena različito od 91 te da su vrijednosti kolone haljina iz tablice
#prijatelj sadrže niz znakova ba. Podatke posložite po kuna iz tablice
#snasa silazno.

select a.ekstrovertno, f.vesta, e.kuna
from brat a
inner join prijatelj_brat b on b.brat=a.sifra
inner join prijatelj c on b.prijatelj=c.sifra
inner join ostavljena d on d.prijatelj=c.sifra
inner join snasa e on e.ostavljena=d.sifra
inner join punica f on f.snasa=e.sifra
where d.lipa<>91 and c.haljina like '%ba%'
order by e.kuna desc;


#6. Prikažite kolone haljina i lipa iz tablice prijatelj čiji se primarni ključ
#ne nalaze u tablici prijatelj_brat.

select haljina, lipa
from prijatelj
where sifra not in(select distinct prijatelj from prijatelj_brat);