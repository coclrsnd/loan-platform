CREATE PROCEDURE [dbo].[SP_GetSOCountByVendorCustomerEffectiveDate]
 @VendorId Int,
 @CustomerId Int,
 @EffectiveDate datetime

        AS
        BEGIN
		select count(Id) as StorageOrderCount from Contract C where C.VendorId = @VendorId and C.CustomerId=@CustomerId and year(C.EffectiveDate) =  year(@EffectiveDate)
        END