<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	venu_Edit_Contacts_Action.cfm
	perform queries to update contact information
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Update Contacts</title>
	
</head>

<body>

<cfset commitIt = "yes">

<CFTRANSACTION Action="Begin">
	<CFTRY>
<cfquery name="qUpdate_Contacts" datasource="#application.speakerDSN#">
	Update contact_info 
	Set contact_info='#Left(form.contact_info, 500)#', date_updated=#Now()# 
	Where contact_id = #contact_id# AND owner_type = 'VENU'
</cfquery>
<cfcatch type="Database">
		<Cftransaction Action="Rollback"/>
		<CFSET CommitIt = "no">
	</Cfcatch>
	</cftry>

<cfif CommitIt EQ "yes">
	<cftry>
	<cfquery name="qUpdateDate" datasource="#application.speakerDSN#">
	Update venues
	Set date_updated=#Now()#, updated_by=#session.userinfo.rowid#
	Where venue_id = #venue_id#
</cfquery>
<cfcatch Type="Database">
		<cftransaction action="rollback"/>
		<cfset commitIt="No">
	</cfcatch>
	</cftry>
	</cfif>

</cftransaction>

<cfif commitIt EQ "yes">

<cfoutput> 
<META HTTP-EQUIV="Refresh" CONTENT="0;URL=venu_edit_bridge.cfm?venue_id=#venue_id#&no_menu='1'">
</cfoutput> 
<cfelse>
This Contact has not been edited. Please contact IT for assistance.
</cfif>
</body>
</html>