<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!----------------------------------------------------------------------------
	venu_Add_Comment_Action.cfm
	Inserts comment to database
	
	lb070101-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
	<title>Add Venue Comment Action</title>
	
</head>

<body>

	<cfset commitIt = "yes">
	<CFTRANSACTION Action="Begin">
	<CFTRY>
		
<!--- Insert new comment --->		
<cfquery name="qInsertNewComment" datasource="#application.speakerDSN#">
	Insert into comments (owner_id, owner_type, comment, comment_type, date_created, updated_by)  
	Values(#venue_id#,'VENU','#trim(Left(form.comment, 250))#', '#comment_type#', #Now()#, #session.userinfo.rowid#)
</cfquery>
	
	<cfcatch type="Database">
	<Cftransaction Action="Rollback"/>
	<CFSET CommitIt = "no">
	</Cfcatch>
	</cftry>

	<cfif CommitIt EQ "yes">
	<cftry>
	
<!--- Update Date Updated Field for venue --->
<cfquery name="qUpdateDate" datasource="#application.speakerDSN#">
	Update venues 
	Set date_updated=#Now()#
	Where venue_id = #venue_id#
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
	
	<cflocation url="venu_comments_details.cfm?venue_id=#venue_id#&sortby=#sortby#&order=#order#&no_menu='1'">
	<cfelse>
This Comment has not been inserted. Please contact IT for assistance.
	</cfif>
</body>
</html>
