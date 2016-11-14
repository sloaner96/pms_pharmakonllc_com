<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	mod_Edit_Address_action.cfm
	performs queries to update address information including: mailto address, city, state, zip AND Business address, city, state, zip
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Update Address</title>
	
</head>


<body>

<!--- check for null values --->
<cfif #parameterexists(form.add2)#>
	<cfset session.add2 = #form.add2#>
<cfelse>
	<cfset session.add2 = ""> 
</cfif>
<cfif #parameterexists(form.add3)#>
	<cfset session.add3 = #form.add3#>
<cfelse>
	<cfset session.add3 = ""> 
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

<CFTRANSaction action="Begin">
	<CFTRY>
<cfquery name="qUpdate_Address" datasource="#application.speakerDSN#">
	Update address 
	Set speakerid='#speakerid#', 
	    add1='#Left(Form.add1, 75)#', 
		add2='#Left(session.add2, 75)#',
		add3='#Left(session.add3, 75)#', 
		city='#Left(Form.city, 35)#',
		state='#Left(Form.state, 4)#', 
		zipcode='#Left(Form.zipcode, 10)#', 
		mailtocountry='#Left(form.mailtocountry, 35)#', 
		busadd_1='#Left(Form.busadd_1, 75)#', 
		busadd_2='#Left(session.busadd_2, 75)#',
		busadd_3='#Left(session.busadd_3, 75)#', 
		buscity='#Left(Form.buscity, 35)#',
		busstate='#Left(Form.busstate, 4)#', 
		buszip='#Left(Form.buszip, 10)#', 
		buscountry='#Left(form.buscountry, 35)#' 
	Where add_id = #add_id# AND type = 'MOD'
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
This Address has not been edited. Please Contact IT for assistance.
</cfif>
</body>
</html>
