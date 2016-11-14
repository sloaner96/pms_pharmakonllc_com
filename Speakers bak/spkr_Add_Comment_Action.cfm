<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!----------------------------------------------------------------------------
	spkr_Add_Comment_action.cfm
	Inserts comment to database
	
	lb070101-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
	<title>Add Speaker Comment action</title>
	
</head>

<body>

	<cfset commitIt = "yes">
	<CFTRANSaction action="Begin">
	<CFTRY>
		
<!--- Insert new comment --->		
<cfquery name="qInsertNewComment" datasource="#application.speakerDSN#">
	Insert into comments (speakerid, type, comment, comment_type, date_created, updated_by)  
	Values(#speakerid#,'SPKR','#trim(Left(form.comment, 500))#', '#comment_type#', #Now()#, #session.userinfo.rowid#)
</cfquery>
	
	<cfcatch type="Database">
	<Cftransaction action="Rollback"/>
	<CFSET CommitIt = "no">
	</Cfcatch>
	</cftry>

	<cfif CommitIt EQ "yes">
	<cftry>
	
<!--- Update Date Updated Field for speaker --->
<cfquery name="qUpdateDate" datasource="#application.speakerDSN#">
	Update Speaker 
	Set date_updated=#Now()#
	Where speakerid = #speakerid# AND type = 'SPKR'
</cfquery>

	<cfcatch Type="Database">
	<cftransaction action="rollback"/>
	<cfset commitIt="No">
	</cfcatch>
	</cftry>
	</cfif>

	</cftransaction>

<!--- if all queries performed ok, go back to details page. If not, give warning --->	
	<cfif commitIt EQ "yes">
	
	<cflocation url="spkr_comments_details.cfm?speakerid=#speakerid#&sortby=#sortby#&order=#order#&no_menu='1'">
	<cfelse>
This Comment has not been inserted. Please Contact IT for assistance.
	</cfif>
</body>
</html>
