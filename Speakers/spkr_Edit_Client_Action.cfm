<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Update Clients</title>
	
</head>


<body>


 <cfset commitIt = "yes">

<CFTRANSaction action="Begin">
	<CFTRY> 
<cfquery name="qDelete rows" datasource="#application.speakerDSN#">
	delete FROM speaker_clients
    WHERE speakerid = #speakerid# AND type = 'SPKR'
</cfquery>
 <cfcatch type="Database">
		<Cftransaction action="Rollback"/>
		<CFSET CommitIt = "no">
	</Cfcatch>
	</cftry>
	
	<cfif CommitIt EQ "yes">
	<cftry> 
	<cfif #parameterexists(form.client)#>
<cfloop index="client_index" list="#form.client#" delimiters=","> 
	<cfquery name="qAddClients" datasource="#application.speakerDSN#">
	Insert into speaker_clients (speakerid, client, type)  
	Values('#speakerid#',#client_index#, 'SPKR')
</cfquery>
</cfloop>
</cfif>
 <cfcatch Type="Database">
		<cftransaction action="rollback"/>
		<cfset commitIt="No">
	</cfcatch>
	</cftry>
	</cfif>


</cftransaction>


<cfif commitIt EQ "yes"> 
<cfoutput> 
<META HTTP-EQUIV="Refresh" CONTENT="0;URL=spkr_edit_bridge.cfm?speakerid=#speakerid#&no_menu='1'">
</cfoutput> 
 <cfelse>
This Address has not been edited. Please Contact IT for assistance.
</cfif> 
</body>
</html>
