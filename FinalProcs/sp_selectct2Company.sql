/*============================================= 
Description:
ReadProcedurectCompany
Description:      
ReadProcedureRecipientTable
Author: Francisco Duran    
Date: 12-13-16
Change History:      
=============================================*/
USE communityThrive2DB;
GO
CREATE PROCEDURE sp_selectct2Company
			@companyID INT
AS
BEGIN 

    DECLARE @v_error VARCHAR(255),
    @v_errorNo INT

    BEGIN TRY

        SELECT com.companyID
      ,com.companyName
      ,com.companyDescription
      ,com.cityIDFK
	  ,com.stateIDFK
      ,com.companyDemographic
		FROM ct2Company com
		LEFT JOIN ct2City cy ON com.cityIDFK = cy.cityID
		LEFT JOIN ct2State st ON com.stateIDFK = st.stateID
		ORDER BY com.companyName, com.companyDescription

    END TRY
    BEGIN CATCH

        SELECT @v_error = ERROR_MESSAGE()
        SELECT @v_errorNo = ERROR_NUMBER()

        RAISERROR('Database error occured %s',16,1,@v_error)
        RETURN -20000

    END CATCH
END