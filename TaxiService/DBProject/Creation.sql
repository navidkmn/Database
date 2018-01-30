create table Driver (
  id serial primary key,
  firstName varchar(20) not null,
  lastName varchar(20) not null,
  photo varchar(100) not null,
  birthDate date not null,
  LicenceYear date not null,
  isAccessable int not null check (isAccessable between 0 and 2), --  0 : offline , 1 : online , 2 : servising
  account real default 0,
  isActive boolean not null, -- false : acount deleted
  registerDate timestamp not null,
  deleteDate timestamp,
  lastUpdateDate timestamp
);

create table DriverMobileNumber(
  id serial primary key,
  driverId int not null,
  phoneNumber varchar(11) not null,
  lastUpdateDate timestamp,
  foreign key (driverId) references Driver(id) on update cascade
);

create table DriverHomeNumber(
    id serial primary key,
    driverId int not null,
    phoneNumber varchar(11) not null,
    lastUpdateDate timestamp,
    foreign key (driverId) references Driver(id) on update cascade
);

create table DriverBankAccount(
  id serial primary key,
  driverId int not null,
  bankName varchar(10) not null,
  bankAccount varchar(16) not null,
  lastUpdateDate timestamp,
  foreign key (driverId) references Driver(id) on update cascade
);

create table SpinLocation (
  id int primary key,
  originName varchar(10) not null,
  originLocation varchar(100) not null,
  destinationName varchar(10) not null,
  destinationLocation varchar(100) not null,
  spinStartTime timestamp,
  foreign key (id) references Driver(id) on update cascade
);

create table Passenger(
  id serial primary key,
  firstName varchar (10) not null,
  lastName varchar (10) not null
);

create table CommunalPassenger(
  id int primary key,
  photo varchar(100) not null,
  credit real not null,
  isActive boolean not null, -- false : deleted account
  registerDate timestamp not null,
  deleteDate timestamp,
  lastUpdateDate timestamp not null,
  foreign key (id) references Passenger(id) on update cascade
);

create table NonCommunalPassenger(
  id int primary key,
  foreign key (id) references Passenger(id) on update cascade
);

create table CommunalPassengerMoblieNumber(
  id serial primary key,
  passengerId int not null,
  phoneNumber varchar(11) not null,
  lastUpdateDate timestamp,
  foreign key (passengerId) references CommunalPassenger(id) on update cascade
);

create table CommunalPassengerHomeNumber(
  id serial primary key,
  passengerId int not null,
  phoneNumber varchar(11) not null,
  lastUpdateDate timestamp,
  foreign key (passengerId) references CommunalPassenger(id) on update cascade
);

create table CommunalPassengerAddress(
  id serial primary key,
  passengerId int not null,
  city varchar(10) not null,
  street varchar(10) not null,
  alley varchar(10) not null,
  plate int not null,
  lastUpdateDate timestamp,
  foreign key (passengerId) references CommunalPassenger(id) on update cascade
);

create table SupportAgent(
  id serial primary key,
  firstName varchar(10) not null,
  lastName varchar(10) not null,
  photo varchar(100) not null,
  isOnline boolean not null,
  isActive boolean not null, -- false : deleted account
  registerDate timestamp,
  lastUpdateDate timestamp
);

create table Request(
  id serial primary key,
  driverId int not null,
  passengerId int not null,
  originName varchar(10),
  destinationName varchar(10),
  driverAccept boolean not null,
  passengerAccept boolean not null,
  requestTime timestamp not null,
  foreign key (driverId) references Driver(id) on update cascade,
  foreign key (passengerId) references Passenger(id) on update cascade
);

create table History(
  id serial primary key,
  driverId int not null,
  passengerId int not null,
  comment varchar(100),
  rate int check (rate between 0 and 20),
  historyTime timestamp,
  foreign key (driverId) references Driver(id) on update cascade,
  foreign key (passengerId) references Passenger(id) on update cascade
);

  create table CommunalJourney(
  id serial primary key,
  driverId int not null,
  passengerId int not null,
  originName varchar(10) not null,
  destinationName varchar(10) not null,
  cost real not null,
  payType varchar(20) not null check (payType in ('online','credit')),
  startJourneyTime timestamp not null,
  foreign key (driverId) references Driver(id) on update cascade,
  foreign key (passengerId) references CommunalPassenger(id) on update cascade
);

create table NonCommunalJourney(
  id serial primary key,
  driverId int not null,
  passengerId int not null,
  originName varchar(10) not null,
  destinationName varchar(10) not null,
  cost real not null,
  startJourneyTime timestamp not null,
  foreign key (driverId) references Driver(id) on update cascade,
  foreign key (passengerId) references NonCommunalPassenger(id) on update cascade
);

create table Grievance(
  id serial primary key,
  driverId int,
  passengerId int,
  supportAgentId int,
  description varchar(200) not null,
  grievanceTime timestamp not null,
  answerTime timestamp null,
  foreign key (driverId) references Driver(id) on update cascade,
  foreign key (passengerId) references Passenger(id) on update cascade,
  foreign key (supportAgentId) references SupportAgent(id) on update cascade
);

create table Pursuit(
  id serial primary key,
  driverId int,
  passengerId int,
  supportAgentId int,
  pursuitResult varchar(100),
    pursuitTime timestamp not null,
  answerTime timestamp not null,
  foreign key (driverId) references Driver(id) on update cascade,
  foreign key (passengerId) references Passenger(id) on update cascade,
  foreign key (supportAgentId) references SupportAgent(id) on update cascade
);

create table DriverIncomeLog(
  id serial primary key,
  driverId int,
  cost real not null,
  incomeTime timestamp not null,
  foreign key (driverId) references Driver(id) on update cascade
);

create table Reason(
  id serial primary key,
  reason varchar(100),
  reasonTime timestamp
);

create table ReckoningLog(
  id serial primary key,
  bankAccountId int,
  supportAgentId int,
  reasonId int,
  cost real not null,
  trackingCode varchar(12) not null,
  reckoningTime timestamp not null,
  foreign key (bankAccountId) references DriverBankAccount(id) on delete cascade on update cascade,
  foreign key (supportAgentId) references SupportAgent(id) on update cascade,
  foreign key (reasonId) references Reason(id) on delete cascade on update cascade
);

create table DriverLog(
  id serial primary key,
  driverId int,
  columnName text,
  oldValue text,
  newValue text,
  changer text,
  currentUpdateDate timestamp
);

create table PassangerLog(
  id serial primary key,
  passengerId int,
  columnName text,
  oldValue text,
  newValue text,
  changer text,
  currentUpdateDate timestamp
);

create table SupportAgentLog(
  id serial primary key,
  supportAgentId int,
  columnName text,
  oldValue text,
  newValue text,
  changer text,
  currentUpdateDate timestamp
);

create table SpinLocationLog(
  id serial primary key,
  driverId int,
  originName varchar(10),
  originLocation varchar(100),
  destinationName varchar(10),
  destinationLocation varchar(100),
  spinStartTime timestamp,
  spinEndTime timestamp
);

create table CommunalJourneyLog(
  id serial primary key,
  driverId int,
  passengerId int,
  originName varchar(10),
  destinationName varchar(10),
  cost real not null,
  payType varchar(20),
  startJourneyTime timestamp,
  endJourneyTime timestamp
);

create table NonCommunalJourneyLog(
  id serial primary key,
  driverId int,
  passengerId int,
  originName varchar(10),
  destinationName varchar(10),
  cost real,
  startJourneyTime timestamp,
  endJourneyTime timestamp
);
