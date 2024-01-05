IF EXISTS(SELECT 1 from NotificationEvent where Name = 'OpportunityOrderPlaced')
BEGIN
UPDATE MailConfiguration SET
Body = '<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			<br />
			{customerName}
			<br />
			Woo hoo! We’re happy to let you know that we’ve received your storage order booking.
			<br /><br />
			Your order details can be found below:
			<br />
			Order Number: {orderNo}
			<br />
			Order Date: {orderDate}
			<br /><br />
			Please find the copy of your order summary attached for your reference. A representative from Railcar Lounge™ will contact you with the storage order booking details.
			<br />
		</td>
	</tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			If you wish to contact us regarding your order, please reach out to
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thank you for placing your order!<br>
		<br /><br />  Best Regards,<br /> 
Railcar Lounge™ Team
<br /> <br /> </td>
	</tr>
    <tr bgcolor="#ffffff">
    <td style="font-family:Tahoma,Helvetica,sans-serif;border-top:1px solid #ccc;border-bottom:1px solid #ccc;color:#333333;text-align:center;font-size:14px;padding:15px 0;text-align:center">
         This is an auto generated mail. Please do not reply
      <br></td>
  </tr>
  <tr>
  	<td>
  		<br><br>
  	</td>
  </tr>
</tbody></table>'
WHERE NotificationEventId=(SELECT Id FROM NotificationEvent WHERE Name='OpportunityOrderPlaced' )
END
GO

IF EXISTS(SELECT Name from NotificationEvent where Name = 'VendorOpportunityOrderPlaced')
BEGIN
UPDATE MailConfiguration SET Subject='You have received a booking on your storage facility!'
WHERE NotificationEventId=(SELECT Id FROM NotificationEvent WHERE Name='VendorOpportunityOrderPlaced' )
END
GO