CREATE PROCEDURE [dbo].[SP_GetUserDetails]	
		@FirstName NVARCHAR(50)='',
		@CompanyName NVARCHAR(50)='', 
		@StatusId BIGINT=NULL,
		@pageNumber INT = 1,
		@pageSize INT = 10,
		@sortByColumn NVARCHAR(100)='Id',
		@sortBy NVARCHAR(100)='ASC'
AS BEGIN 
		DECLARE @v_s_sql NVARCHAR(MAX);  
		DECLARE @ORDERBYCLAUSE NVARCHAR(MAX);

		IF(@sortByColumn!='')  
		BEGIN		
			SET @ORDERBYCLAUSE=' ORDER BY '+@sortByColumn;
			IF(@sortBy!='')  
			BEGIN  
				SET @ORDERBYCLAUSE=@ORDERBYCLAUSE+ ' ' +@sortBy;  
			END  
		END  
		
		SET @v_s_sql='
				SELECT 
					COUNT(*) OVER() AS TotalRecords,
					U.Id, 
					FirstName, 
					LastName, 
					CompanyName, 
					Designation, 
					EmailId, 
					ContactNo, 
					IsApproved, 
					us.name AS [Status], 
					us.Id AS StatusId, 
					ut.Id AS UserTypeId, 
					ut.Name AS UserType, 
					U.OrganizationId AS OrganizationId, 
					o.name AS Organization 
				FROM 
					dbo.[SignUpUser] U 
				INNER JOIN userstatus us 
					ON us.id = u.statusid 
				LEFT JOIN usertype ut 
					ON ut.id = u.usertypeid 
				LEFT JOIN organization o 
					ON o.id = u.organizationId 
				WHERE
			 '     

		IF @FirstName <> ''         
		BEGIN         
			SET @v_s_sql=@v_s_sql+' (FirstName + LastName Like ''%'+@FirstName+'%'') AND'         
		END          
		IF @CompanyName <> ''   
		BEGIN   
			SET @v_s_sql=@v_s_sql+' (CompanyName Like ''%'+@CompanyName+'%'') AND'   
		END   
		IF @StatusId IS NOT NULL AND @StatusId > 0  
		BEGIN  
			SET @v_s_sql=@v_s_sql+' StatusId = ' + CAST(@StatusId AS NVARCHAR(10)) +' AND'   
		END   

		--Preparing OFFSET statement
		DECLARE @OffsetExp VARCHAR(MAX) = ' OFFSET '+CONVERT(VARCHAR(20),(@pageNumber))+'*'+CONVERT(VARCHAR(100),@PageSize)+' ROWS FETCH NEXT '+CONVERT(VARCHAR(100),@PageSize)+' ROWS ONLY ';
		
		SET @v_s_sql=@v_s_sql+' 1=1' + @ORDERBYCLAUSE + @OffsetExp 

		EXEC SP_EXECUTESQL @v_s_sql;
END