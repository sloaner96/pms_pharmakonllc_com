<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	spkr_Edit_Comment_action.cfm
	performs queries to update comments including: date, type message
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Update Speaker Comments</title>
	
</head>

<body>

 <cfset commitIt = "yes">

<CFTRANSaction action="Begin">
	<CFTRY> 
<cfquery name="qUpdateComments" datasource="#application.speakerDSN#">
	Update comments 
	Set speakerid='#speakerid#',
		type='SPKR', comment='#trim(Left(form.comment, 500))#', comment_type='#form.comment_type#', date_created=#Now()#, updated_by=#session.userinfo.rowid#
	Where comment_id = #comment_id# AND type = 'SPKR'
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

<cfif commitIt EQ "yes"> 
<cflocation url="spkr_comments_details.cfm?speakerid=#speakerid#&sortby=#URLEncodedFormat(sortby)#&order=#URLEncodedFormat(order)#&no_menu='1'">
 <cfelse>
This Comment has not been edited. Please Contact IT for assistance.
</cfif> 
</body>
</html>