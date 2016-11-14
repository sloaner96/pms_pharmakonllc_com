<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	venu_Edit_Comment_Action.cfm
	performs queries to update comments including: date, type message
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Update Venue Comments</title>
	
</head>

<body>

 <cfset commitIt = "yes">

<CFTRANSACTION Action="Begin">
	<CFTRY> 
<cfquery name="qUpdateComments" datasource="#application.speakerDSN#">
	Update comments 
	Set owner_id='#venue_id#',
		owner_type='VENU', comment='#trim(Left(form.comment, 250))#', comment_type='#form.comment_type#', date_created=#Now()#, updated_by=#session.userinfo.rowid#
	Where comment_id = #comment_id# AND owner_type = 'VENU'
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

<cfif commitIt EQ "yes"> 
<cflocation url="venu_comments_details.cfm?venue_id=#venue_id#&sortby=#URLEncodedFormat(sortby)#&order=#URLEncodedFormat(order)#&no_menu='1'">
 <cfelse>
This Comment has not been edited. Please contact IT for assistance.
</cfif> 
</body>
</html>