<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	venu_Edit_Address_Action.cfm
	performs queries to update address information including: mailto address, city, state, zip AND Business address, city, state, zip
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Update Address</title>
	
</head>


<body>

<!--- check for null values --->
<cfif #parameterexists(form.mailtoadd_2)#>
	<cfset session.mailtoadd_2 = #form.mailtoadd_2#>
<cfelse>
	<cfset session.mailtoadd_2 = ""> 
</cfif>
<cfif #parameterexists(form.mailtoadd_3)#>
	<cfset session.mailtoadd_3 = #form.mailtoadd_3#>
<cfelse>
	<cfset session.mailtoadd_3 = ""> 
</cfif>
<cfif #parameterexists(form.busadd_2)#>
	<cfset session.busadd_2 = #form.busadd_2#>
<cfelse>
	<cfset session.busadd_2 = ""> 
</cfif>
<cfif #parameterexists(form.busadd_3)#>
	<cfset session.busadd_3 = #form.busadd_3#>
<cfelse>
	<cfset session.busadd_3 = ""> 
</cfif>



<cfset commitIt = "yes">

<CFTRANSACTION Action="Begin">
	<CFTRY>
<cfquery name="qUpdate_Address" datasource="#application.speakerDSN#">
	Update address 
	Set owner_id='#venue_id#', mailtoadd_1='#Left(Form.mailtoadd_1, 75)#', mailtoadd_2='#Left(session.mailtoadd_2, 75)#',
		mailtoadd_3='#Left(session.mailtoadd_3, 75)#', mailtocity='#Left(Form.mailtocity, 35)#',
		mailtostate='#Left(Form.mailtostate, 4)#', mailtozip='#Left(Form.mailtozip, 10)#', mailtocountry='#Left(Form.mailtocountry, 35)#', busadd_1='#Left(Form.busadd_1, 75)#', busadd_2='#Left(session.busadd_2, 75)#',
		busadd_3='#Left(session.busadd_3, 75)#', buscity='#Left(Form.buscity, 35)#',
		busstate='#Left(Form.busstate, 4)#', buszip='#Left(Form.buszip, 10)#', buscountry='#Left(Form.buscountry, 35)#' 
	Where add_id = #add_id# AND owner_type = 'VENU'
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
This Address has not been edited. Please contact IT for assistance.
</cfif>
</body>
</html>
