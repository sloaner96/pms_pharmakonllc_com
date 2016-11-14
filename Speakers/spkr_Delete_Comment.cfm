<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!----------------------------------------------------------------------------
	spkr_Delete_Comment.cfm
	Deletes Comments
	
	lb070201-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
	<title>Delete Speaker Comments</title>
	
</head>

<body>


	 <cfset commitIt = "yes">

	<CFTRANSaction action="Begin">
	<CFTRY>	
	
	
<CFQUERY NAME="qdeleteComment" datasource="#application.speakerDSN#">
    delete FROM comments
    WHERE comment_id = #comment_id# AND type = 'SPKR'
</CFQUERY>
	<cfcatch type="Database">
		<Cftransaction action="Rollback"/>
		<CFSET CommitIt = "no">
	</Cfcatch>
	</cftry>




	</cftransaction>

<cfif commitIt EQ "yes">
<cfoutput> 
<cflocation url="spkr_comments_details.cfm?speakerid=#speakerid#&sortby=#URLEncodedFormat(sortby)#&order=#URLEncodedFormat(order)#&no_menu='1'">
</cfoutput> 
<cfelse>
This Comment has not been deleted. Please Contact IT for assistance.
</cfif>
</body>
</html>