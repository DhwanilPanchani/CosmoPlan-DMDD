------------------------------------- VIEWS --------------------------------------


-- View 1
--The vw_MissionComprehensiveReport view provides a detailed snapshot of each space mission, including mission details, responsible agency, astronaut count, objectives, launch site, payload information, and assigned spacecraft and launch vehicle, all in one consolidated report.

CREATE VIEW vw_MissionComprehensiveReport AS
SELECT 
    m.MissionID,
    m.MissionName,
    m.MissionStartDate,
    DATEADD(DAY, m.Duration, m.MissionStartDate) AS 'EstimatedEndDate',
    m.Duration,
    m.MissionStatus,
    m.Destination,
    a.AgencyName AS 'ResponsibleAgency',
    (SELECT COUNT(*) FROM MissionAstronautsAssignment WHERE MissionID = m.MissionID) AS 'NumberOfAstronauts',
    (SELECT STRING_AGG(ObjectiveDescription, '; ') FROM Objective 
        INNER JOIN MissionObjective ON Objective.ObjectiveID = MissionObjective.ObjectiveID 
        WHERE MissionObjective.MissionID = m.MissionID) AS 'MissionObjectives',
    ls.SiteName AS 'LaunchSite',
    ls.Location AS 'LaunchSiteLocation',
    (SELECT STRING_AGG(PayloadName, '; ') FROM Payload 
        INNER JOIN PayloadPurpose ON Payload.PayloadID = PayloadPurpose.PayloadID 
        WHERE PayloadPurpose.MissionID = m.MissionID) AS 'MissionPayloads',
    s.CraftName AS 'AssignedSpacecraft',
    lv.VehicleName AS 'AssignedLaunchVehicle'
FROM 
    Mission m
LEFT JOIN Agency a ON a.AgencyID = (SELECT TOP 1 AgencyID FROM MissionAgencyAssignment WHERE MissionID = m.MissionID ORDER BY MissionAgencyAssignmentDate DESC)
LEFT JOIN LaunchSite ls ON ls.SiteID = (SELECT TOP 1 SiteID FROM MissionLaunch WHERE MissionID = m.MissionID ORDER BY LaunchDate DESC)
LEFT JOIN Spacecraft s ON m.MissionID = s.MissionID
LEFT JOIN LaunchVehicle lv ON m.MissionID = lv.MissionID


SELECT * FROM vw_MissionComprehensiveReport WHERE MissionStatus = 'Active';

SELECT * 
FROM vw_MissionComprehensiveReport 
WHERE MissionStartDate BETWEEN '2024-05-01' AND '2028-12-31'
AND MissionStatus = 'Planned';



-- View 2
-- This view could summarize the budgets of the agencies and the total budget allocated to their missions, providing a financial overview that could be very useful for analysts and financial officers.

CREATE VIEW [dbo].[vw_FinancialOverview] AS
SELECT 
    a.AgencyID,
    a.AgencyName,
    a.AgencyBudget,
    SUM(m.MissionBudget) AS TotalMissionBudgets,
    COUNT(m.MissionID) AS NumberOfMissions,
    AVG(m.MissionBudget) AS AverageMissionBudget
FROM 
    Agency a
JOIN 
    MissionAgencyAssignment maa ON a.AgencyID = maa.AgencyID
JOIN 
    Mission m ON maa.MissionID = m.MissionID
GROUP BY 
    a.AgencyID, 
    a.AgencyName, 
    a.AgencyBudget;

SELECT * 
FROM vw_FinancialOverview
WHERE TotalMissionBudgets > 500000000; -- Filters for agencies with total mission budgets over 500 million


-- View 3
-- The vw_OperationalReadiness view provides a concise summary of both spacecraft and launch vehicles, including their types, payload capacities, and whether each is currently assigned to a mission or available, simplifying operational readiness assessment.
CREATE VIEW vw_OperationalReadiness AS
SELECT 
    sc.CraftID AS SpacecraftID,
    sc.CraftName AS SpacecraftName,
    sc.SpacecraftType,
    sc.PayloadCapacity AS SpacecraftPayloadCapacity,
    sc.SpacecraftStatus AS SpacecraftOperationalStatus,
    lv.VehicleID AS LaunchVehicleID,
    lv.VehicleName AS LaunchVehicleName,
    lv.VehicleType AS LaunchVehicleType,
    lv.PayloadCapacity AS LaunchVehiclePayloadCapacity,
    CASE 
        WHEN sc.MissionID IS NOT NULL THEN 'Assigned'
        ELSE 'Available'
    END AS SpacecraftAssignmentStatus,
    CASE 
        WHEN lv.MissionID IS NOT NULL THEN 'Assigned'
        ELSE 'Available'
    END AS LaunchVehicleOperationalStatus
FROM 
    Spacecraft sc
LEFT JOIN 
    Mission m ON sc.MissionID = m.MissionID
LEFT JOIN 
    LaunchVehicle lv ON m.MissionID = lv.MissionID;



SELECT * 
FROM vw_OperationalReadiness

SELECT * 
FROM vw_OperationalReadiness 
WHERE SpacecraftAssignmentStatus = 'Assigned' and LaunchVehicleOperationalStatus = 'Assigned';

