


-----------------------------------------------------------------INSERT STATEMENTS----------------------------------------------


INSERT INTO Mission (MissionID, MissionName, MissionStartDate, Duration, MissionStatus, Destination, MissionBudget) VALUES
('M101', 'Lunar Habitation Expansion', '2025-07-22', 180, 'Planned', 'Moon', 150000000.0000),
('M102', 'Mars Sample Return', '2026-09-05', 540, 'Planned', 'Mars', 250000000.0000),
('M103', 'Asteroid Belt Survey', '2027-03-15', 365, 'Planned', 'Asteroid Belt', 175000000.0000),
('M104', 'Jupiter Atmospheric Probe', '2028-05-20', 800, 'Planned', 'Jupiter', 300000000.0000),
('M105', 'Venus Surface Study', '2024-11-30', 120, 'Active', 'Venus', 180000000.0000),
('M106', 'Mercury Mapping Mission', '2025-01-14', 90, 'Completed', 'Mercury', 90000000.0000),
('M107', 'Deep Space Observatory', '2029-07-02', 1000, 'Planned', 'Deep Space', 500000000.0000),
('M108', 'Lunar South Pole Water Survey', '2024-12-18', 60, 'Active', 'Moon', 120000000.0000),
('M109', 'Solar Flare Monitoring Satellite', '2023-08-09', 730, 'Completed', 'Sun-Earth L1 Point', 70000000.0000),
('M110', 'International Space Station Resupply', '2024-06-21', 30, 'Active', 'Low Earth Orbit', 50000000.0000),
('M111', 'Saturn Ring Particles Collection', '2030-04-17', 900, 'Planned', 'Saturn', 320000000.0000),
('M112', 'Neptune Orbiter', '2031-10-13', 1100, 'Planned', 'Neptune', 450000000.0000),
('M113', 'Alpha Centauri Probe', '2040-09-29', 15000, 'Planned', 'Alpha Centauri', 1000000000.0000),
('M114', 'Lunar Base Construction Phase 1', '2025-02-20', 180, 'Active', 'Moon', 200000000.0000),
('M115', 'Global Satellite Internet Constellation Deployment', '2024-04-01', 365, 'Active', 'Low Earth Orbit', 800000000.0000),
('M116', 'Titan Lakes Explorer', '2032-12-07', 950, 'Planned', 'Titan', 350000000.0000),
('M117', 'Comet Intercept Mission', '2026-06-18', 200, 'Planned', 'Comet 67P', 100000000.0000),
('M118', 'Space Junk Cleanup Initiative', '2025-10-26', 365, 'Active', 'Low Earth Orbit', 150000000.0000),
('M119', 'Pluto Flyby', '2033-01-19', 1200, 'Planned', 'Pluto', 400000000.0000),
('M120', 'Lagrange Point 2 Observatory', '2027-08-14', 730, 'Planned', 'Sun-Earth L2 Point', 220000000.0000);





INSERT INTO Agency (AgencyID, AgencyName, Country, Director, AgencyBudget) VALUES
('AG01', 'SpaceX', 'USA', 'Elon Musk', 1000000000.00),
('AG02', 'NASA', 'USA', 'Bill Nelson', 22000000000.00),
('AG03', 'ESA', 'European Union', 'Josef Aschbacher', 7000000000.00),
('AG04', 'Roscosmos', 'Russia', 'Yuri Borisov', 3000000000.00),
('AG05', 'CNSA', 'China', 'Zhang Kejian', 11000000000.00),
('AG06', 'ISRO', 'India', 'K. Sivan', 1400000000.00),
('AG07', 'JAXA', 'Japan', 'Hiroshi Yamakawa', 2000000000.00),
('AG08', 'SpaceX Starlink', 'USA', 'Elon Musk', 10000000000.00),
('AG09', 'Blue Origin', 'USA', 'Jeff Bezos', 5000000000.00),
('AG10', 'Virgin Galactic', 'USA', 'Richard Branson', 900000000.00),
('AG11', 'Rocket Lab', 'New Zealand', 'Peter Beck', 500000000.00),
('AG12', 'Canadian Space Agency', 'Canada', 'Lisa Campbell', 400000000.00),
('AG13', 'UK Space Agency', 'United Kingdom', 'Graham Turnock', 500000000.00),
('AG14', 'Arianespace', 'France', 'Stéphane Israël', 600000000.00),
('AG15', 'Northrop Grumman', 'USA', 'Kathy Warden', 4000000000.00),
('AG16', 'Boeing Defense, Space & Security', 'USA', 'Leanne Caret', 23000000000.00),
('AG17', 'Lockheed Martin Space', 'USA', 'James Taiclet', 15000000000.00),
('AG18', 'Space Forces', 'USA', 'John W. Raymond', 15000000000.00),
('AG19', 'SKY Perfect JSAT Corporation', 'Japan', 'Eiichi Yonekura', 200000000.00),
('AG20', 'Telesat', 'Canada', 'Dan Goldberg', 1000000000.00);


INSERT INTO Astronaut (AstronautID, CallSign, FirstName, LastName, DateOfBirth, Nationality, Gender, Specialty) VALUES
(1, 'Hawk', 'Jane', 'Doe', '1980-05-15', 'USA', 'F', 'Engineer'),
(2, 'Eagle', 'John', 'Smith', '1978-04-20', 'Canada', 'M', 'Pilot'),
(3, 'Comet', 'Alice', 'Johnson', '1985-02-11', 'UK', 'F', 'Scientist'),
(4, 'Nova', 'Bob', 'Williams', '1982-08-30', 'USA', 'M', 'Engineer'),
(5, 'Orion', 'Chris', 'Brown', '1976-03-15', 'Australia', 'M', 'Pilot'),
(6, 'Meteor', 'Diana', 'Wilson', '1988-07-22', 'USA', 'F', 'Medic'),
(7, 'Voyager', 'Evan', 'Davis', '1990-11-02', 'Canada', 'M', 'Scientist'),
(8, 'Pulsar', 'Fiona', 'Martinez', '1983-12-14', 'Spain', 'F', 'Engineer'),
(9, 'Quasar', 'George', 'Hernandez', '1979-09-05', 'Mexico', 'M', 'Pilot'),
(10, 'Stardust', 'Hannah', 'Lee', '1984-06-18', 'Korea', 'F', 'Scientist'),
(11, 'Galaxy', 'Ian', 'Kim', '1974-01-29', 'USA', 'M', 'Engineer'),
(12, 'Cosmos', 'Julia', 'Chang', '1986-10-03', 'China', 'F', 'Medic'),
(13, 'Nebula', 'Kyle', 'Moore', '1987-04-17', 'Russia', 'M', 'Scientist'),
(14, 'Zenith', 'Laura', 'Garcia', '1981-07-26', 'Spain', 'F', 'Engineer'),
(15, 'Aurora', 'Mike', 'Taylor', '1975-05-09', 'UK', 'M', 'Pilot'),
(16, 'Solaris', 'Nina', 'Robinson', '1991-02-21', 'Germany', 'F', 'Scientist'),
(17, 'Lunar', 'Oscar', 'Martinez', '1989-12-31', 'USA', 'M', 'Engineer'),
(18, 'Photon', 'Patty', 'White', '1978-11-14', 'France', 'F', 'Medic'),
(19, 'Starlight', 'Quinn', 'Thompson', '1983-03-07', 'Australia', 'O', 'Pilot'),
(20, 'Eclipse', 'Rachel', 'Anderson', '1977-08-25', 'New Zealand', 'F', 'Scientist');




INSERT INTO Spacecraft (CraftID, CraftName, SpacecraftType, PayloadCapacity, SpacecraftStatus, MissionID) VALUES
(1, 'Voyager III', 'Explorer', 500.0000, 'Operational', 'M101'),
(2, 'Lunar Lander I', 'Lander', 2000.0000, 'Maintenance', 'M102'),
(3, 'Mars Rover Alpha', 'Rover', 900.0000, 'Operational', 'M103'),
(4, 'Jupiter Observer', 'Orbiter', 700.0000, 'Operational', 'M104'),
(5, 'Europa Submersible', 'Submersible', 350.0000, 'In Transit', NULL),
(6, 'Saturn Ring Collector', 'Collector', 500.0000, 'Operational', 'M105'),
(7, 'Deep Space One', 'Explorer', 800.0000, 'Operational', 'M106'),
(8, 'Orion Capsule', 'Crewed', 2500.0000, 'Docked', 'M107'),
(9, 'Starlight Cruiser', 'Cruiser', 4000.0000, 'Operational', 'M108'),
(10, 'Neptune Probe', 'Probe', 100.0000, 'Operational', 'M109'),
(11, 'Venus Climate Orbiter', 'Orbiter', 600.0000, 'Operational', 'M110'),
(12, 'Mercury Messenger II', 'Messenger', 200.0000, 'Reserved', NULL),
(13, 'Lunar Gateway', 'Station', 5000.0000, 'In Transit', 'M111'),
(14, 'Asteroid Defender', 'Defender', 1500.0000, 'Operational', 'M112'),
(15, 'Solar Sail Scout', 'Scout', 50.0000, 'Decommissioned', NULL),
(16, 'Cosmic Lab', 'Laboratory', 2500.0000, 'Operational', 'M113'),
(17, 'Pluto Flyby Craft', 'Flyby', 300.0000, 'Operational', 'M114'),
(18, 'Alpha Centauri Express', 'Explorer', 1000.0000, 'Operational', 'M115'), -- Corrected 'Planned' to 'Operational'
(19, 'Lunar Resource Extractor', 'Extractor', 2200.0000, 'Operational', 'M116'),
(20, 'Interstellar Observatory', 'Observatory', 750.0000, 'Operational', 'M117');


INSERT INTO Activity (ActivityID, ActivityType, StartDate, Duration, CraftID) VALUES
(1, 'Orbital Maneuvers', '2025-07-23', 2, 1),
(2, 'Scientific Experiments', '2025-08-01', 30, 2),
(3, 'Observation Runs', '2025-08-15', 45, 3),
(4, 'Data Transmission', '2025-09-05', 1, 4),
(5, 'Maintenance Operations', '2025-10-10', 5, 5),
(6, 'Rover Deployment', '2025-11-01', 7, 6),
(7, 'Sample Collection', '2025-11-20', 10, 7),
(8, 'Docking Procedures', '2025-12-01', 1, 8),
(9, 'Habitat Setup', '2026-01-15', 20, 9),
(10, 'Resource Extraction', '2026-02-10', 15, 10),
(11, 'Spacewalks (EVA)', '2026-03-07', 3, 11),
(12, 'Reconnaissance', '2026-04-02', 30, 12),
(13, 'Refueling Operations', '2026-05-18', 2, 13),
(14, 'Satellite Deployment', '2026-06-09', 1, 14),
(15, 'Astronomical Studies', '2026-07-14', 60, 15),
(16, 'Technology Testing', '2026-08-20', 30, 16),
(17, 'Resupply Missions', '2026-09-05', 3, 17),
(18, 'Life Support Checks', '2026-10-01', 5, 18),
(19, 'Navigation Tests', '2026-10-25', 7, 19),
(20, 'Space Debris Cleanup', '2026-11-15', 10, 20);






INSERT INTO LaunchVehicle (VehicleID, VehicleName, VehicleType, PayloadCapacity, Manufacturer, MissionID) VALUES
(1, 'Falcon Heavy X1', 'Heavy Lift', 64000.0000, 'SpaceX', 'M101'),
(2, 'Atlas V', 'Medium Lift', 20000.0000, 'ULA', 'M102'),
(3, 'SLS Block 1', 'Super Heavy Lift', 95000.0000, 'NASA', 'M103'),
(4, 'Starship Mars', 'Super Heavy Lift', 100000.0000, 'SpaceX', 'M104'),
(5, 'New Glenn', 'Heavy Lift', 45000.0000, 'Blue Origin', NULL),
(6, 'Delta IV Heavy', 'Heavy Lift', 28700.0000, 'ULA', 'M105'),
(7, 'Ariane 6', 'Medium Lift', 21500.0000, 'Arianespace', 'M106'),
(8, 'Electron', 'Small Lift', 300.0000, 'Rocket Lab', 'M107'),
(9, 'Soyuz 2', 'Medium Lift', 8200.0000, 'Roscosmos', 'M108'),
(10, 'Long March 5', 'Heavy Lift', 25000.0000, 'CNSA', 'M109'),
(11, 'Vega C', 'Small Lift', 1500.0000, 'Arianespace', 'M110'),
(12, 'Falcon 9', 'Medium Lift', 22800.0000, 'SpaceX', NULL),
(13, 'Titan IVB', 'Heavy Lift', 21700.0000, 'Lockheed Martin', 'M111'),
(14, 'Proton-M', 'Heavy Lift', 23000.0000, 'Roscosmos', 'M112'),
(15, 'H-IIA', 'Medium Lift', 15000.0000, 'JAXA', NULL),
(16, 'Antares 230+', 'Medium Lift', 8200.0000, 'Northrop Grumman', 'M113'),
(17, 'Space Launch System (SLS) Block 2', 'Super Heavy Lift', 130000.0000, 'NASA', 'M114'),
(18, 'Starship Lunar', 'Super Heavy Lift', 100000.0000, 'SpaceX', 'M115'),
(19, 'Terran 1', 'Small Lift', 1250.0000, 'Relativity Space', 'M116'),
(20, 'New Shepard', 'Suborbital', 100.0000, 'Blue Origin', NULL);




INSERT INTO Objective (ObjectiveID, ObjectiveDescription) VALUES
(1, 'Conduct lunar surface mapping to identify potential landing sites.'),
(2, 'Collect and return samples from the Mars surface.'),
(3, 'Survey the asteroid belt for potential mining opportunities.'),
(4, 'Study the atmospheric composition of Jupiter.'),
(5, 'Deploy a network of satellites for global high-speed internet.'),
(6, 'Search for signs of past or present life on Mars.'),
(7, 'Measure solar wind and cosmic rays in the outer solar system.'),
(8, 'Observe galactic phenomena from the far side of the Moon.'),
(9, 'Test new space habitation technologies in low Earth orbit.'),
(10, 'Demonstrate new propulsion technologies for deep space travel.'),
(11, 'Capture high-resolution images of Saturn’s rings.'),
(12, 'Conduct a detailed survey of Venus’ atmosphere.'),
(13, 'Map the surface of Mercury.'),
(14, 'Deploy satellites to monitor Earth’s climate.'),
(15, 'Conduct zero-gravity manufacturing experiments.'),
(16, 'Study the effect of space travel on human physiology.'),
(17, 'Collect samples from an asteroid.'),
(18, 'Study the Van Allen radiation belts.'),
(19, 'Test autonomous navigation systems for spacecraft.'),
(20, 'Investigate the ice geysers of Enceladus.');



INSERT INTO LaunchSite (SiteID, SiteName, Location, LaunchCapacity) VALUES
(1, 'Cape Canaveral', 'Florida, USA', 40),
(2, 'Vandenberg Air Force Base', 'California, USA', 20),
(3, 'Baikonur Cosmodrome', 'Kazakhstan', 30),
(4, 'European Spaceport', 'French Guiana', 25),
(5, 'Plesetsk Cosmodrome', 'Russia', 15),
(6, 'Satish Dhawan Space Centre', 'India', 20),
(7, 'Jiuquan Satellite Launch Center', 'China', 22),
(8, 'Taiyuan Satellite Launch Center', 'China', 18),
(9, 'Tanegashima Space Center', 'Japan', 24),
(10, 'Kennedy Space Center', 'Florida, USA', 35),
(11, 'Wallops Flight Facility', 'Virginia, USA', 12),
(12, 'Rocket Lab Launch Complex 1', 'New Zealand', 20),
(13, 'Guiana Space Centre', 'French Guiana', 28),
(14, 'Sohae Satellite Launching Station', 'North Korea', 5),
(15, 'Naro Space Center', 'South Korea', 8),
(16, 'Vostochny Cosmodrome', 'Russia', 10),
(17, 'Spaceport America', 'New Mexico, USA', 15),
(18, 'Mahia Launch Range', 'New Zealand', 25),
(19, 'Kourou', 'French Guiana', 30),
(20, 'Pacific Spaceport Complex', 'Alaska, USA', 10);




INSERT INTO Fuel (FuelID, FuelType, FuelDescription) VALUES
(1, 'Liquid Hydrogen', 'High efficiency, low temperature liquid fuel.'),
(2, 'RP-1', 'Refined kerosene used in rocket fuel.'),
(3, 'Hydrazine', 'Used for satellite and spacecraft maneuvering.'),
(4, 'Solid', 'Solid rocket boosters for initial launch thrust.'),
(5, 'Xenon', 'Used in ion propulsion systems.'),
(6, 'Methane', 'Can be synthesized on Mars for return missions.'),
(7, 'Liquid Oxygen', 'Oxidizer for liquid rocket fuels.'),
(8, 'Nitrogen Tetroxide', 'Oxidizer for hydrazine-based fuels.'),
(9, 'Liquid Helium', 'Coolant for deep space missions.'),
(10, 'Argon', 'Used in ion propulsion systems.'),
(11, 'Krypton', 'Alternative to xenon in ion propulsion.'),
(12, 'LOX/RP-1', 'Common combination for many first stage rockets.'),
(13, 'LOX/Liquid Hydrogen', 'High-efficiency upper stage fuel.'),
(14, 'LOX/Methane', 'Emerging technology with applications for Mars.'),
(15, 'Hydroxyl-terminated polybutadiene (HTPB)', 'Solid rocket propellant.'),
(16, 'Aerozine 50', 'A mixture of hydrazine and UDMH, used in some upper stages.'),
(17, 'Unsymmetrical Dimethylhydrazine (UDMH)', 'Used with nitrogen tetroxide as an oxidizer.'),
(18, 'Monomethylhydrazine (MMH)', 'Used for satellite thrusters.'),
(19, 'Perchlorate Ammonium', 'Common oxidizer in solid rocket fuels.'),
(20, 'Aluminum Powder', 'Fuel additive for solid rockets, increases thrust.');






INSERT INTO CommunicationSystem (CommunicationSystemID, SystemName, SystemType) VALUES
(1, 'Deep Space Network', 'Radio'),
(2, 'Satellite Relay', 'Satellite'),
(3, 'Quantum Communicator', 'Quantum'),
(4, 'Lunar Comms Array', 'Radio'),
(5, 'Mars Orbiter Relay', 'Satellite'),
(6, 'Interstellar Beacon', 'Beacon'),
(7, 'Planetary Internet', 'Internet'),
(8, 'Solar Probe Link', 'Radio'),
(9, 'Asteroid Network', 'Satellite'),
(10, 'Jovian Listener', 'Radio'),
(11, 'Neptunian Signal Relay', 'Satellite'),
(12, 'Plutonian Outreach', 'Radio'),
(13, 'Galactic Positioning System', 'GPS'),
(14, 'Venusian Atmosphere Network', 'Satellite'),
(15, 'Mercurial Surface Comms', 'Radio'),
(16, 'Saturn Ring Communicator', 'Satellite'),
(17, 'Uranian Deep Space Link', 'Radio'),
(18, 'Cosmic Microwave Background Communicator', 'Quantum'),
(19, 'Exoplanet Data Relay', 'Satellite'),
(20, 'Lagrangian Point Signal Booster', 'Radio');







INSERT INTO ScientificInstrument (InstrumentID, InstrumentName, InstrumentType) VALUES
(1, 'Spectrometer', 'Analysis'),
(2, 'LIDAR', 'Mapping'),
(3, 'Alpha Particle X-ray Spectrometer', 'Analysis'),
(4, 'Magnetometer', 'Measurement'),
(5, 'ChemCam', 'Analysis'),
(6, 'Radar Imager', 'Imaging'),
(7, 'Thermal Emission Imaging System', 'Imaging'),
(8, 'Gamma Ray Spectrometer', 'Analysis'),
(9, 'Neutron Spectrometer', 'Analysis'),
(10, 'High Resolution Camera', 'Imaging'),
(11, 'Infrared Spectrometer', 'Analysis'),
(12, 'Seismometer', 'Measurement'),
(13, 'Gravimeter', 'Measurement'),
(14, 'Particle Detector', 'Measurement'),
(15, 'Cosmic Dust Analyzer', 'Analysis'),
(16, 'Solar Wind Particle Analyzer', 'Analysis'),
(17, 'Atmospheric Sensor', 'Measurement'),
(18, 'Soil Composition Analyzer', 'Analysis'),
(19, 'Radiation Assessment Detector', 'Measurement'),
(20, 'Microscopic Imager', 'Imaging');




INSERT INTO Payload (PayloadID, PayloadName, PayloadType, Weight) VALUES
(1, 'Mars Habitat Module', 'Habitation', 2000.0000),
(2, 'Lunar Rover', 'Rover', 300.0000),
(3, 'Asteroid Mining Drill', 'Mining Equipment', 1500.0000),
(4, 'Jupiter Atmospheric Probe', 'Probe', 500.0000),
(5, 'Satellite Constellation', 'Satellite', 100.0000),
(6, 'Space Telescope', 'Telescope', 800.0000),
(7, 'Solar Sail', 'Propulsion', 50.0000),
(8, 'Orbital Debris Cleaner', 'Cleaner', 600.0000),
(9, 'Planetary Defense Weapon', 'Defense', 4000.0000),
(10, 'Quantum Communication Satellite', 'Satellite', 200.0000),
(11, 'Deep Space Habitat', 'Habitation', 2500.0000),
(12, 'Lunar Greenhouse', 'Agriculture', 1000.0000),
(13, 'Mars Water Extractor', 'Extractor', 1200.0000),
(14, 'Venus Weather Balloon', 'Balloon', 100.0000),
(15, 'Asteroid Redirect Rocket', 'Propulsion', 3000.0000),
(16, 'Interstellar Probe', 'Probe', 700.0000),
(17, 'Neptune Submersible', 'Submersible', 1500.0000),
(18, 'Galactic Mapping Satellite', 'Satellite', 250.0000),
(19, 'Alien Life Research Lab', 'Laboratory', 1800.0000),
(20, 'Zero-Gravity Manufacturing Module', 'Manufacturing', 2200.0000);




-----------------------------------------------------------------INSERT STATEMENTS(Associative Entities)----------------------------------------------


-- Inserting sample data into MissionAgencyAssignment
INSERT INTO MissionAgencyAssignment (MissionID, AgencyID, MissionAgencyAssignmentDate) VALUES
('M101', 'AG01', '2023-01-01'),
('M102', 'AG02', '2023-02-01'),
('M103', 'AG03', '2023-03-01'),
('M104', 'AG04', '2023-04-01'),
('M105', 'AG05', '2023-05-01'),
('M106', 'AG01', '2023-06-01'),
('M107', 'AG02', '2023-07-01'),
('M108', 'AG03', '2023-08-01'),
('M109', 'AG04', '2023-09-01'),
('M110', 'AG05', '2023-10-01'),
('M111', 'AG01', '2023-11-01'),
('M112', 'AG02', '2023-12-01'),
('M113', 'AG03', '2024-01-01'),
('M114', 'AG04', '2024-02-01'),
('M115', 'AG05', '2024-03-01'),
('M116', 'AG01', '2024-04-01'),
('M117', 'AG02', '2024-05-01'),
('M118', 'AG03', '2024-06-01'),
('M119', 'AG04', '2024-07-01'),
('M120', 'AG05', '2024-08-01');



-- Inserting sample data into MissionAstronautsAssignment
INSERT INTO MissionAstronautsAssignment (MissionID, AstronautID, MissionAstronautsAssignmentDate, Role) VALUES
('M101', 1, '2023-01-02', 'Commander'),
('M101', 2, '2023-01-03', 'Scientist'),
('M102', 3, '2023-02-02', 'Engineer'),
('M102', 4, '2023-02-03', 'Pilot'),
('M103', 5, '2023-03-02', 'Commander'),
('M103', 6, '2023-03-03', 'Scientist'),
('M104', 7, '2023-04-02', 'Engineer'),
('M104', 8, '2023-04-03', 'Pilot'),
('M105', 9, '2023-05-02', 'Commander'),
('M105', 10, '2023-05-03', 'Scientist'),
('M106', 11, '2023-06-02', 'Engineer'),
('M106', 12, '2023-06-03', 'Pilot'),
('M107', 13, '2023-07-02', 'Commander'),
('M107', 14, '2023-07-03', 'Scientist'),
('M108', 15, '2023-08-02', 'Engineer'),
('M108', 16, '2023-08-03', 'Pilot'),
('M109', 17, '2023-09-02', 'Commander'),
('M109', 18, '2023-09-03', 'Scientist'),
('M110', 19, '2023-10-02', 'Engineer'),
('M110', 20, '2023-10-03', 'Pilot');


INSERT INTO MissionObjective (MissionID, ObjectiveID, ObjectiveAssignmentDate) VALUES
('M101', 1, '2023-01-01'),
('M101', 2, '2023-01-02'),
('M102', 3, '2023-02-01'),
('M102', 4, '2023-02-02'),
('M103', 5, '2023-03-01'),
('M103', 6, '2023-03-02'),
('M104', 7, '2023-04-01'),
('M104', 8, '2023-04-02'),
('M105', 9, '2023-05-01'),
('M105', 10, '2023-05-02'),
('M106', 11, '2023-06-01'),
('M106', 12, '2023-06-02'),
('M107', 13, '2023-07-01'),
('M107', 14, '2023-07-02'),
('M108', 15, '2023-08-01'),
('M108', 16, '2023-08-02'),
('M109', 17, '2023-09-01'),
('M109', 18, '2023-09-02'),
('M110', 19, '2023-10-01'),
('M110', 20, '2023-10-02');



INSERT INTO MissionCommunications (MissionID, CommunicationSystemID, CommunicationSetupDate) VALUES
('M101', 1, '2023-01-10'),
('M101', 2, '2023-01-11'),
('M102', 3, '2023-02-10'),
('M102', 4, '2023-02-11'),
('M103', 5, '2023-03-10'),
('M103', 6, '2023-03-11'),
('M104', 7, '2023-04-10'),
('M104', 8, '2023-04-11'),
('M105', 9, '2023-05-10'),
('M105', 10, '2023-05-11'),
('M106', 11, '2023-06-10'),
('M106', 12, '2023-06-11'),
('M107', 13, '2023-07-10'),
('M107', 14, '2023-07-11'),
('M108', 15, '2023-08-10'),
('M108', 16, '2023-08-11'),
('M109', 17, '2023-09-10'),
('M109', 18, '2023-09-11'),
('M110', 19, '2023-10-10'),
('M110', 20, '2023-10-11');



INSERT INTO MissionLaunch (MissionID, SiteID, LaunchDate, MLDate) VALUES
('M101', 1, '2023-01-01', '2023-01-05'),
('M102', 2, '2023-02-01', '2023-02-05'),
('M103', 3, '2023-03-01', '2023-03-05'),
('M104', 4, '2023-04-01', '2023-04-05'),
('M105', 5, '2023-05-01', '2023-05-05'),
('M106', 6, '2023-06-01', '2023-06-05'),
('M107', 7, '2023-07-01', '2023-07-05'),
('M108', 8, '2023-08-01', '2023-08-05'),
('M109', 9, '2023-09-01', '2023-09-05'),
('M110', 10, '2023-10-01', '2023-10-05'),
('M111', 11, '2023-11-01', '2023-11-05'),
('M112', 12, '2023-12-01', '2023-12-05'),
('M113', 13, '2024-01-01', '2024-01-05'),
('M114', 14, '2024-02-01', '2024-02-05'),
('M115', 15, '2024-03-01', '2024-03-05'),
('M116', 16, '2024-04-01', '2024-04-05'),
('M117', 17, '2024-05-01', '2024-05-05'),
('M118', 18, '2024-06-01', '2024-06-05'),
('M119', 19, '2024-07-01', '2024-07-05'),
('M120', 20, '2024-08-01', '2024-08-05');





INSERT INTO VehicleFuelConsumption (VehicleID, FuelID, Amount, FuelUsageDate) VALUES
(1, 1, 10000.0000, '2023-01-01'),
(1, 2, 15000.0000, '2023-01-02'),
(2, 1, 20000.0000, '2023-02-01'),
(2, 3, 12000.0000, '2023-02-02'),
(3, 2, 18000.0000, '2023-03-01'),
(3, 4, 20000.0000, '2023-03-02'),
(4, 1, 16000.0000, '2023-04-01'),
(4, 3, 14000.0000, '2023-04-02'),
(5, 2, 22000.0000, '2023-05-01'),
(5, 4, 21000.0000, '2023-05-02'),
(6, 1, 23000.0000, '2023-06-01'),
(6, 3, 24000.0000, '2023-06-02'),
(7, 2, 25000.0000, '2023-07-01'),
(7, 4, 26000.0000, '2023-07-02'),
(8, 1, 27000.0000, '2023-08-01'),
(8, 3, 28000.0000, '2023-08-02'),
(9, 2, 29000.0000, '2023-09-01'),
(9, 4, 30000.0000, '2023-09-02'),
(10, 1, 31000.0000, '2023-10-01'),
(10, 3, 32000.0000, '2023-10-02');

INSERT INTO InstrumentAssignment (MissionID, InstrumentID, InstrumentSetupDate) VALUES 
 ('M101', 1, '2024-01-01'),
 ('M102', 2, '2024-01-05'),
  ('M103', 3, '2024-02-01'),
  ('M104', 4, '2024-02-05'),
  ('M105', 5, '2024-03-01'),
  ('M106', 6, '2024-03-05'),
  ('M107', 7, '2024-04-01'),
  ('M108', 8, '2024-04-05'),
  ('M109', 9, '2024-05-01'),
  ('M110', 10, '2024-05-05'),
  ('M111', 11, '2024-06-01'),
  ('M112', 12, '2024-06-05'),
  ('M113', 13, '2024-07-01'),
  ('M114', 14, '2024-07-05'),
  ('M115', 15, '2024-08-01'),
  ('M116', 16, '2024-08-05'),
  ('M117', 17, '2024-09-01'),
  ('M118', 18, '2024-09-05'),
  ('M119', 19, '2024-10-01'),
  ('M120', 20, '2024-10-05');


INSERT INTO PayloadPurpose (MissionID, PayloadID, Purpose, PurposeAssignmentDate) VALUES
('M101', 1, 'Communications Setup', '2023-01-10'),
('M101', 2, 'Research Instruments', '2023-01-11'),
('M102', 3, 'Satellite Deployment', '2023-02-05'),
('M102', 4, 'Habitat Module', '2023-02-06'),
('M103', 5, 'Rover Deployment', '2023-03-15'),
('M103', 6, 'Sample Collection', '2023-03-16'),
('M104', 7, 'Observatory Setup', '2023-04-20'),
('M104', 8, 'Climate Study', '2023-04-21'),
('M105', 9, 'Deep Space Monitoring', '2023-05-25'),
('M105', 10, 'Asteroid Mapping', '2023-05-26'),
('M106', 11, 'Cosmic Dust Collection', '2023-06-10'),
('M106', 12, 'Solar Flare Analysis', '2023-06-11'),
('M107', 13, 'Microgravity Experiments', '2023-07-07'),
('M107', 14, 'Radiation Shield Testing', '2023-07-08'),
('M108', 15, 'Biological Experiments', '2023-08-12'),
('M108', 16, 'Energy Harvesting Modules', '2023-08-13'),
('M109', 17, 'Quantum Communication', '2023-09-09'),
('M109', 18, 'Interstellar Mapping', '2023-09-10'),
('M110', 19, 'Alien Life Search', '2023-10-14'),
('M110', 20, 'Time Capsule', '2023-10-15');





select * from Mission
select * from MissionAgencyAssignment
select * from MissionAstronautsAssignment
select * from MissionCommunications
select * from MissionLaunch
select * from MissionObjective
select * from VehicleFuelConsumption
select * from InstrumentAssignment

select * from PayloadPurpose
select * from Agency
select * from Astronaut
select * from CommunicationSystem
select * from Fuel

select * from LaunchSite
select * from LaunchVehicle
select * from Spacecraft
select * from Activity
select * from ScientificInstrument



