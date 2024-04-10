-----------------------------------------------------Question-1----------------------------------------------------------------------------------------------------------


--Store Procedure-1------------------------------
--TASK:- Retrieves budget information for a specified mission. It uses the mission ID as an input parameter and returns the mission's budget as an output parameter.

CREATE PROCEDURE GetMissionBudgetInfo
    @MissionID VARCHAR(255),
    @MissionBudget DECIMAL(19,4) OUTPUT
AS
BEGIN
    SELECT @MissionBudget = MissionBudget
    FROM Mission
    WHERE MissionID = @MissionID;

    IF @@ROWCOUNT = 0
    BEGIN
        SET @MissionBudget = NULL; -- Indicates that the mission was not found.
    END
END;


-- Declare a variable to hold the mission budget

DECLARE @BudgetInfo DECIMAL(19,4);

-- Call the stored procedure with a specific MissionID
EXEC GetMissionBudgetInfo
    @MissionID = 'M101', -- Replace 'M101' with your specific MissionID
    @MissionBudget = @BudgetInfo OUTPUT;

-- Display the budget information
SELECT @BudgetInfo AS MissionBudget;


--Store Procedure-2--------------------------------------------------------------------------------------
---Task:- This stored procedure adds a new mission to the Mission table, taking various mission details as input parameters and returning a message as an output parameter indicating the success or failure of the operation.
CREATE PROCEDURE AddMission
    @MissionID VARCHAR(255),
    @MissionName VARCHAR(255),
    @MissionStartDate DATE,
    @Duration INT,
    @MissionStatus VARCHAR(255),
    @Destination VARCHAR(255),
    @MissionBudget DECIMAL(19,4),
    @ResultMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Mission WHERE MissionID = @MissionID)
    BEGIN
        INSERT INTO Mission (MissionID, MissionName, MissionStartDate, Duration, MissionStatus, Destination, MissionBudget)
        VALUES (@MissionID, @MissionName, @MissionStartDate, @Duration, @MissionStatus, @Destination, @MissionBudget);

        SET @ResultMessage = 'Mission successfully added.';
    END
    ELSE
    BEGIN
        SET @ResultMessage = 'Mission ID already exists.';
    END
END;


DECLARE @OutputMessage NVARCHAR(255);

EXEC AddMission
    @MissionID = 'M121', 
    @MissionName = 'Interstellar Exploration',
    @MissionStartDate = '2030-01-01', 
    @Duration = 365, 
    @MissionStatus = 'Planned', 
    @Destination = 'Alpha Centauri', 
    @MissionBudget = 1000000000.0000,
    @ResultMessage = @OutputMessage OUTPUT;

SELECT @OutputMessage AS ResultMessage;



------------------------------------------------Store Procedure-3-----------------------------------------------------------------------------------------------------------------------
----task:- Updates the status of an existing mission. It has input parameters for the mission ID and the new status, and an output parameter for a result message.


CREATE PROCEDURE UpdateMissionStatus
    @MissionID VARCHAR(255),
    @NewStatus VARCHAR(255),
    @ResultMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    IF EXISTS (SELECT * FROM Mission WHERE MissionID = @MissionID)
    BEGIN
        UPDATE Mission
        SET MissionStatus = @NewStatus
        WHERE MissionID = @MissionID;

        SET @ResultMessage = 'Mission status updated successfully.';
    END
    ELSE
    BEGIN
        SET @ResultMessage = 'Mission ID does not exist.';
    END
END;


-- Declare a variable to hold the result message from the procedure
DECLARE @OutcomeMessage NVARCHAR(255);

-- Execute the stored procedure with example parameters
EXEC UpdateMissionStatus
    @MissionID = 'M101', -- Specify the MissionID you want to update
    @NewStatus = 'Active', -- Specify the new status for the mission
    @ResultMessage = @OutcomeMessage OUTPUT; -- Capture the outcome message

-- Display the outcome message
SELECT @OutcomeMessage AS OutcomeMessage;


