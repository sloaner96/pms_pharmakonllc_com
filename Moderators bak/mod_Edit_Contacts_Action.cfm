<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	mod_Edit_Contacts_action.cfm
	perform queries to update Contact information
	
	lb060201-  Initial code.
	rws101505 - added new header, cleaned up HTML
------------------------------------------------------------------------------
--->
<head>
	<title>Update Contacts</title>
	
</head>

<body>

<cfset commitIt = "yes">

<CFTRANSaction action="Begin">
	<CFTRY>
<cfquery name="qUpdate_Contacts" datasource="#application.speakerDSN#">
	Update Contact_info 
	Set Contact_info='#Left(form.Contact_info, 500)#', date_updated=#Now()# 
	Where Contact_id = #Contact_id# AND type = 'MOD'
</cfquery>
<cfcatch type="Database">
		<Cftransaction action="Rollback"/>
		<CFSET CommitIt = "no">
	</Cfcatch>
	</cftry>
	
<cfif CommitIt EQ "yes">
	<cftry>
	<cfquery name="qUpdateDate" datasource="#application.speakerDSN#">
	Update Speaker
	Set date_updated=#Now()#, updated_by=#session.userinfo.rowid#
	Where speakerid = #speakerid# AND type = 'MOD'
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
<META HTTP-EQUIV="Refresh" CONTENT="0;URL=mod_edit_bridge.cfm?speakerid=#speakerid#&no_menu='1'">
</cfoutput> 
<cfelse>
This Contact has not been edited. Please Contact IT for assistance.
</cfif>
</body>
</html>