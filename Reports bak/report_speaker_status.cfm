<!---------------------------------------
report_speaker_status.cfm

Shows total meeting per speaker and per project.  All speakers can be shown or just one.

------------------------------------------->



<!----There are too many speakers to display them all in an excel spreadsheet.  To advoid this, only pull the 
speakers that have actually participated in a meeting. ------>

<!----Pull all speakers that have actually participated in a meeting---->
<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getActSpeakers' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
	SELECT DISTINCT speaker_id
	FROM schedule_meeting_time
</CFQUERY>

<!----Put the results of that query in an array----->
<cfset ParticipatingSpeakers = ArrayNew(1)>
<cfoutput query="getActSpeakers">
	<cfset ParticipatingSpeakers[currentRow] = #getActSpeakers.speaker_id#>
</cfoutput>

<!----Make the array a list----->
<cfset ListSpeakers = #ArrayToList(ParticipatingSpeakers, ",")#>

<!----Get all the projects on the database that have occured or will occur. ---->
<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getProjects' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
	SELECT DISTINCT project_code
	FROM schedule_meeting_time
	WHERE (meeting_date BETWEEN #session.begin_date# AND #session.end_date#)
	AND status = 0
	<cfif #session.select_criteria# NEQ 0>AND speaker_id = #session.select_criteria#</cfif>
</CFQUERY>

<!----Get all the active Speakers that have actually particiapte in a meeting.--->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getSpeakers">
	SELECT speaker_id, lastname, firstname
	FROM spkr_table
	WHERE active = 'ACT' AND type = 'SPKR'
	<cfif #session.select_criteria# NEQ 0>AND speaker_id = #session.select_criteria#<cfelse>AND speaker_id IN (#ListSpeakers#)</cfif>
	ORDER BY firstname
</CFQUERY>

<!---Set an array so that when we are looping the projects we can refer to the array and 
dont have to worry about looping the speaker query inside the project query--->
<cfset SpeakerArray = ArrayNew(1)>
<cfoutput query="getSpeakers">
	<cfset SpeakerArray[currentRow] = #getSpeakers.speaker_id#>
</cfoutput>

<cfset row = 1>
<cfset SpeakerTotal = ArrayNew(2)>

<cfset DisplayOutput = ArrayNew(1)>
<cfset output = 1>

<cfset DisplayOutput[output] = "<html><head><title>Project Management System || Speaker Status Report</title></head><body><table border='1' cellpadding='0' cellspacing='0' width='100%'><tr><td>Project</td><td>Code</td>">
<cfset output = #output# + 1>

		<cfoutput query="getSpeakers">
			<cfset DisplayOutput[output] = "<td>#trim(getSpeakers.firstname)# #trim(getSpeakers.lastname)#</td>">
			<cfset output = #output# + 1>
		</cfoutput>
		
		<cfset DisplayOutput[output] = "<td><strong>Total</strong></td></tr>">
		<cfset output = #output# + 1>
	
	<cfscript>
		ProjectName = createObject("component","pms.com.cfc_get_name");
	</cfscript>
	
	<cfset ProjectGrandTotal = 0>
	
	<cfoutput query="getProjects">
		<cfscript>
			projName = ProjectName.getProjName(ProjCode="#getProjects.project_code#");
		</cfscript>
		
		<cfset DisplayOutput[output] = "<tr><td>#projName#</td><td>#getProjects.project_code#</td>">
		<cfset output = #output# + 1>
						
			<cfset ProjectTotal = 0>
			
			
			<cfloop from="1" to="#ArrayLen(SpeakerArray)#" index="m" step="1">
				
				<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getMeetingCount' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
					SELECT COUNT(project_code) as meetCount
					FROM schedule_meeting_time
					WHERE (meeting_date BETWEEN #session.begin_date# AND #session.end_date#)
					AND status = 0 
					AND speaker_id = #SpeakerArray[m]# 
					AND project_code = '#getProjects.project_code#'
				</CFQUERY>
				
				<cfset SpeakerTotal[row][m] = #getMeetingCount.meetCount#>
				
				<cfif #m# EQ #ArrayLen(SpeakerArray)#>
					<cfset row = #row# + 1>
				</cfif>
				
				<cfif getMeetingCount.recordcount>
					<cfset DisplayOutput[output] = "<td>#getMeetingCount.meetCount#</td>">
					<cfset output = #output# + 1>
					
					<cfset ProjectTotal = #ProjectTotal# + #getMeetingCount.meetCount#>
					<cfset ProjectGrandTotal = #ProjectGrandTotal# + #getMeetingCount.meetCount#>
				<cfelse>
					<cfset ProjectTotal = #ProjectTotal# + 0>
					<cfset ProjectGrandTotal = #ProjectGrandTotal# + 0>
					
					<cfset DisplayOutput[output] = "<td>&nbsp;</td>">
					<cfset output = #output# + 1>
					
				</cfif>
			</cfloop>
			
			<cfset DisplayOutput[output] = "<td><strong>#ProjectTotal#</strong></td></tr>">
			<cfset output = #output# + 1>
			
	</cfoutput>
	
		<cfset DisplayOutput[output] = "<tr><td colspan='2' align='right'><strong>Grand Totals</strong></td>">
		<cfset output = #output# + 1>
		
		<cfloop from="1" to="#ArrayLen(SpeakerArray)#" index="column" step="1">
		<cfset sumofColumn = 0>
			<cfloop from="1" to="#getProjects.recordcount#" index="proj" step="1">
				<cfset sumofColumn = #sumofColumn# + #SpeakerTotal[proj][column]#>
			</cfloop>
			
			<cfset DisplayOutput[output] = "<td><cfoutput>#sumofColumn#</cfoutput></td>">
			<cfset output = #output# + 1>
				
		</cfloop>
		
		<cfset DisplayOutput[output] = "<td><strong><cfoutput>#ProjectGrandTotal#</cfoutput></strong></td></tr></table></body></html>">
		<cfset output = #output# + 1>
		
		<cfset #report_path# = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.htm">
		
		<cfset temp = #ArrayToList(DisplayOutput, " ")#>
		<cffile action="write" file="#report_path#" nameconflict="overwrite" output="#temp#">
		<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#report_path#">