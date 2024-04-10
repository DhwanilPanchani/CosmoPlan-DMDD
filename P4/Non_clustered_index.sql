CREATE INDEX idx_Astronaut_LastName ON Astronaut(LastName);
CREATE INDEX idx_Astronaut_Nationality ON Astronaut(Nationality);

CREATE INDEX idx_Mission_MissionName ON Mission(MissionName);
CREATE INDEX idx_Mission_MissionStatus ON Mission(MissionStatus);
CREATE INDEX idx_Mission_Destination ON Mission(Destination);

CREATE INDEX idx_Agency_AgencyName ON Agency(AgencyName);
CREATE INDEX idx_Agency_Country ON Agency(Country);
