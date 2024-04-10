USE CosmoPlan;
GO

-- Create a master key for the database.
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'CosmoPlan24';

-- Verify that master key exists
SELECT name KeyName,
symmetric_key_id KeyID,
key_length KeyLength,
algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;
go


-- Create a self-signed certificate for Manufacturer and Location
CREATE CERTIFICATE ManufacturerCert
WITH SUBJECT = 'Manufacturer Encryption Certificate';

CREATE CERTIFICATE LocationCert
WITH SUBJECT = 'Location Encryption Certificate';

-- Create symmetric keys for Manufacturer and Location encryption
CREATE SYMMETRIC KEY ManufacturerKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE ManufacturerCert;

CREATE SYMMETRIC KEY LocationKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE LocationCert;

-- Encrypt the Manufacturer column in LaunchVehicle table
OPEN SYMMETRIC KEY ManufacturerKey
DECRYPTION BY CERTIFICATE ManufacturerCert;

UPDATE LaunchVehicle
SET Manufacturer = ENCRYPTBYKEY(KEY_GUID('ManufacturerKey'), Manufacturer);

-- Encrypt the Location column in LaunchSite table
OPEN SYMMETRIC KEY LocationKey
DECRYPTION BY CERTIFICATE LocationCert;

UPDATE LaunchSite
SET Location = ENCRYPTBYKEY(KEY_GUID('LocationKey'), Location);


-- View Encrypted and Decrypted Data
SELECT Manufacturer, CONVERT(varchar, DecryptByKey(Manufacturer)) AS DecryptedManufacturer FROM LaunchVehicle;
SELECT SiteID, SiteName, CONVERT(varchar, DecryptByKey(Location)) AS DecryptedLocation FROM LaunchSite;

-- View Encrypted Data
SELECT * FROM LaunchVehicle;
SELECT * FROM LaunchSite;


-- Drop the symmetric keys if necessary
-- DROP SYMMETRIC KEY ManufacturerKey;
-- DROP SYMMETRIC KEY LocationKey;