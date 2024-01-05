CREATE PROCEDURE [dbo].[SP_GetAuditLogsOnFilter]
	@contractId BIGINT,
	@pageNumber INT = 1,
    @pageSize INT = 10,
	@sortByColumn NVARCHAR(100),
	@sortBy NVARCHAR(100)
AS
BEGIN

     -- Exec SP_GetAuditLogsOnFilter @contractId=1,@pageNumber=1,@pageSize=20,@sortByColumn=N'CreatedTime',@sortBy=N''
	 -- SET NOCOUNT ON added to prevent extra result sets from
     -- Interfering with SELECT statements.
     SET NOCOUNT ON;

	DECLARE @QUERY NVARCHAR(MAX);
	DECLARE @WHERECLAUSE NVARCHAR(MAX);
	DECLARE @ORDERBYCLAUSE NVARCHAR(MAX);
	

	IF(@sortByColumn!='')
	BEGIN
		SET @ORDERBYCLAUSE=' ORDER BY '+@sortByColumn+' Desc';

		IF(@sortBy!='')
		BEGIN
			SET @ORDERBYCLAUSE=@ORDERBYCLAUSE+ ' ' +@sortBy;
		END
	END
	

	SET @QUERY='SELECT Distinct 
					COUNT(AL.Id) OVER() AS TotalRecords,
					AL.Id, 
					AL.LogMessage As Description,
					AL.CreatedTime,
					CONCAT_WS('' '',U.FirstName, U.LastName) As CreatedBy,
					ALE.Name AS Action
				FROM AuditLogs AL
				INNER JOIN 
					AuditLogEvent ALE on AL.EventId = ALE.Id
				LEFT JOIN
					[User] U on U.Id = AL.CreatedBy
				';
					
	SET @WHERECLAUSE=' WHERE '

	IF(@contractId>=0)
	BEGIN
	   SET @WHERECLAUSE=@WHERECLAUSE+'AL.EntityId= '+CONVERT(VARCHAR(20),@contractId);
	END

	
	SET @QUERY= @QUERY +@WHERECLAUSE;
	SET @QUERY= @QUERY +@ORDERBYCLAUSE;

	SET @QUERY=@QUERY+ ' OFFSET '+CONVERT(VARCHAR(20),(@pageNumber-1))+'*'+CONVERT(VARCHAR(100),@PageSize)+' ROWS FETCH NEXT '+CONVERT(VARCHAR(100),@PageSize)+' ROWS ONLY; ';
	
	print @QUERY
	EXEC (@QUERY);

END