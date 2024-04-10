-------------------------------------- TRIGGERS -------------------------------------
USE CosmoPlan;

--This trigger ensures that the sum of the mission budgets doesn't exceed the agency budget when inserting a new mission

CREATE TRIGGER tr_CheckAgencyBudget
ON MissionAgencyAssignment
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Get the inserted or updated rows
    SELECT i.AgencyID, SUM(m.MissionBudget) AS TotalMissionBudget
    INTO #TempTable
    FROM inserted i
    INNER JOIN Mission m ON i.MissionID = m.MissionID
    GROUP BY i.AgencyID;

    -- Check if the total mission budget exceeds the agency budget
    IF EXISTS (
        SELECT 1
        FROM #TempTable t
        INNER JOIN Agency a ON t.AgencyID = a.AgencyID
        WHERE t.TotalMissionBudget > a.AgencyBudget
    )
    BEGIN
        RAISERROR('The total mission budget exceeds the agency budget.', 16, 1);
        ROLLBACK TRANSACTION;
    END

END
GO


--This trigger ensures that the sum of the mission budgets doesn't exceed the agency budget when updating a mission
CREATE TRIGGER tr_CheckAgencyBudget1
ON Mission
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Get the inserted or updated rows
    SELECT ma.AgencyID, SUM(i.MissionBudget) AS TotalMissionBudget
    INTO #TempTable
    FROM inserted i
    INNER JOIN MissionAgencyAssignment ma ON i.MissionID = ma.MissionID
    GROUP BY ma.AgencyID;

    -- Check if the total mission budget exceeds the agency budget
    IF EXISTS (
        SELECT 1
        FROM #TempTable t
        INNER JOIN Agency a ON t.AgencyID = a.AgencyID
        WHERE t.TotalMissionBudget > a.AgencyBudget
    )
    BEGIN
        RAISERROR('The total mission budget exceeds the agency budget.', 16, 1);
        ROLLBACK TRANSACTION;
    END

END
GO


-- Testing

INSERT INTO MissionAgencyAssignment (MissionID, AgencyID, MissionAgencyAssignmentDate)
VALUES ('M121', 'AG01', '2024-09-01');

INSERT INTO Mission (MissionID, MissionName, MissionStartDate, Duration, MissionStatus, Destination, MissionBudget)
VALUES ('M121', 'New Expensive Mission', '2025-01-01', 365, 'Planned', 'Mars', 10000000000.0000);

UPDATE Mission
SET MissionName = 'New Expensive Mission',
    MissionStartDate = '2025-01-01',
    Duration = 365,
    MissionStatus = 'Planned',
    Destination = 'Mars',
    MissionBudget = 10000000000.0000
WHERE MissionID = 'M121';




-- This trigger encrypts data for LaunchVehicleManufacturer

CREATE TRIGGER EncryptLaunchVehicleManufacturer
ON LaunchVehicle
AFTER INSERT
AS
BEGIN
    OPEN SYMMETRIC KEY ManufacturerKey
    DECRYPTION BY CERTIFICATE ManufacturerCert;

    UPDATE lv
    SET Manufacturer = ENCRYPTBYKEY(KEY_GUID('ManufacturerKey'), i.Manufacturer)
    FROM LaunchVehicle lv
    INNER JOIN inserted i ON lv.VehicleID = i.VehicleID;
END;
GO


-- This trigger encrypts data for LaunchSiteLocation

CREATE TRIGGER EncryptLaunchSiteLocation
ON LaunchSite
AFTER INSERT
AS
BEGIN
    OPEN SYMMETRIC KEY LocationKey
    DECRYPTION BY CERTIFICATE LocationCert;

    UPDATE ls
    SET Location = ENCRYPTBYKEY(KEY_GUID('LocationKey'), i.Location)
    FROM LaunchSite ls
    INNER JOIN inserted i ON ls.SiteID = i.SiteID;
END;
GO