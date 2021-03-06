<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	mod_Edit_CV_action.cfm
	performs queries to update dates for cv, w9 and contryes
	
	lb060201-  Initial code.
	rws101505 - added new header, cleaned up HTML
------------------------------------------------------------------------------
--->
<head>
	<title>Add Moderator CV/W9 action</title>
<!--- check for null dates --->
<CFIF #parameterexists(form.consult_agreedatebox)#>
<CFSET consult_agreedate = #form.consult_agreedatebox#>
<CFELSE>
<CFSET consult_agreedate = "">
</CFIF>

<CFIF #parameterexists(form.w9datebox)#>
<CFSET w9date = #form.w9datebox#>
<CFELSE>
<CFSET w9date = "">
</CFIF>

<CFIF #parameterexists(form.cvdatebox)#>
<CFSET cvdate = #form.cvdatebox#>
<CFELSE>
<CFSET cvdate = "">
</CFIF>

	
</head>

<body>

	 <cfset commitIt = "yes">

<CFTRANSaction action="Begin">
	<CFTRY> 	
	<cfoutput>
<cfquery name="qUpdateCV" datasource="#application.speakerDSN#">
	Update Speaker 
	Set date_updated=#Now()# <cfif trim(cvdate) is not "">,cv=#createodbcdate(cvdatebox)#<cfelse>,cv=Null</cfif> <cfif trim(consult_agreedate) is not "">,consult_agree=#createodbcdate(consult_agreedate)#<cfelse>,consult_agree=Null</cfif> <cfif trim(w9date) is not "">,w9=#createodbcdate(w9date)#<cfelse>,w9=Null</cfif> 
	Where speakerid = #form.speakerid# AND type = 'MOD'
</cfquery></cfoutput>

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
This information has not been inserted. Please Contact IT for assistance.
</cfif> 
</body>
</html>
