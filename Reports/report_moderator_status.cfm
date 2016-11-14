<!---------------------------------------
report_moderator_status.cfm

Shows total meeting per moderator and per project.  All moderators can be shown or just one.

------------------------------------------->


<!----Get all the projects on the database that have occured or will occur---->
<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getProjects' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
	SELECT DISTINCT project_code
	FROM ScheduleSpeaker
	WHERE (meeting_date BETWEEN #session.begin_date# AND #session.end_date#)
	AND status = 0
	<cfif #session.select_criteria# NEQ 0>AND speakerid = #session.select_criteria#</cfif>
</CFQUERY>

<!----Get all the active Moderators--->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getModerators">
	SELECT speakerid, lastname, firstname
	FROM Speaker
	WHERE active = 'yes' AND type = 'MOD'
	<cfif #session.select_criteria# NEQ 0>AND speakerid = #session.select_criteria#</cfif>
	ORDER BY firstname
</CFQUERY>

<!---Set an array so that when we are looping the projects we can refer to the array and 
dont have to worry about looping the moderator query inside the project query--->
<cfset ModeratorArray = ArrayNew(1)>
<cfoutput query="getModerators">
	<cfset ModeratorArray[currentRow] = #getModerators.speakerid#>
</cfoutput>

<cfset DisplayOutput = ArrayNew(1)>
<cfset output = 1>

<cfset DisplayOutput[output] = "<html><head><title>Project Management System || Moderator Status Report</title></head><body>">
<cfset output = #output# + 1>

	<cfset row = 1>
	<cfset ModeratorTotal = ArrayNew(2)>

<cfset DisplayOutput[output] = "<table border='1' cellpadding='0' cellspacing='0' width='100%'><tr><td style='background-color: ##CCCCCC'>Project</td><td style='background-color: ##CCCCCC'>Code</td>">
<cfset output = #output# + 1>

		<cfoutput query="getModerators">
			<cfset DisplayOutput[output] = "<td style='background-color: ##CCCCCC;'>#trim(getModerators.firstname)# #trim(getModerators.lastname)#</td>">
			<cfset output = #output# + 1>
		</cfoutput>
		
<cfset DisplayOutput[output] = "<td style='background-color: ##CCCCCC'><strong>Total</strong></td></tr>">
<cfset output = #output# + 1>
	
	<cfscript>
		ProjectName = createObject("component","pms.com.cfc_get_name");
	</cfscript>
	
	<cfset ProjectGrandTotal = 0>
	
	<cfoutput query="getProjects">
		<cfscript>
			projName = ProjectName.getProjName(ProjCode="#getProjects.project_code#");
		</cfscript>
		
<cfset DisplayOutput[output] = "<tr><td>#projName#</td>	<td>#getProjects.project_code#</td>">
<cfset output = #output# + 1>
						
			<cfset ProjectTotal = 0>
			
			
			<cfloop from="1" to="#ArrayLen(ModeratorArray)#" index="m" step="1">
				
				<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getMeetingCount' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
					SELECT COUNT(project_code) as meetCount
					FROM ScheduleSpeaker
					WHERE (meeting_date BETWEEN #session.begin_date# AND #session.end_date#)
					AND status = 0 
					AND speakerid = #ModeratorArray[m]# 
					AND project_code = '#getProjects.project_code#'
				</CFQUERY>
				
				<cfset ModeratorTotal[row][m] = #getMeetingCount.meetCount#>
				
				<cfif #m# EQ #ArrayLen(ModeratorArray)#>
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
	
	<cfset DisplayOutput[output] = "<tr><td colspan='2' align='right' style='background-color: ##CCCCCC;'><strong>Grand Totals</strong></td>">
	<cfset output = #output# + 1>
		
		<cfloop from="1" to="#ArrayLen(ModeratorArray)#" index="column" step="1">
		<cfset sumofColumn = 0>
			<cfloop from="1" to="#getProjects.recordcount#" index="proj" step="1">
				<cfset sumofColumn = #sumofColumn# + #ModeratorTotal[proj][column]#>
			</cfloop>
			<cfset DisplayOutput[output] = "<td style='background-color: ##CCCCCC;'><cfoutput><strong>#sumofColumn#</strong></cfoutput></td>">	
			<cfset output = #output# + 1>
		</cfloop>
		<cfset DisplayOutput[output] = "<td style='background-color: ##CCCCCC;'><cfoutput><strong>#ProjectGrandTotal#</strong></cfoutput></td></tr></table></body></html>">


	<cfset #report_path# = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.htm">
	
	<cfset temp = #ArrayToList(DisplayOutput, " ")#>
	<cffile action="write" file="#report_path#" nameconflict="overwrite" output="#temp#">
	<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#report_path#">