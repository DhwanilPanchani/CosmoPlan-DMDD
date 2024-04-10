----------------------------------------- UDFs -----------------------------------------------------
-- UDF 1
-- UDF to Check Mission Overlap
-- Given two mission IDs, this function determines if their operational periods overlap, which is useful for resource allocation and avoiding scheduling conflicts.


CREATE FUNCTION dbo.fn_CheckMissionOverlap
(
    @MissionID1 VARCHAR(255),
    @MissionID2 VARCHAR(255)
)
RETURNS BIT
AS
BEGIN
    DECLARE @StartDate1 DATE, @EndDate1 DATE, @StartDate2 DATE, @EndDate2 DATE;
    
    SELECT @StartDate1 = MissionStartDate, @EndDate1 = DATEADD(DAY, Duration, MissionStartDate)
    FROM Mission WHERE MissionID = @MissionID1;
    
    SELECT @StartDate2 = MissionStartDate, @EndDate2 = DATEADD(DAY, Duration, MissionStartDate)
    FROM Mission WHERE MissionID = @MissionID2;
    
    IF ((@StartDate1 BETWEEN @StartDate2 AND @EndDate2) OR (@EndDate1 BETWEEN @StartDate2 AND @EndDate2)
        OR (@StartDate2 BETWEEN @StartDate1 AND @EndDate1) OR (@EndDate2 BETWEEN @StartDate1 AND @EndDate1))
        RETURN 1; -- Overlap exists

    RETURN 0; -- No overlap
END;


SELECT 
    dbo.fn_CheckMissionOverlap('M102', 'M103') AS IsOverlap;



-- UDF2
--UDF to Aggregate Astronaut Specialties for a Mission
-- This function lists all astronaut specialties involved in a specific mission, providing insights into the crew's diverse skills and expertise areas.

CREATE FUNCTION dbo.fn_ListAstronautSpecialties
(
    @MissionID VARCHAR(255)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @SpecialtiesList VARCHAR(MAX) = '';
    
    SELECT @SpecialtiesList = STRING_AGG(Specialty, '; ') WITHIN GROUP (ORDER BY Specialty)
    FROM Astronaut
    INNER JOIN MissionAstronautsAssignment ON Astronaut.AstronautID = MissionAstronautsAssignment.AstronautID
    WHERE MissionAstronautsAssignment.MissionID = @MissionID;
    
    RETURN @SpecialtiesList;
END;

SELECT 
    dbo.fn_ListAstronautSpecialties('M101') AS AstronautSpecialties;


-- UDF 3
-- UDF for Estimated End Date
-- This function calculates the estimated end date based on the mission's start date and duration.

CREATE FUNCTION dbo.fn_EstimatedEndDate
(
    @StartDate DATE,
    @Duration INT
)
RETURNS DATE
AS
BEGIN
    RETURN DATEADD(DAY, @Duration, @StartDate);
END;


SELECT 
    m.MissionID,
    m.MissionName,
    m.MissionStartDate,
    dbo.fn_EstimatedEndDate(m.MissionStartDate, m.Duration) AS EstimatedEndDate
FROM 
    Mission m;


-- UDF 4
-- UDF for Mission Length Category
-- Categorizes each mission based on its duration, providing a quick way to understand mission length without specific cost details.
CREATE FUNCTION dbo.fn_MissionLengthCategoryByMissionID
(
    @MissionID VARCHAR(255)
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @Duration INT;
    DECLARE @Category VARCHAR(50);

    -- Retrieve the duration for the specified MissionID
    SELECT @Duration = Duration
    FROM Mission
    WHERE MissionID = @MissionID;

    -- Determine the category based on the duration
    IF @Duration <= 30 BEGIN
        SET @Category = 'Short-term';
    END ELSE IF @Duration > 30 AND @Duration <= 180 BEGIN
        SET @Category = 'Medium-term';
    END ELSE BEGIN
        SET @Category = 'Long-term';
    END;

    RETURN @Category;
END;

SELECT 
    MissionID, 
    dbo.fn_MissionLengthCategoryByMissionID(MissionID) AS LengthCategory
FROM 
    Mission;


-- UDF 5
-- UDF to Check Payload Capacity vs. Weight
-- This UDF will determine whether the total weight of payloads for a given mission is within the payload capacity of the assigned spacecraft.

CREATE FUNCTION dbo.fn_CheckPayloadCapacity
(
    @MissionID VARCHAR(255)
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @TotalWeight DECIMAL(18,2);
    DECLARE @PayloadCapacity DECIMAL(18,2);
    
    -- Calculate the total weight of payloads assigned to the mission
    SELECT @TotalWeight = ISNULL(SUM(Payload.Weight), 0)
    FROM Payload
    INNER JOIN PayloadPurpose ON Payload.PayloadID = PayloadPurpose.PayloadID
    WHERE PayloadPurpose.MissionID = @MissionID;
    
    -- Retrieve the payload capacity of the spacecraft assigned to the mission
    SELECT @PayloadCapacity = ISNULL(Spacecraft.PayloadCapacity, 0)
    FROM Spacecraft
    WHERE Spacecraft.MissionID = @MissionID;
    
    -- Determine if the total payload weight exceeds the spacecraft's capacity
    IF @TotalWeight > @PayloadCapacity
        RETURN 'Exceeds Capacity';
  
    RETURN 'Within Capacity';
END;


SELECT 
    MissionID, 
    dbo.fn_CheckPayloadCapacity(MissionID) AS CapacityCheck
FROM 
    Mission;



-------------  Computed Columns baed on UDF3, UDF4, UDF5 --------------------


ALTER TABLE Mission
ADD EstimatedEndDate AS dbo.fn_EstimatedEndDate(MissionStartDate, Duration);


ALTER TABLE Mission
ADD LengthCategory AS dbo.fn_MissionLengthCategoryByMissionID(MissionID);


ALTER TABLE Mission
ADD CapacityCheck AS dbo.fn_CheckPayloadCapacity(MissionID);


SELECT * FROM Mission;