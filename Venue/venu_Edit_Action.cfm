<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	venu_Edit_Action.cfm
	performs queries to update venue info: venue type, venue name, tax id
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Edit Venue Action</title>
	
</head>



<body>
 <cfset commitIt = "yes">

<CFTRANSACTION Action="Begin">
<CFTRY> 
<!--- pulls status info - in qUpdatevenue verify if status was previously inactive and currently inactive. If so, so not update inactive date --->
<cfquery name="qfetch" datasource="#application.speakerDSN#">
	SELECT  venues.active, venues.date_inactive
	FROM   	venues  
	WHERE  	venues.venue_id =  #venue_id# AND venues.display = '1' 
	</cfquery>
 <cfcatch type="Database">
		<Cftransaction Action="Rollback"/>
		<CFSET CommitIt = "no">
	</Cfcatch>	
</CFTRY>	

	<CFTRY> 
<cfquery name="qUpdatevenue" datasource="#application.speakerDSN#">
	Update venues 
	Set venue_name='#trim(Left(form.venue_name, 50))#', 
		date_updated=#Now()#, updated_by=#session.userinfo.rowid#, tax_id='#trim(Left(form.tax_id, 11))#', venue_type='#trim(Left(form.venue_type, 5))#', active='#form.active#'<cfif form.active EQ 'INACT' AND qfetch.active NEQ 'INACT'>,date_inactive=#Now()#</cfif>
	Where venue_id = #venue_id#
</cfquery>
 <cfcatch type="Database">
		<Cftransaction Action="Rollback"/>
		<CFSET CommitIt = "no">
	</Cfcatch>
	</cftry>


</cftransaction>


<cfif commitIt EQ "yes"> 
<cfoutput> 
<META HTTP-EQUIV="Refresh" CONTENT="0;URL=venu_edit_bridge.cfm?venue_id=#venue_id#&no_menu='1'">
</cfoutput> 
 <cfelse> 
This Venue has not been edited. Please contact IT for assistance.
 </cfif> 
</body>
</html>