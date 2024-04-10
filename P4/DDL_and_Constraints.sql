CREATE DATABASE CosmoPlan;
USE CosmoPlan;

CREATE TABLE Mission (
    MissionID VARCHAR(255) PRIMARY KEY,
    MissionName VARCHAR(255) NOT NULL,
    MissionStartDate DATE NOT NULL,
    Duration INT CHECK (Duration > 0), -- Duration must be positive.
    MissionStatus VARCHAR(255) NOT NULL CHECK (MissionStatus IN ('Planned', 'Active', 'Completed', 'Cancelled')),
    Destination VARCHAR(255) NOT NULL,
    MissionBudget DECIMAL(19,4) NOT NULL CHECK (MissionBudget >= 0)
);


CREATE TABLE Agency (
    AgencyID VARCHAR(255) PRIMARY KEY,
    AgencyName VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL CHECK (Country <> ''),
    Director VARCHAR(255),
    AgencyBudget DECIMAL(19,4) NOT NULL CHECK (AgencyBudget >= 0)
);



CREATE TABLE Astronaut (
    AstronautID INT PRIMARY KEY,
    CallSign VARCHAR(255) NOT NULL UNIQUE,
    FirstName VARCHAR(255) NOT NULL CHECK (FirstName <> ''),
    LastName VARCHAR(255) NOT NULL CHECK (LastName <> ''),
    DateOfBirth DATE NOT NULL,
    Nationality VARCHAR(255) ,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F', 'O')), -- 'O' stands for Other
    Specialty VARCHAR(255) NOT NULL CHECK (Specialty <> '')
);


CREATE TABLE Spacecraft (
    CraftID INT PRIMARY KEY,
    CraftName VARCHAR(255) NOT NULL,
    SpacecraftType VARCHAR(255) NOT NULL,
    PayloadCapacity DECIMAL(19,4) CHECK (PayloadCapacity >= 0),
    SpacecraftStatus VARCHAR(255) NOT NULL CHECK (SpacecraftStatus IN ('Operational', 'Maintenance', 'Decommissioned', 'In Transit', 'Docked', 'Reserved')),
    MissionID VARCHAR(255),
    FOREIGN KEY (MissionID) REFERENCES Mission(MissionID) ON DELETE CASCADE -- Assuming that spacecraft may or may not be assigned to a mission.
);

CREATE TABLE Activity (
    ActivityID INT PRIMARY KEY,
    ActivityType VARCHAR(255) NOT NULL CHECK (ActivityType <> ''),
    StartDate DATE NOT NULL,
    Duration INT NOT NULL CHECK (Duration > 0),
    CraftID INT,
    FOREIGN KEY (CraftID) REFERENCES Spacecraft(CraftID) ON DELETE CASCADE
);

CREATE TABLE LaunchVehicle (
    VehicleID INT PRIMARY KEY,
    VehicleName VARCHAR(255) NOT NULL CHECK (VehicleName <> ''),
    VehicleType VARCHAR(255) NOT NULL CHECK (VehicleType <> ''),
    PayloadCapacity DECIMAL(19,4) NOT NULL CHECK (PayloadCapacity > 0),
    Manufacturer VARCHAR(255) CHECK (Manufacturer <> ''),
    MissionID VARCHAR(255),
    FOREIGN KEY (MissionID) REFERENCES Mission(MissionID) ON DELETE CASCADE
);


CREATE TABLE Objective (
    ObjectiveID INT PRIMARY KEY,
    ObjectiveDescription VARCHAR(1024) NOT NULL CHECK (ObjectiveDescription <> '')
);


CREATE TABLE LaunchSite (
    SiteID INT PRIMARY KEY,
    SiteName VARCHAR(255) NOT NULL CHECK (SiteName <> ''),
    Location VARCHAR(255) NOT NULL CHECK (Location <> ''),
    LaunchCapacity INT NOT NULL CHECK (LaunchCapacity > 0)
);


CREATE TABLE Fuel (
    FuelID INT PRIMARY KEY,
    FuelType VARCHAR(255) NOT NULL CHECK (FuelType <> ''),
    FuelDescription VARCHAR(1024)
);


CREATE TABLE CommunicationSystem (
    CommunicationSystemID INT PRIMARY KEY,
    SystemName VARCHAR(255) NOT NULL CHECK (SystemName <> ''),
    SystemType VARCHAR(255) NOT NULL CHECK (SystemType <> '')
);


CREATE TABLE ScientificInstrument (
    InstrumentID INT PRIMARY KEY,
    InstrumentName VARCHAR(255) NOT NULL CHECK (InstrumentName <> ''),
    InstrumentType VARCHAR(255) NOT NULL CHECK (InstrumentType <> '')
);


CREATE TABLE Payload (
    PayloadID INT PRIMARY KEY,
    PayloadName VARCHAR(255) NOT NULL CHECK (PayloadName <> ''),
    PayloadType VARCHAR(255) NOT NULL CHECK (PayloadType <> ''),
    Weight DECIMAL(19,4) NOT NULL CHECK (Weight > 0)
);

-------------------------------------Associative Entity Tables-------------------------------------------------------

CREATE TABLE MissionAgencyAssignment (
    MissionID VARCHAR(255) NOT NULL,
    AgencyID VARCHAR(255) NOT NULL,
    AssignmentDate DATE NOT NULL,
    PRIMARY KEY (MissionID, AgencyID),
    FOREIGN KEY (MissionID) REFERENCES Mission(MissionID) ON DELETE CASCADE,
    FOREIGN KEY (AgencyID) REFERENCES Agency(AgencyID) ON DELETE CASCADE
);



CREATE TABLE MissionAstronautsAssignment (
    MissionID VARCHAR(255) NOT NULL,
    AstronautID INT NOT NULL,
    AssignmentDate DATE NOT NULL,
    Role VARCHAR(255) NOT NULL,
    PRIMARY KEY (MissionID, AstronautID),
    FOREIGN KEY (MissionID) REFERENCES Mission(MissionID) ON DELETE CASCADE,
    FOREIGN KEY (AstronautID) REFERENCES Astronaut(AstronautID) ON DELETE CASCADE
);



CREATE TABLE MissionObjective (
    MissionID VARCHAR(255) NOT NULL,
    ObjectiveID INT NOT NULL,
    PRIMARY KEY (MissionID, ObjectiveID),
    FOREIGN KEY (MissionID) REFERENCES Mission(MissionID) ON DELETE CASCADE,
    FOREIGN KEY (ObjectiveID) REFERENCES Objective(ObjectiveID) ON DELETE CASCADE
);


CREATE TABLE MissionCommunications (
    MissionID VARCHAR(255) NOT NULL,
    CommunicationSystemID INT NOT NULL,
    PRIMARY KEY (MissionID, CommunicationSystemID),
    FOREIGN KEY (MissionID) REFERENCES Mission(MissionID) ON DELETE CASCADE,
    FOREIGN KEY (CommunicationSystemID) REFERENCES CommunicationSystem(CommunicationSystemID) ON DELETE CASCADE
);



CREATE TABLE MissionLaunch (
    MissionID VARCHAR(255) NOT NULL,
    SiteID INT NOT NULL,
    LaunchDate DATE NOT NULL,
    PRIMARY KEY (MissionID, SiteID),
    FOREIGN KEY (MissionID) REFERENCES Mission(MissionID) ON DELETE CASCADE,
    FOREIGN KEY (SiteID) REFERENCES LaunchSite(SiteID) ON DELETE CASCADE
);



CREATE TABLE VehicleFuelConsumption (
    VehicleID INT NOT NULL,
    FuelID INT NOT NULL,
    Amount DECIMAL(19,4) NOT NULL CHECK (Amount > 0),
    PRIMARY KEY (VehicleID, FuelID),
    FOREIGN KEY (VehicleID) REFERENCES LaunchVehicle(VehicleID) ON DELETE CASCADE,
    FOREIGN KEY (FuelID) REFERENCES Fuel(FuelID) ON DELETE CASCADE
);



CREATE TABLE InstrumentAssignment (
    MissionID VARCHAR(255) NOT NULL,
    InstrumentID INT NOT NULL,
    AssignmentDate DATE NOT NULL,
    PRIMARY KEY (MissionID, InstrumentID),
    FOREIGN KEY (MissionID) REFERENCES Mission(MissionID) ON DELETE CASCADE,
    FOREIGN KEY (InstrumentID) REFERENCES ScientificInstrument(InstrumentID) ON DELETE CASCADE
);

CREATE TABLE PayloadPurpose (
    MissionID VARCHAR(255) NOT NULL,
    PayloadID INT NOT NULL,
    Purpose VARCHAR(255) NOT NULL CHECK (Purpose <> ''),
    PRIMARY KEY (MissionID, PayloadID),
    FOREIGN KEY (MissionID) REFERENCES Mission(MissionID) ON DELETE CASCADE,
    FOREIGN KEY (PayloadID) REFERENCES Payload(PayloadID) ON DELETE CASCADE
);


-- Alter Tables to add Date


--Alter statements to input date in associative entity-------------------------------------------------------------------------------

ALTER TABLE MissionAgencyAssignment
ADD MissionAgencyAssignmentDate DATE;

ALTER TABLE MissionAgencyAssignment  DROP COLUMN AssignmentDate 

ALTER TABLE MissionAstronautsAssignment
ADD MissionAstronautsAssignmentDate DATE;

ALTER TABLE MissionAstronautsAssignment  DROP COLUMN AssignmentDate 

ALTER TABLE MissionObjective
ADD ObjectiveAssignmentDate DATE;


ALTER TABLE MissionCommunications
ADD CommunicationSetupDate DATE;

ALTER TABLE MissionLaunch
ADD MLDate DATE;


ALTER TABLE VehicleFuelConsumption
ADD FuelUsageDate DATE;


ALTER TABLE InstrumentAssignment
ADD InstrumentSetupDate DATE;

ALTER TABLE InstrumentAssignment DROP COLUMN AssignmentDate


ALTER TABLE PayloadPurpose
ADD PurposeAssignmentDate DATE;

---- 




SELECT * FROM Mission;
SELECT * FROM Agency;
SELECT * FROM Astronaut;
SELECT * FROM Spacecraft;
SELECT * FROM LaunchVehicle;
SELECT * FROM Objective;
SELECT * FROM LaunchSite;
SELECT * FROM Fuel;
SELECT * FROM CommunicationSystem;
SELECT * FROM ScientificInstrument;
SELECT * FROM Payload;
SELECT * FROM MissionAgencyAssignment;
SELECT * FROM MissionAstronautsAssignment;
SELECT * FROM MissionObjective;
SELECT * FROM MissionCommunications;
SELECT * FROM MissionLaunch;
SELECT * FROM VehicleFuelConsumption;
SELECT * FROM InstrumentAssignment;
SELECT * FROM PayloadPurpose;

-- DELETE FROM Mission WHERE MissionID = 'M101';

-- DROP TABLE PayloadPurpose;
-- DROP TABLE InstrumentAssignment;
-- DROP TABLE VehicleFuelConsumption;
-- DROP TABLE MissionLaunch;
-- DROP TABLE MissionCommunications;
-- DROP TABLE MissionObjective;
-- DROP TABLE MissionAstronautsAssignment;
-- DROP TABLE MissionAgencyAssignment;
-- DROP TABLE Payload;
-- DROP TABLE ScientificInstrument;
-- DROP TABLE CommunicationSystem;
-- DROP TABLE Fuel;
-- DROP TABLE LaunchSite;
-- DROP TABLE Objective;
-- DROP TABLE LaunchVehicle;
-- DROP TABLE Spacecraft;
-- DROP TABLE Astronaut;
-- DROP TABLE Agency;
-- DROP TABLE Mission;

