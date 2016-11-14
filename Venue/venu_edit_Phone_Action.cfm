<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	venu_Edit_Phone_Action.cfm
	performs queries to update phone info including: primary phone, fax, cell, email, service, pager AND secondary phone, fax, cell, email, service, pager
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Edit Phone Action</title>

</head>


<body>


<cfset commitIt = "yes">

<CFTRANSACTION Action="Begin">
	<CFTRY>
<cfquery name="qUpdate_Phone" datasource="#application.speakerDSN#">
	Update phone_details 
	Set owner_id='#venue_id#', owner_type='VENU', 
		 phone1='#Left(Form.phone1, 30)#', phone2='#Left(Form.phone2, 30)#', fax1='#Left(Form.fax1, 30)#', fax2='#Left(Form.fax2, 30)#', cell1='#Left(Form.cell1, 30)#', cell2='#Left(Form.cell2, 30)#', pager1='#Left(Form.pager1, 30)#', pager2='#Left(Form.pager2, 30)#', service1='#Left(Form.service1, 30)#', service2='#Left(Form.service2, 30)#', email1='#Left(Form.email1, 30)#', email2='#Left(Form.email2, 30)#'
	Where phone_id = #phone_id# AND owner_type = 'VENU'
</cfquery>
<cfcatch type="Database">
		<Cftransaction Action="Rollback"/>
		<CFSET CommitIt = "no">
	</Cfcatch>
	</cftry>
	
	<cfif CommitIt EQ "yes">
	<cftry>
	<!--- update updated date --->
	<cfquery name="UpdateDate" datasource="#application.speakerDSN#">
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
This phone has not been edited. Please contact IT for assistance.
</cfif>
</body>
</html>