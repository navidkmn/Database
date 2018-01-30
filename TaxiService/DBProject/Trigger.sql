create or replace function driverUpdate()
returns trigger as $BODY$
begin
      if(old.firstName <> new.firstname) then
          insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
          values (old.id,'FirstName' :: text, old.firstname :: text,new.firstname :: text,current_user,current_timestamp);
      end if;
      if(old.lastname <> new.lastname) then
          insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
          values (old.id,'LastName' :: text, old.lastname :: text,new.lastname :: text,current_user,current_timestamp);
      end if;
      if(old.photo <> new.photo) then
          insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
          values (old.id,'Photo' :: text, old.photo :: text,new.photo :: text,current_user,current_timestamp);
      end if;
      if(old.birthDate <> new.birthDate) then
          insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
          values (old.id,'BirthDay' :: text, old.birthday :: text,new.birthday :: text,current_user,current_timestamp);
      end if;
      if(old.LicenceYear <> new.LicenceYear) then
          insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
          values (old.id,'LicenceYear' :: text, old.LicenceYear :: text,new.LicenceYear :: text,current_user,current_timestamp);
      end if;
      if(old.isAccessable <> new.isAccessable) then
          insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
          values (old.id,'IsAccessable' :: text, old.isAccessable :: text,new.isAccessable :: text,current_user,current_timestamp);
      end if;
      if(old.isAccessable = 1 and old.isAccessable <> new.isAccessable) then
          delete from spinLocation where id = old.id;
      end if;
      if(old.account <> new.account) then
          insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
          values (old.id,'Account' :: text, old.account :: text,new.account :: text,current_user,current_timestamp);
      end if;
      if(old.isActive <> new.isActive) then
          insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
          values (old.id,'IsActive' :: text, old.isActive :: text,new.isActive :: text,current_user,current_timestamp);
          new.deleteDate := current_timestamp;
      end if;
      new.lastUpdateDate := current_timestamp;
      return new;
end;
$BODY$ language plpgsql;

create trigger driverUpdate after update on Driver
for each row
execute procedure driverUpdate();
----------------------------------------------------------
create or replace function driverMobileUpdate()
returns trigger as $BODY$
begin
    if(old.phoneNumber <> new.phoneNumber) then
        insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'PhoneNumber' :: text, old.phoneNumber :: text,new.phoneNumber :: text,current_user,current_timestamp);
    end if;
    new.lastUpdateDate := current_timestamp;
    return new;
end;
$BODY$ language plpgsql;

create trigger driverMobileUpdate after update on DriverMobileNumber
for each row
execute procedure driverMobileUpdate();
----------------------------------------------------------
create or replace function driverHomeUpdate()
returns trigger as $BODY$
begin
    if(old.phoneNumber <> new.phoneNumber) then
        insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'HomeNumber' :: text, old.phoneNumber :: text,new.phoneNumber :: text,current_user,current_timestamp);
    end if;
    new.lastUpdateDate := current_timestamp;
    return new;
end;
$BODY$ language plpgsql;

create trigger driverHomeUpdate after update on DriverHomeNumber
for each row
execute procedure driverHomeUpdate();
------------------------------------------------------------
create or replace function DriverBankAccountUpdate()
returns trigger as $BODY$
begin
    if(old.bankName <> new.bankName) then
        insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'BankName' :: text, old.bankName :: text,new.bankName :: text,current_user,current_timestamp);
    end if;
    if(old.bankAccount <> new.bankAccount) then
        insert into DriverLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'BankAccount' :: text, old.bankAccount :: text,new.bankAccount :: text,current_user,current_timestamp);
    end if;
    new.lastUpdateDate := current_timestamp;
    return new;
end;
$BODY$ language plpgsql;

create trigger DriverBankAccountUpdate after update on DriverBankAccount
for each row
execute procedure DriverBankAccountUpdate();
------------------------------------------------------------
create or replace function PassengerUpdate()
returns trigger as $BODY$
begin
	if(old.id in (select id from CommunalPassenger)) then
        if(old.firstName <> new.firstName) then
            insert into PassangerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
            values (old.id,'FirstName' :: text, old.firstName :: text,new.firstName :: text,current_user,current_timestamp);
        end if;
        if(old.lastName <> new.lastName) then
            insert into PassangerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
            values (old.id,'LastName' :: text, old.bankAccount :: text,new.bankAccount :: text,current_user,current_timestamp);
        end if;
        new.lastUpdateDate := current_timestamp;
        return new;
    else
    	return old;
   	end if;
end;
$BODY$ language plpgsql;

create trigger PassengerUpdate after update on Passenger
for each row
execute procedure PassengerUpdate();
------------------------------------------------------------
create or replace function CommunalPassengerUpdate()
returns trigger as $BODY$
begin
	  if(old.isActive = true) then
          if(old.photo <> new.photo) then
              insert into PassangerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
              values (old.id,'Photo' :: text, old.photo :: text,new.photo :: text,current_user,current_timestamp);
          end if;
          if(old.credit <> new.credit) then
              insert into PassangerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
              values (old.id,'Credit' :: text, old.credit :: text,new.credit :: text,current_user,current_timestamp);
          end if;
           if(old.isActive <> new.isActive) then
              insert into PassangerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
              values (old.id,'IsActive' :: text, old.isActive :: text,new.isActive :: text,current_user,current_timestamp);
              new.deleteDate := current_timestamp;
          end if;
          new.lastUpdateDate := current_timestamp;
          return new;
      else
      	return old;
      end if;
end;
$BODY$ language plpgsql;

create trigger CommunalPassengerUpdate after update on CommunalPassenger
for each row
execute procedure CommunalPassengerUpdate();
-------------------------------------------------------------
create or replace function CommunalPassengerHomeNumberUpdate()
returns trigger as $BODY$
begin
    if(old.phoneNumber <> new.phoneNumber) then
        insert into PassangerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'PhoneNumber' :: text, old.phoneNumber :: text,new.phoneNumber :: text,current_user,current_timestamp);
    end if;
    new.lastUpdateDate := current_timestamp;
    return new;
end;
$BODY$ language plpgsql;

create trigger CommunalPassengerHomeNumberUpdate after update on CommunalPassengerHomeNumber
for each row
execute procedure CommunalPassengerHomeNumberUpdate();
--------------------------------------------------------------
create or replace function CommunalPassengerMoblieNumberUpdate()
returns trigger as $BODY$
begin
    if(old.phoneNumber <> new.phoneNumber) then
        insert into PassengerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'PhoneNumber' :: text, old.phoneNumber :: text,new.phoneNumber :: text,current_user,current_timestamp);
    end if;
    new.lastUpdateDate := current_timestamp;
    return new;
end;
$BODY$ language plpgsql;

create trigger CommunalPassengerMoblieNumberUpdate after update on CommunalPassengerMoblieNumber
for each row
execute procedure CommunalPassengerMoblieNumberUpdate();
-------------------------------------------------------------
create or replace function CommunalPassengerAddressUpdate()
returns trigger as $BODY$
begin
    if(old.city <> new.city) then
        insert into PassengerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'City' :: text, old.city :: text,new.city :: text,current_user,current_timestamp);
    end if;
    if(old.street <> new.street) then
        insert into PassengerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'Street' :: text, old.street :: text,new.street :: text,current_user,current_timestamp);
    end if;
    if(old.alley <> new.alley) then
        insert into PassengerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'Alley' :: text, old.alley :: text,new.alley :: text,current_user,current_timestamp);
    end if;
    if(old.plate <> new.plate) then
        insert into PassengerLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
        values (old.id,'Plate' :: text, old.plate :: text,new.plate :: text,current_user,current_timestamp);
    end if;

    new.lastUpdateDate := current_timestamp;
    return new;
end;
$BODY$ language plpgsql;

create trigger CommunalPassengerAddressUpdate after update on CommunalPassengerAddress
for each row
execute procedure CommunalPassengerAddressUpdate();
--------------------------------------------------------------
create or replace function supportAgentUpdate()
returns trigger as $BODY$
begin
	  if(old.isActive = true) then
          if(old.firstname <> new.firstname) then
              insert into SupportAgentLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
              values (old.id,'FirstName' :: text, old.firstname :: text,new.firstname :: text,current_user,current_timestamp);
          end if;
          if(old.lastname <> new.lastname) then
              insert into SupportAgentLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
              values (old.id,'LastName' :: text, old.lastname :: text,new.lastname :: text,current_user,current_timestamp);
          end if;
          if(old.photo <> new.photo) then
              insert into SupportAgentLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
              values (old.id,'Photo' :: text, old.photo :: text,new.photo :: text,current_user,current_timestamp);
          end if;
          if(old.isOnline <> new.isOnline) then
              insert into SupportAgentLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
              values (old.id,'IsOnline' :: text, old.isOnline :: text,new.isOnline :: text,current_user,current_timestamp);
          end if;
          if(old.isActive <> new.isActive) then
              insert into SupportAgentLog (driverId,columnName,oldValue,newValue,changer,currentUpdateDate)
              values (old.id,'IsActive' :: text, old.isActive :: text,new.isActive :: text,current_user,current_timestamp);
              new.deleteDate := current_timestamp;
          end if;
          new.lastUpdateDate := current_timestamp;
          return new;
      else
      	  return new;
      end if;
end;
$BODY$ language plpgsql;

create trigger supportAgentUpdate after update on SupportAgent
for each row
execute procedure supportAgentUpdate();
--------------------------------------------------------
create or replace function spinLocationDelete()
returns trigger as $BODY$
begin
	insert into SpinLocationLog (driverId,originName,originLocation,destinationName,destinationLocation,spinStartTime,spinEndTime)
    values(old.Id,old.originName,old.originLocation,old.destinationName,old.destinationLocation,old.spinStartTime,current_timestamp);
    return old;
end;
$BODY$ language plpgsql;

create trigger spinLocationDelete after delete on SpinLocation
for each row
execute procedure spinLocationDelete();
--------------------------------------------------------
create or replace function communalJourneyDelete()
returns trigger as $BODY$
begin
	insert into CommunalJourneyLog (driverId,passengerId,originName,destinationName,cost,payType,spinStartTime,spinEndTime)
    values(old.driverId,old.passengerId,old.originName,old.destinationName,old.cost,old.payType,old.spinStartTime,current_timestamp);
  insert into DriverIncomeLog (driverId,cost,incomeTime)
    values(old.driverId,old.cost,current_timestamp);
  update Driver set account = account + old.cost where Driver.id = old.driverId;
  update CommunalPassenger set credit = credit - old.cost where old.passengerId = CommunalPassenger.id and old.payType = 'credit';
    return old;
end;
$BODY$ language plpgsql;

create trigger communalJourneyDelete before delete on CommunalJourney
for each row
execute procedure communalJourneyDelete();
--------------------------------------------------------
create or replace function nonCommunalJourneyDelete()
returns trigger as $BODY$
begin
	insert into NonCommunalJourneyLog (driverId,passengerId,originName,destinationName,cost,spinStartTime,spinEndTime)
    values(old.driverId,old.passengerId,old.originName,old.destinationName,old.cost,old.spinStartTime,current_timestamp);
  insert into DriverIncomeLog (driverId,cost,incomeTime)
    values(old.driverId,old.cost,current_timestamp);
  update Driver set account = account + old.cost where Driver.id = old.driverId;
    return old;
end;
$BODY$ language plpgsql;

create trigger nonCommunalJourneyDelete before delete on NonCommunalJourney
for each row
execute procedure nonCommunalJourneyDelete();
--------------------------------------------------------
create or replace function ReckoningLogInsert()
returns trigger as $BODY$
begin
	update Driver set Driver.amount = 0
  where Driver.id = (select BankAccount.driverId
                       from ReckoningLog inner join DriverBankAccount on ReckoningLog.bankAccountId inner join Driver on DriverBankAccount.driverId = Driver.id
                       where new.bankAccountId = DriverBankAccount.id);
  return new;
end;
$BODY$ language plpgsql;

create trigger ReckoningLogInsert after insert on ReckoningLog
for each row
execute procedure ReckoningLogInsert();
--------------------------------------------------------
