/*============================================= 
Description:      
ReadProcedurectDonation
Author: Francisco Duran    
Date: 12-11-16
Change History:      
=============================================*/
USE communityThrive2DB;
GO
CREATE PROCEDURE dbo.sp_selectct2Donation
    @donationID int
AS
BEGIN 

    DECLARE @v_error VARCHAR(255),
    @v_errorNo INT

    BEGIN TRY

        SELECT  dona.donationID
      ,dona.dateSubmitted
	  ,dona.userIDFK
	  ,dona.eventIDFK
      ,dona.dateSubmitted
      ,donationDescription
      ,donationNotes
		FROM ct2Donation dona
		--- Joins eventIDFK and userIDFK foreign keys to primary keys
		LEFT JOIN ct2User usr ON dona.userIDFK = usr.userID
		LEFT JOIN ct2Event eve ON dona.eventIDFK = eve.eventID 
		ORDER BY dona.donationID, dona.donationDescription
    END TRY
    BEGIN CATCH

        SELECT @v_error = ERROR_MESSAGE()
        SELECT @v_errorNo = ERROR_NUMBER()

        RAISERROR('Database error occured %s',16,1,@v_error)
        RETURN -20000

    END CATCH
END