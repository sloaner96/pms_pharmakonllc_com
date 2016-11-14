<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!----------------------------------------------------------------------------
	venu_Delete_Comment.cfm
	Deletes Comments
	
	lb070201-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
	<title>Delete Venue Comments</title>
	
</head>

<body>


	 <cfset commitIt = "yes">

	<CFTRANSACTION Action="Begin">
	<CFTRY>	
	
	
<CFQUERY NAME="qdeleteComment" datasource="#application.speakerDSN#">
    delete FROM comments
    WHERE comment_id = #comment_id# AND owner_type = 'VENU'
</CFQUERY>
	<cfcatch type="Database">
		<Cftransaction Action="Rollback"/>
		<CFSET CommitIt = "no">
	</Cfcatch>
	</cftry>




	</cftransaction>

<cfif commitIt EQ "yes">
<cfoutput> 
<cflocation url="venu_comments_details.cfm?venue_id=#venue_id#&sortby=#URLEncodedFormat(sortby)#&order=#URLEncodedFormat(order)#&no_menu='1'">
</cfoutput> 
<cfelse>
This Comment has not been deleted. Please contact IT for assistance.
</cfif>
</body>
</html>