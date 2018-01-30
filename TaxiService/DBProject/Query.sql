--1
select *
from
    (select id, firstName, lastName, isActive, 'Drive' as role, registerDate
    from Driver
    Union
    select Passenger.id, firstName, lastName, isActive, 'Passenger' as role, registerDate
    from Passenger inner join CommunalPassenger on Passenger.id = CommunalPassenger.id
    Union
    select id, firstName, lastName, isActive, 'SupportAgent' as role, registerDate
    from SupportAgent
  ) as a
--2
select firstName, lastName, isAccessable, startTime
from
  (select Driver.firstName as firstName, Driver.lastName as lastName, 'Spinning' as isAccessable, date(SpinLocation.spinStartTime) as startTime
  from SpinLocation inner join Driver on SpinLocation.id = Driver.id
  where SpinLocation.originName = 'Hafez' and date(SpinLocation.spinStartTime) = current_date
  Union
  select Driver.firstName as firstName, Driver.lastName as lastName, 'Servicing' as isAccessable, date(CommunalJourney.startJourneyTime) as startTime
  from CommunalJourney inner join Driver on CommunalJourney.driverId = Driver.id
  where CommunalJourney.originName = 'Hafez' and date(CommunalJourney.startJourneyTime) = current_date
  Union
  select Driver.firstName as firstName, Driver.lastName as lastName, 'Servicing' as isAccessable, date(NonCommunalJourney.startJourneyTime) as startTime
  from NonCommunalJourney inner join Driver on NonCommunalJourney.driverId = Driver.id and date(NonCommunalJourney.startJourneyTime) = current_date
) as a
--3
select Driver.firstName, Driver.lastName, History.comment, History.rate  as AverageRate
from History inner join Driver on Driver.id = History.driverId
where Driver.id = 1
--4

--5
select firstName, lastName, originName, destinationName, cost, startTime, endTime
from(
      select Passenger.firstName as firstName, Passenger.lastName as lastName, NonCommunalJourney.originName as originName, NonCommunalJourney.destinationName as destinationName, NonCommunalJourney.cost as cost, NonCommunalJourney.startJourneyTime as startTime, null as endTime
      from NonCommunalPassenger inner join Passenger on Passenger.id = NonCommunalPassenger.id inner join NonCommunalJourney on NonCommunalPassenger.id = NonCommunalJourney.passengerId
      Union
      select Passenger.firstName as firstName, Passenger.lastName as lastName, NonCommunalJourneyLog.originName as originName, NonCommunalJourneyLog.destinationName as destinationName, NonCommunalJourneyLog.cost as cost, NonCommunalJourneyLog.startJourneyTime as startTime, NonCommunalJourneyLog.endJourneyTime as endTime
      from NonCommunalPassenger inner join Passenger on Passenger.id = NonCommunalPassenger.id inner join NonCommunalJourneyLog on NonCommunalPassenger.id = NonCommunalJourneyLog.passengerId
    ) as a
--6
select driverFirstName, driverLastName, passengerFirstName, passengerLastName, originName, destinationName
from(
    select Driver.firstName as driverFirstName, Driver.lastName as driverLastName, Passenger.firstName as passengerFirstName, Passenger.lastName as passengerLastName, CommunalJourney.originName as originName, CommunalJourney.destinationName as destinationName
    from
        Driver
        inner join CommunalJourney on Driver.id = CommunalJourney.driverId
        inner join CommunalPassenger on CommunalJourney.passengerId = CommunalPassenger.id
    	inner join passenger on CommunalPassenger.id = Passenger.id
    Union
    select Driver.firstName as driverFirstName, Driver.lastName as driverLastName, Passenger.firstName as passengerFirstName, Passenger.lastName as passengerLastName, NonCommunalJourney.originName as originName, NonCommunalJourney.destinationName as destinationName
    from
        Driver
        inner join NonCommunalJourney on Driver.id = NonCommunalJourney.driverId
        inner join NonCommunalPassenger on NonCommunalJourney.passengerId = NonCommunalPassenger.id
    	inner join passenger on NonCommunalPassenger.id = Passenger.id
  ) as a
--7
select sum(income) * 0.3 as income
from(
    select sum(cost) as income
    from CommunalJourneyLog
    where date(startJourneyTime) = current_date
    Union
    select sum(cost) as income
    from NonCommunalJourneyLog
    where date(startJourneyTime) = current_date
    ) as a
--8
select firstName, lastName
from Request inner join Passenger on Request.passengerId = Passenger.id
where Request.driverId = '2' and driverAccept = false and passengerAccept = true
--9
select firstName, lastName
from Request inner join Driver on Driver.id = Request.driverId
where Request.passengerId = '2' and passengerAccept = false and driverAccept = true
--10
select *
from(
    select id as ActionId, 'Pursuit' as role
    from pursuit
    where supportAgentId = '2'
    Union
    select id as ActionId, 'Grievance' as role
    from Grievance
    where supportAgentId = '2'
    Union
    select id as ActionId, 'ReckoningLog' as role
    from ReckoningLog
    where supportAgentId = '2'
    ) as a
--11
select SupportAgent.firstName, SupportAgent.lastName, Driver.firstName, Driver.lastName, DriverBankAccount.bankName, DriverBankAccount.bankAccount, Reason.id, Reason.reason, Reason.reasonTime, ReckoningLog.trackingCode
from
      ReckoningLog
      inner join DriverBankAccount on ReckoningLog.bankAccountId = DriverBankAccount.id
      inner join Driver on Driver.id = DriverBankAccount.driverId
      inner join SupportAgent on SupportAgent.id = ReckoningLog.supportAgentId
      inner join Reason on Reason.id = ReckoningLog.reasonId
--12
select *
from(
      select driverId as id, 'Driver' as role, columnName as changeColumn, oldValue, newValue, currentUpdateDate as changeTime
      from DriverLog where changer = current_user
      Union
      select passengerId as id, 'Passenger' as role, columnName as changeColumn, oldValue, newValue, currentUpdateDate as changeTime
      from PassangerLog where changer = current_user
      Union
      select supportAgentId as id, 'SupportAgent' as role, columnName as changeColumn, oldValue, newValue, currentUpdateDate as changeTime
      from SupportAgentLog where changer = current_user
    ) as a
--13
select SupportAgent.firstName, SupportAgent.lastName, Grievance.driverId, Grievance.passengerId, Grievance.description, Grievance.grievanceTime, Grievance.answerTime
from Grievance inner join SupportAgent on Grievance.supportAgentId = SupportAgent.id
