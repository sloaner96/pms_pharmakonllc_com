<!---------------------------------------
report_moderator_status_html.cfm

This is the HTML version of report_moderator_status.cfm.  It is not used in the web, but rather to
use as an editing tool in case changes need to be made to the EXCEL report.

------------------------------------------->
<html>
<head>
<title>Project Management System || Moderator Status Report</title>
</head>

<body>


<!----Get all the projects on the database that have occured or will occur---->
<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getProjects' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
	SELECT DISTINCT project_code
	FROM schedule_meeting_time
	WHERE (meeting_date BETWEEN #session.begin_date# AND #session.end_date#)
	AND status = 0
</CFQUERY>

<!----Get all the active Moderators--->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getModerators">
	SELECT speaker_id, lastname, firstname
	FROM spkr_table
	WHERE active = 'ACT' AND type = 'MOD'
	ORDER BY firstname
</CFQUERY>

<!---Set an array so that when we are looping the projects we can refer to the array and 
dont have to worry about looping the moderator query inside the project query--->
<cfset ModeratorArray = ArrayNew(1)>
<cfoutput query="getModerators">
	<cfset ModeratorArray[currentRow] = #getModerators.speaker_id#>
</cfoutput>

<cfset row = 1>
<cfset ModeratorTotal = ArrayNew(2)>
<table border="1" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>Project</td>
		<td>Code</td>
		<cfoutput query="getModerators">
			<td>#trim(getModerators.firstname)# #trim(getModerators.lastname)#</td>
		</cfoutput>
		<td><strong>Total</strong></td>
	</tr>
	
	<cfscript>
		ProjectName = createObject("component","pms.com.cfc_get_name");
	</cfscript>
	
	<cfset ProjectGrandTotal = 0>
	
	<cfoutput query="getProjects">
		<cfscript>
			projName = ProjectName.getProjName(ProjCode="#getProjects.project_code#");
		</cfscript>
		<tr>
			<td>#projName#</td>
			<td>#getProjects.project_code#</td>
						
			<cfset ProjectTotal = 0>
			
			
			<cfloop from="1" to="#ArrayLen(ModeratorArray)#" index="m" step="1">
				
				<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getMeetingCount' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
					SELECT COUNT(project_code) as meetCount
					FROM schedule_meeting_time
					WHERE (meeting_date BETWEEN #BeginingDate# AND #EndingDate#)
					AND status = 0 
					AND moderator_id = #ModeratorArray[m]# 
					AND project_code = '#getProjects.project_code#'
				</CFQUERY>
				
				<cfset ModeratorTotal[row][m] = #getMeetingCount.meetCount#>
				
				<cfif #m# EQ #ArrayLen(ModeratorArray)#>
					<cfset row = #row# + 1>
				</cfif>
				
				<cfif getMeetingCount.recordcount>
					<td>#getMeetingCount.meetCount#</td>
					<cfset ProjectTotal = #ProjectTotal# + #getMeetingCount.meetCount#>
					<cfset ProjectGrandTotal = #ProjectGrandTotal# + #getMeetingCount.meetCount#>
				<cfelse>
					<cfset ProjectTotal = #ProjectTotal# + 0>
					<cfset ProjectGrandTotal = #ProjectGrandTotal# + 0>
					<td>&nbsp;</td>
				</cfif>
			</cfloop>
			<td><strong>#ProjectTotal#</strong></td>
		</tr>
	</cfoutput>
	<tr>
		<td colspan="2" align="right"><strong>Grand Totals</strong></td>
		<cfloop from="1" to="#ArrayLen(ModeratorArray)#" index="column" step="1">
		<cfset sumofColumn = 0>
			<cfloop from="1" to="#getProjects.recordcount#" index="proj" step="1">
				<cfset sumofColumn = #sumofColumn# + #ModeratorTotal[proj][column]#>
			</cfloop>
			<td><cfoutput>#sumofColumn#</cfoutput></td>	
		</cfloop>
		<td><strong><cfoutput>#ProjectGrandTotal#</cfoutput></strong></td>
	</tr>	
</table>

</body>
</html>


