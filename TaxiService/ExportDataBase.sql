create table if not exists Drivers (
dId integer primary key auto_increment,
FirstName varchar (20) not null ,
LastName varchar (25) not null,
DateOfBirth date not null,
DateOfReg date not null,
DateOfExit date default null,
DateOfLicense Date not null,
Budget Double default 0,
Stats integer not null default 0,
isUser integer not null default 1
);

create table if not exists Drivers_Bank (
BId integer primary key auto_increment,
DId integer not null ,
BankName varchar(30),
AccountNumber varchar(60),
unique key (DId, BankName , AccountNumber),
foreign key (DId) references Drivers(dId)
);

create table if not exists Drivers_Phone (
DId integer  not null,
PhoneNumber varchar (30) ,
foreign key (DId) references  Drivers (DId)  ,
primary key (DId, PhoneNumber )
);

create table if not exists Drivers_Mobile (

DId integer not null,
Mobile varchar (30),
primary key (DId, Mobile),
foreign key (DId) references Drivers(DID)
);

create table if not exists  Drivers_OnCall (
Id integer primary key auto_increment,
DId integer not null,
SourceName varchar (20) not null,
SourceX Double not null,
SourceY Double not null,
DestName varchar (20) not null,
DestX Double not null ,
DestY Double not null,
Time TimeStamp not null,
foreign key (DId) references Drivers(DId)

);

create table if not exists  Passangers (
PId integer primary key auto_increment,
FirstName varchar (20) not null,
LastName varchar (20) not null

);


create table if not exists Reg_Passangers (
PId integer primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
UserName varchar(20) not null unique,
IsUser integer not null default 1,
DateOfReg TIMESTAMP not null default CURRENT_TIMESTAMP,
DateOfBirth Date not null ,
profilePic varchar (30) not null,
Credits Double not null default 0,
DateOfExit Date default null,
foreign key (PId) references Passangers(PId)
);
create table if not exists Reg_Passangers_Phone (
PId integer,
PhoneNumber varchar(20),
primary key (PId, PhoneNumber),
foreign key ( PId) references Reg_Passangers(PId)
);

create table  if not exists Reg_Passangers_Address (
PId integer,
Address varchar (100),
primary key (PId, Address),
foreign key ( PId) references Reg_Passangers(PId)
);
create table if not exists UnReg_Passangers (
PId integer unique,
FirstName varchar(20) ,
LastName varchar(20) ,
foreign key (PId) references Passangers(PId),
primary key (FirstName, LastName)
);
create table if not exists Supporters (
SId integer primary key auto_increment,
FirstName varchar(20) not null,
LastName varchar(20) not null ,
ProfilePic varchar(20) not null,
DateOfReg TIMESTAMP not null default CURRENT_TIMESTAMP,
IsOnline integer default 0
);
-- create table if not exists Supporters_OnlineTimes (
-- SId integer,
-- StartTime TIMESTAMP not null,
-- EndTime TIMESTAMP not null,
-- primary key ( SId, StartTime),
-- foreign key (SId) references Supporters(SId)
-- );


-- create table Requests (
-- RId integer primary key,
-- DId integer not null,
-- PId integer not null,
-- DriverAcc integer not null ,
-- PassangerAcc integer not null,
-- Time TimeStamp default NOW(),
-- foreign key (DId) references Drivers (dId),
-- foreign key (PId) references Passangers(PId)
-- )


create table  if not exists Trip (
TId integer primary key auto_increment,
PId integer not null,
DId integer not null,
Time TimeStamp default NOW(),
Amount Double not null,
Source varchar (100) not null,
Dest varchar(100) not null ,
DriverAcc integer,
PassangerAcc integer,
PaymentType integer,
CustomerType Integer not null,
IsFinished  integer not null default 0,
foreign key (PId ) references Passangers (PId),
foreign key (DId) references Drivers(dId)
);
create table if not exists Complaints (
TId integer primary key,
SId integer not null,
Complaint varchar(100) not null,
RecordDate TIMESTAMP not null,
HandlingDate TIMESTAMP  NULL,
foreign key (SId) references Supporters(SId),
foreign key (TId) references Trip(TId)
);
create table if not exists Reputations (
TId integer primary key,
DId integer not null,
Text varchar(100)  not null,
Point integer not null,
Time TIMESTAMP not null default CURRENT_TIMESTAMP,
foreign key (TId) references Trip (TId),
foreign key (DId) references Drivers(dId)
);


--  logs

-- DriversLog
create table  if not exists DriversLogs (
Id integer primary key auto_increment,
DId  integer not null ,
kind varchar(100) not null,
AttChange varchar (100) not null ,
oldValue varchar (100) null,
newValue varchar (100)  null,
Time TimeStamp default CURRENT_TIMESTAMP,
foreign key (DId) references Drivers(DId)
);


create table if not exists PassangersLog (
Id integer primary key auto_increment,
PId  integer ,
AttChange varchar (100) not null ,
oldValue varchar (100)  null,
newValue varchar (100)  null,
kind varchar(100) not null,
Time TIMESTAMP not null default CURRENT_TIMESTAMP,
foreign key (PId) references Passangers(PId)
);

-- create table if not exists BossLogs (
-- Id integer primary key ,
-- TypeOfObject
--
--
-- )

create table if not exists SupportersLogs(
Id integer primary key auto_increment,
SId integer not null,
AttChange varchar (100) not null ,
oldValue varchar (100)  null,
newValue varchar (100)  null,
kind varchar(100) not null,
Time TimeStamp not null default CURRENT_TIMESTAMP,
foreign key (SId) references Supporters(SId)
);



create table if not exists DriversRequests (
Id integer primary key  auto_increment,
BId integer not null,
DId integer not null,
Time TimeStamp not null,
foreign key (BId) references Drivers_Bank(BId),
foreign key (DId) references Drivers(DId)
);



create table if not exists Payments (
TrackingCode integer primary key,
SId integer not null,
DRId integer not null,
Reason varchar (100) not null,
Amount Double not null,
Time TIMESTAMP default CURRENT_TIMESTAMP,
foreign key (SId) references Supporters (SId),
foreign key (DRId ) references DriversRequests (Id)
);
create table if not exists TripLogs (
  Id integer primary key auto_increment,
  TId integer not null,
  AttChange varchar (100) not null,
  Kind varchar(100) not null ,
  oldValue varchar (100)  null,
  newValue varchar (100)  null,
  Time TIMESTAMP not null   default CURRENT_TIMESTAMP,
  foreign key ( TId) references Trip (TId)
);
