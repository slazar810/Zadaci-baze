drop database if exists vjezba_1;
create database vjezba_1 character set utf8;
use vjezba_1;

create table sestra_svekar(
    sifra int not null primary key auto_increment,
    sestra int not null,
    svekar int not null
);

create table svekar(
    sifra int not null primary key auto_increment,
    bojaociju varchar(40) not null,
    prstena int,
    dukserica varchar(41),
    lipa decimal(13,8),
    eura decimal(12,7),
    majica varchar(35)
);

create table sestra(
    sifra int not null primary key auto_increment,
    introvertno bit,
    haljina varchar(31) not null,
    maraka decimal(16,6),
    hlace varchar(46) not null,
    narukvica int not null
);

create table zena(
    sifra int not null primary key auto_increment,
    treciputa datetime,
    hlace varchar(46),
    kratkamajica varchar(31) not null,
    jmbag char(11) not null,
    bojaociju varchar(39) not null,
    haljina varchar(44),
    sestra int not null
);

create table muskarac(
    sifra int not null primary key auto_increment,
    bojaociju varchar(50) not null,
    hlace varchar(30),
    modelnaocala varchar(43),
    maraka decimal(14,5) not null,
    zena int not null
);

create table mladic(
    sifra int not null primary key auto_increment,
    suknja varchar(50) not null,
    kuna decimal(16,8) not null,
    drugiputa datetime,
    asocijalno bit,
    ekstrovertno bit not null,
    dukserica varchar(48) not null,
    muskarac int
);

create table punac(
    sifra int not null primary key auto_increment,
    ogrlica int,
    gustoca decimal(14,9),
    hlace varchar(41) not null
);

create table cura(
    sifra int not null primary key auto_increment,
    novcica decimal(16,5) not null,
    gustoca decimal(18,6) not null,
    lipa decimal(13,10),
    ogrlica int not null,
    bojakose varchar(38),
    suknja varchar(36),
    punac int
);


alter table sestra_svekar add foreign key (sestra) references sestra(sifra);
alter table sestra_svekar add foreign key (svekar) references svekar(sifra);

alter table zena add foreign key (sestra) references sestra(sifra);

alter table muskarac add foreign key (zena) references zena(sifra);

alter table mladic add foreign key (muskarac) references muskarac(sifra);

alter table cura add foreign key (punac) references punac(sifra);


select * from sestra;
describe sestra;
insert into sestra(sifra, introvertno, haljina, maraka, hlace, narukvica)values
(null, 0, 'Crvenaba', null, 'Crne', 3),
(null, 1, 'Plava', null, 'Sive', 2),
(null, 1, 'Zelena', null, 'Žute', 5);

select * from svekar;
describe svekar;
insert into svekar(sifra, bojaociju, prstena, dukserica, lipa, eura, majica)values
(null, 'Smeđa', 2, null, null, 2500.00, null),
(null, 'Plava', 5, 'Crna', null, 500.00, null),
(null, 'Zelena', 4, 'Siva', null, 750.00, 'Plava');

select * from sestra_svekar;

insert into sestra_svekar(sifra, sestra, svekar)values
(null, 1,1),
(null, 2,2),
(null, 3,3);

select * from zena;
describe zena;
insert into zena(sifra, treciputa, hlace, kratkamajica, jmbag, bojaociju, haljina, sestra)values
(null, null, 'Crne jeans', 'Plavana', 31899204771, 'Crna', 'Crvena', 1),
(null, null, 'Plavana peglu', 'Siva', 17356453539, 'Zelena', 'Žuta', 2),
(null, null, 'Arvena', 'Abež', 01763332606, 'Smeđa', 'Narandžasta', 3);

select * from muskarac;
describe muskarac;
insert into muskarac(sifra, bojaociju, hlace, modelnaocala, maraka, zena)values
(null, 'Siva', 'Jeans', null, 15000.00, 1),
(null, 'Zelene', null, 'Aviator', 1000.00, 2),
(null, 'Crne', null, null, 500.00, 3);

select * from punac;
describe punac;
insert into punac(sifra, ogrlica, gustoca, hlace)values
(null, 10, 15.77, 'Jeans'),
(null, 5, 15.77, 'Na crtu'),
(null, 3, 15.77, 'Pegla');

select * from cura;
describe cura;
insert into cura(sifra, novcica, gustoca, lipa, ogrlica, bojakose, suknja, punac)values
(null, 2752.00, 15.77, null, 7, null, null, 1),
(null, 3424.00, 15.77, null, 3, null, null, 2),
(null, 3435.03, 15.77, null, 5, null, null, 3);


delete from mladic where kuna > 15.78;

select kratkamajica from zena where hlace like '%ana%';

update

select c.hlace, d.haljina
from mladic a 
inner join muskarac b on a.muskarac=b.sifra
inner join zena c on b.zena=c.sifra
inner join sestra d on c.sestra=d.sifra
inner join sestra_svekar e on e.sestra=d.sifra
inner join svekar f on e.svekar=f.sifra
where c.hlace like 'a%'and d.haljina like '%ba%'
group by f.svekar desc;

select haljina, maraka
from sestra 
where sifra not in (select distinct sestra from sestra_svekar);