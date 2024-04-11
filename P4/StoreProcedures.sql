------------------------------------------------STORED PROCEDURES-------------------------------------------------------------------------



--Stored Procedure-1------------------------------
--Task:- Retrieves budget information for a specified mission. It uses the mission ID as an input parameter and returns the mission's budget as an output parameter.

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

---------Testing---------

DECLARE @BudgetInfo DECIMAL(19,4);

EXEC GetMissionBudgetInfo
    @MissionID = 'M101',
    @MissionBudget = @BudgetInfo OUTPUT;

SELECT @BudgetInfo AS MissionBudget;


--Stored Procedure-2--------------------------------------------------------------------------------------
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



----Stored Procedure-3-----------------------------------------------------------------------------------------------------------------------
----Task:- Updates the status of an existing mission. It has input parameters for the mission ID and the new status, and an output parameter for a result message.

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


---Testing-----
DECLARE @OutcomeMessage NVARCHAR(255);

EXEC UpdateMissionStatus
    @MissionID = 'M101', 
    @NewStatus = 'Active', 
    @ResultMessage = @OutcomeMessage OUTPUT; 

SELECT @OutcomeMessage AS OutcomeMessage;


----Stored Procedure 4 --------------------------------------------
--------Task - This stored procedure assigns an astronaut to a mission if they are not already assigned to it and if the mission is in 'Planned' status.

CREATE PROCEDURE AssignAstronautToMission
    @AstronautID INT,
    @MissionID VARCHAR(255),
    @Role VARCHAR(255),
    @ResultMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Check if the astronaut is already assigned to the mission
        IF NOT EXISTS (
            SELECT 1 FROM MissionAstronautsAssignment
            WHERE AstronautID = @AstronautID AND MissionID = @MissionID
        )
        BEGIN
            -- Ensure the mission is in 'Planned' status
            IF EXISTS (
                SELECT 1 FROM Mission
                WHERE MissionID = @MissionID AND MissionStatus = 'Planned'
            )
            BEGIN
                -- Assign the astronaut to the mission
                INSERT INTO MissionAstronautsAssignment (MissionID, AstronautID, Role, MissionAstronautsAssignmentDate)
                VALUES (@MissionID, @AstronautID, @Role, GETDATE());

                SET @ResultMessage = 'Astronaut assigned to the mission successfully.';
            END
            ELSE
            BEGIN
                SET @ResultMessage = 'Mission is not in a valid state for assignment.';
            END
        END
        ELSE
        BEGIN
            SET @ResultMessage = 'Astronaut is already assigned to the mission.';
        END
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        SET @ResultMessage = ERROR_MESSAGE();
        ROLLBACK TRANSACTION;
    END CATCH
END;


--- Testing-----

DECLARE @Result NVARCHAR(255);
EXEC AssignAstronautToMission
    @AstronautID = 1, 
    @MissionID = 'M102', 
    @Role = 'Commander', 
    @ResultMessage = @Result OUTPUT;

SELECT @Result as ResultMessage;


----------- Stored Procedure 5 -----------
-------Task - This procedure adjusts the budget of a given mission either by a fixed amount or a percentage.

CREATE PROCEDURE AdjustMissionBudget
    @MissionID VARCHAR(255),
    @AdjustmentAmount DECIMAL(19,4) = 0,
    @IsPercentage BIT = 0,
    @ResultMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentBudget DECIMAL(19,4);

    BEGIN TRY
        SELECT @CurrentBudget = MissionBudget FROM Mission WHERE MissionID = @MissionID;

        IF @IsPercentage = 1
        BEGIN
            -- Adjust by a percentage
            UPDATE Mission
            SET MissionBudget = MissionBudget * (1 + @AdjustmentAmount / 100)
            WHERE MissionID = @MissionID;
        END
        ELSE
        BEGIN
            -- Adjust by a fixed amount
            UPDATE Mission
            SET MissionBudget = MissionBudget + @AdjustmentAmount
            WHERE MissionID = @MissionID;
        END
        
        SET @ResultMessage = 'Mission budget adjusted successfully.';
    END TRY
    BEGIN CATCH
        SET @ResultMessage = ERROR_MESSAGE();
    END CATCH
END;

----Testing---------
DECLARE @Msg NVARCHAR(255);
EXEC AdjustMissionBudget @MissionID = 'M101', @AdjustmentAmount = 5000000, @IsPercentage = 0, @ResultMessage = @Msg OUTPUT;
SELECT @Msg AS Message;




-------------Stored Procedure 6---------------
--------Task - This procedure could check if the actual spend on a mission has exceeded the allocated budget.

CREATE PROCEDURE CheckBudgetAllocation
    @MissionID VARCHAR(255),
    @ActualSpend DECIMAL(19,4),
    @ResultMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Budget DECIMAL(19,4);

    BEGIN TRY
        SELECT @Budget = MissionBudget FROM Mission WHERE MissionID = @MissionID;

        IF @Budget < @ActualSpend
        BEGIN
            SET @ResultMessage = 'Warning: Actual spend exceeds the budget.';
        END
        ELSE
        BEGIN
            SET @ResultMessage = 'Budget allocation is within limits.';
        END
    END TRY
    BEGIN CATCH
        SET @ResultMessage = ERROR_MESSAGE();
    END CATCH
END;


-----Testing-------
DECLARE @Msg NVARCHAR(255);
EXEC CheckBudgetAllocation @MissionID = 'M101', @ActualSpend = 20000000, @ResultMessage = @Msg OUTPUT;
SELECT @Msg AS Message;
