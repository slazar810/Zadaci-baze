drop database if exists vjezba_2;
create database vjezba_2 character set utf8;
use vjezba_2;

create table brat(
    sifra int not null primary key auto_increment,
    suknja varchar(47),
    ogrlica int not null,
    asocijalno bit not null,
    neprijatelj int not null
);

create table neprijatelj (
    sifra int not null primary key auto_increment,
    majica varchar(32),
    haljina varchar(43) not null,
    lipa decimal(16,8),
    modelnaocala varchar(49) not null,
    kuna decimal(12,6) not null,
    jmbag char(11),
    cura int
);

create table cura(
    sifra int not null primary key auto_increment,
    haljina varchar(33) not null,
    drugiputa datetime not null,
    suknja varchar(38),
    narukvica int,
    introvertno bit,
    majica varchar(40) not null,
    decko int
);

create table decko(
    sifra int not null primary key auto_increment,
    indiferentno bit,
    vesta varchar(34),
    asocijalno bit not null
);

create table decko_zarucnica(
    sifra int not null primary key auto_increment,
    decko int not null,
    zarucnica int not null
);

create table zarucnica(
    sifra int not null primary key auto_increment,
    narukvica int,
    bojakose varchar(37) not null,
    novcica decimal(15,9),
    lipa decimal(15,8) not null,
    indiferentno bit not null
);

create table prijatelj(
    sifra int not null primary key auto_increment,
    modelnaocala varchar(37),
    treciputa datetime not null,
    ekstrovertno bit not null,
    prviputa datetime,
    svekar int not null
);

create table svekar(
    sifra int not null primary key auto_increment,
    stilifrizura varchar(48),
    ogrlica int not null,
    asocijalno bit not null
);


alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);
alter table neprijatelj add foreign key (cura) references cura(sifra);

alter table cura add foreign key (decko) references decko(sifra);

alter table decko_zarucnica add foreign key (decko) references decko(sifra);

alter table decko_zarucnica add foreign key (zarucnica) references zarucnica(sifra);

alter table prijatelj add foreign key (svekar) references svekar(sifra);


select * from neprijatelj;
describe neprijatelj;
insert into neprijatelj(sifra, majica, haljina, lipa, modelnaocala, kuna, jmbag, cura)values
(null, null, 'Crvena', null, 'Reyban', 5482.44, null, null),
(null, null, 'Plava', null, 'Aviator', 45487.55, null, null),
(null, null, 'Crna', null, 'Pepeljare', 54848.33, null, null);

select * from cura;
describe cura;
insert into cura(sifra, haljina, drugiputa, suknja, narukvica, introvertno, majica, decko)values
(null, 'Zelena', '1988-11-20', null, null, null, 'Siva', null),
(null, 'Žuta', '1982-04-10', null, null, null, 'Ljubičasta', null),
(null, 'Narandžasta', '1990-03-03', null, null, null, 'Bordo', null);

select * from decko;
describe decko;
insert into decko(sifra, indiferentno, vesta, asocijalno)values
(null, null, 'Taraba', 1),
(null, null, 'Crvaba', 0),
(null, null, 'Crna', 0);

select * from zarucnica;
describe zarucnica;
insert into zarucnica(sifra, narukvica, bojakose, novcica, lipa, indiferentno)values
(null, null, 'Plava', 147.77, 54888.77, 0),
(null, null, 'Smeđa', 4588.00, 54545.83, 1),
(null, null, 'Crna', 880.00, 4752.59, 1);

select * from decko_zarucnica;
describe decko_zarucnica;
insert into decko_zarucnica(sifra, decko, zarucnica)values
(null, 1, 3),
(null, 2, 1),
(null, 3, 2);

select * from brat;
describe brat;
insert into brat(sifra, suknja, ogrlica, asocijalno, neprijatelj)values
(null, null, 10, 1, 2),
(null, null, 13, 0, 1),
(null, null, 14, 0, 3);

select * from svekar;
describe svekar;
insert into svekar(sifra, stilifrizura, ogrlica, asocijalno)values
(null, null, 14, 1),
(null, null, 5, 0),
(null, null, 7, 1);

select * from prijatelj;
describe prijatelj;
insert into prijatelj(sifra, modelnaocala, treciputa, ekstrovertno, prviputa, svekar)values
(null, null, '2020-04-30', 0, null, 3),
(null, null, '2020-04-30', 0, null, 1),
(null, null, '2020-04-30', 1, null, 2);

delete from brat where ogrlica !=14;

select suknja from cura where drugiputa is null;

select f.novcica, a.neprijatelj, b.haljina
from brat a
inner join neprijatelj b on a.neprijatelj=b.sifra
inner join cura c on b.cura=c.sifra
inner join decko d on c.decko=d.sifra
inner join decko_zarucnica e on e.decko=d.sifra
inner join zarucnica f on e.zarucnica=f.sifra
where c.drugiputa is not null and d.vesta like '%ba%'
group by b.haljina desc;


select vesta, asocijalno from decko
where sifra not in( select distinct decko from decko_zarucnica);