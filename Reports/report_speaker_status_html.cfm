<!---------------------------------------
report_speaker_status.cfm

Shows total meeting per speaker and per project.  All speakers can be shown or just one.

------------------------------------------->
<html>
<head>
<title>Project Management System || Speaker Status Report</title>
</head>

<body>


<!----There are too many speakers to display them all in an excel spreadsheet.  To advoid this, only pull the 
speakers that have yesually participated in a meeting. ------>

<!----Pull all speakers that have yesually participated in a meeting---->
<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getyesSpeakers' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
	SELECT DISTINCT speakerid
	FROM ScheduleSpeaker
</CFQUERY>

<!----Put the results of that query in an array----->
<cfset ParticipatingSpeakers = ArrayNew(1)>
<cfoutput query="getyesSpeakers">
	<cfset ParticipatingSpeakers[currentRow] = #getyesSpeakers.speakerid#>
</cfoutput>

<!----Make the array a list----->
<cfset ListSpeakers = #ArrayToList(ParticipatingSpeakers, ",")#>

<!----Get all the projects on the database that have occured or will occur. ---->
<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getProjects' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
	SELECT DISTINCT project_code
	FROM ScheduleSpeaker
	WHERE (meeting_date BETWEEN #session.begin_date# AND #session.end_date#)
	AND status = 0
	<cfif #session.select_criteria# NEQ 0>AND speakerid = #session.select_criteria#</cfif>
</CFQUERY>

<!----Get all the active Speakers that have yesually particiapte in a meeting.--->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getSpeakers">
	SELECT speakerid, lastname, firstname
	FROM Speaker
	WHERE active = 'yes' AND type = 'SPKR'
	<cfif #session.select_criteria# NEQ 0>AND speakerid = #session.select_criteria#<cfelse>AND speakerid IN (#ListSpeakers#)</cfif>
	ORDER BY firstname
</CFQUERY>


<!---Set an array so that when we are looping the projects we can refer to the array and 
dont have to worry about looping the speaker query inside the project query--->
<cfset SpeakerArray = ArrayNew(1)>
<cfoutput query="getSpeakers">
	<cfset SpeakerArray[currentRow] = #getSpeakers.speakerid#>
</cfoutput>

<cfset row = 1>
<cfset SpeakerTotal = ArrayNew(2)>
<table border="1" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>Project</td>
		<td>Code</td>
		<cfoutput query="getSpeakers">
			<td>#trim(getSpeakers.firstname)# #trim(getSpeakers.lastname)#</td>
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
			
			
			<cfloop from="1" to="#ArrayLen(SpeakerArray)#" index="m" step="1">
				
				<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getMeetingCount' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
					SELECT COUNT(project_code) as meetCount
					FROM ScheduleSpeaker
					WHERE (meeting_date BETWEEN #session.begin_date# AND #session.end_date#)
					AND status = 0 
					AND speakerid = #SpeakerArray[m]# 
					AND project_code = '#getProjects.project_code#'
				</CFQUERY>
				
				<cfset SpeakerTotal[row][m] = #getMeetingCount.meetCount#>
				
				<cfif #m# EQ #ArrayLen(SpeakerArray)#>
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
		<cfloop from="1" to="#ArrayLen(SpeakerArray)#" index="column" step="1">
		<cfset sumofColumn = 0>
			<cfloop from="1" to="#getProjects.recordcount#" index="proj" step="1">
				<cfset sumofColumn = #sumofColumn# + #SpeakerTotal[proj][column]#>
			</cfloop>
			<td><cfoutput>#sumofColumn#</cfoutput></td>	
		</cfloop>
		<td><strong><cfoutput>#ProjectGrandTotal#</cfoutput></strong></td>
	</tr>	
</table>

</body>
</html>