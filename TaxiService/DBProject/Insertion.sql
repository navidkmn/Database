insert into Driver (firstName,lastName,photo,birthDate,LicenceYear,isAccessable,isActive,registerDate)
	values
    ('Navid','Karami','navid.png',current_date,current_date,0,true,current_date),
    ('Reza','Jebeli','reza.png',current_date,current_date,0,true,current_date),
    ('Mohammad','Rezaei','Mohammad.png',current_date,current_date,0,true,current_date),
    ('Alireza','Heidari','Alireza.png',current_date,current_date,0,true,current_date);

insert into DriverMobileNumber (driverId,phoneNumber,lastUpdateDate)
  values
    (1,'09123456789',current_date),
    (1,'09123456780',current_date),
    (2,'09123456781',current_date),
    (3,'09123456749',current_date),
    (4,'09123454789',current_date);

insert into DriverBankAccount (driverId,bankName,bankAccount,lastUpdateDate)
  values
    (1,'Melli','1234567890123456',current_date),
    (2,'Sepah','123456546545654',current_date),
    (2,'Saderat','09876567843',current_date),
    (3,'Eghtesad','091234567491323',current_date),
    (4,'Sarmayeh','091234547893333',current_date);

insert into SpinLocation (id,originName,originLocation,destinationName,destinationLocation,spinStartTime)
	values
    (4,'Hafez','1234','vanak','12341',current_timestamp),
    (3,'tehranpars','1232','valiasr','1234',current_timestamp);

insert into passenger (firstName,lastName)
  values
    ('Mili','Rez'),
		('Sina','Mal'),
    ('Ahmad','Anvari'),
    ('Hossein','Hassare')
    ('Mehdi','Ostad');

insert into CommunalPassenger (id,photo,credit,isActive,registerDate)
  values
    (1,'mil.png',3000,true,current_timestamp),
  	(2,'Sina.png', 2350,true,current_timestamp),
    (3,'Ahmad.png',7600,true,current_timestamp);

insert into NonCommunalPassenger
  values
    (4),
    (5);

insert into SupportAgent (firstName,lastName,photo,isOnline,isActive)
  values
    ('me','you','me.png',true,true),
    ('we','he','we.png',true,true);

insert into Request (driverId,passengerId,originName,destinationName,driverAccept,passengerAccept,requestTime)
  values
    (1,1,'teh','tab',true,true,current_timestamp),
    (1,2,'teh','tab',true,false,current_timestamp),
    (2,1,'teh','tab',false,true,current_timestamp),
    (2,3,'teh','tab',true,true,current_timestamp),
    (1,3,'teh','tab',true,true,current_timestamp),
    (3,5,'teh','tab',true,true,current_timestamp,
    (2,4,'teh','tab',true,true,current_timestamp);

insert into History (driverId,passengerId,comment,rate,historyTime)
  values
    (1,3,'Best',20,current_timestamp),
    (1,1.'Bad',2,current_timestamp),
    (2,4,'Normal',13,current_timestamp),
    (3,5,'Good',17,current_timestamp);

insert into CommunalJourney (driverId,passengerId,originName,destinationName,cost,payType,startJourneyTime)
  values
    (1,2,'Hafez','uni',100,'online',current_timestamp),
    (2,3,'teh','uni',200,'credit',current_timestamp);

insert into NonCommunalJourney (driverId,passengerId,originName,destinationName,cost,startJourneyTime)
  values
    (2,4,'Hafez','uni',200,current_timestamp),
    (3,5,'teh','uni',700,current_timestamp);

insert into Grievance (driverId,passengerId,supportAgentId,description,grievanceTime,answerTime)
  values
    (1,2,1,'tond mire',current_timestamp,current_timestamp),
    (2,5,2,'gerun migire',current_timestamp,current_timestamp);

insert into pursuit (driverId,passengerId,supportAgentId,pursuitResult,pursuitTime,answerTime)
  values
    (1,2,1,'tond mire',current_timestamp,current_timestamp),
    (2,5,2,'gerun migire',current_timestamp,current_timestamp);

insert into reason (reason,reasonTime)
  values
    ('pool nadaram',current_timestamp),
    ('bacham marize'.current_timestamp);

insert into ReckoningLog (bankAccount,supportAgentId,reasonId,cost,trackingCode,reckoningTime)
  values
    (2,3,1,300,'12345678',current_timestamp),
    (4,1,2,456,'2345',current_timestamp),
    (2,1,1,12,'4567876543',current_timestamp);
