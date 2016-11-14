<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	spkr_Add_Product_action.cfm
	performs queries to add speakers employers, fees, comments
	
	lb082902-  Initial code.
	
------------------------------------------------------------------------------
--->
<head>
	<title>Add Clients/Products</title>
	
</head>

 <body>



<cfquery name="qInsertNewClient" datasource="#application.speakerDSN#">
	Insert into speaker_clients (speakerid, client_code, type, comments, fee)  
	Values(#url.speakerid#, '#form.client_code#', 'SPKR', '#form.comments#', #LSParseNumber(form.fee)#)
 </cfquery> 
  
<cfoutput> 
<META HTTP-EQUIV="Refresh" CONTENT="0;URL=spkr_edit_bridge.cfm?speakerid=#speakerid#&no_menu='1'">
</cfoutput>
 
</body>
</html>
