<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	mod_Edit_Product_action.cfm
	performs queries to update moderators employers, fees, comments
	
	lb060201-  Initial code.
	rws101505 - added new header, cleaned up HTML
------------------------------------------------------------------------------
--->
<head>
	<title>Update Clients</title>
	
</head>

 <body>
  <cfif edit_action EQ "delete">
 	<CFQUERY NAME="qdeleteclient" datasource="#application.speakerDSN#">
    delete FROM speaker_clients
    WHERE rowid = #URL.rowid#
</CFQUERY>
 
<cfelse>
 
<!--- pulls clients and products that speaker works for
This query pulls from both projman and speaker dbs --->	
<cfquery name="qgetclients" datasource="#application.projdsn#">
	SELECT 	s.client_code, s.comments, c.client_code_description, s.fee, s.rowid
	FROM speaker.dbo.speaker_clients s, projman.dbo.client_code c
	WHERE s.speakerid = #speakerid# AND s.type = 'MOD' AND c.client_code = s.client_code
	ORDER By c.client_code
</cfquery>
	
	<cfoutput query="qgetclients">
<cfquery DATASOURCE="#application.speakerDSN#" name="updateclient" >
		update speaker_clients 
		set fee = #LSParseNumber(Evaluate('form.fee'&qgetclients.CurrentRow))#,
		comments = '#Evaluate('form.comments'&qgetclients.CurrentRow)#'
		where rowid = #Evaluate('form.rowid'&qgetclients.CurrentRow)#
</cfquery>
</cfoutput>
</cfif>

<cfoutput> 
<META HTTP-EQUIV="Refresh" CONTENT="0;URL=mod_edit_bridge.cfm?speakerid=#speakerid#&no_menu='1'">
</cfoutput>


</body>
</html>
