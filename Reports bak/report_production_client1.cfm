<html>
<head>
<title>Client Production Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!--- REMOVE STATUS = 0 WHEN LIVE --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
SELECT sm.year, sm.month, sm.day, sm.rowid, sm.project_code 
FROM schedule_meeting_time sm
WHERE left(sm.project_code,5) = '#session.select_criteria#' AND (sm.year BETWEEN #session.begin_year# AND #session.end_year#) AND (sm.month BETWEEN #session.begin_month# AND #session.end_month#)
ORDER BY sm.project_code, sm.year, sm.month, sm.day
</CFQUERY>

<!--- <CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
SELECT cl.client_code, c.client_proj, c.description, c.meeting_type
FROM client_code cl, client_proj c
WHERE cl.client_code = '#session.select_criteria#' <cfif session.select_criteria NEQ 0>AND c.client_code = cl.client_code</cfif> AND (c.status = 0 or c.status = 2 or c.status = 5)
</CFQUERY> --->

</head>

<body>

	<cfset bdate = CreateDate(#session.begin_year#,#session.begin_month#,1)>
	<cfset getLastDay = CreateDate(#session.end_year#,#session.end_month#,1)>
	<cfset eday = DaysInMonth(#getLastDay#)>
	<cfset edate = CreateDate(#session.end_year#,#session.end_month#,#eday#)>
	
	<cfset mMeetings=ArrayNew(2)>
	<cfset i = 1>
	<cfset num_mtgs = 0>
<!--- 	<cfset sMeetings = structNew()> --->

		<!--- <cfloop condition="bdate LTE edate"> --->
				
			<cfoutput query="qprojects">
				<cfset project_date = CreateDate(#qprojects.year#,#qprojects.month#,#qprojects.day#)>
				<!--- <cfset tmp = structInsert(sMeetings, "#rowid#","#qprojects.project_code##day#","#qprojects.day#")> --->
				
				<!--- <cfset sMeetings.project = #qprojects.project_code#>
				<cfset sMeetings.date = #DateFormat(project_date,"mm/dd")#>
						<cfif project_date EQ bdate>
				<cfset sMeetings.num_mtgs = num_mtgs + 1>
						</cfif> --->
				
				<!--- <cfset mMeetings[#i#][1] = #DateFormat(bdate,"mm/dd")#>
				<cfset mMeetings[#i#][2] = #qprojects.project_code#> --->
					<!--- <cfoutput> --->
				  <!--- 		<cfif project_date EQ bdate>
							<cfset num_mtgs = num_mtgs + 1>
						</cfif> --->
				  <!--- 	</cfoutput> --->
				<!--- <cfset mMeetings[#i#][3] = #num_mtgs#> --->
				<cfset num_mtgs = 0>
				<cfset i = i + 1>
			</cfoutput>	
		<cfoutput><cfset bdate = DateAdd("d",1,bdate)></cfoutput>
		<!--- </cfloop> --->

<cfoutput>
<table border="1" align="center" cellpadding="5" cellspacing="0">
	<!--- set variable with the 1st day of month, ex. 1/1 or 2/1 or 3/1 etc --->
	<cfset bdate = CreateDate(#session.begin_year#,#session.begin_month#,1)>
	<!--- find out what day of the week the first day of the month is --->
	<cfset fweek = DayofWeek(#bdate#)>
	<!--- Subtract this day integer from six to find out how many days are needed to get to Sat. --->
	<cfset adddays = 6 - fweek>
	<!--- Add days to the 1st day of the month to find the first Sat. of the month --->
	<cfset bweek = DateAdd("d",#adddays# + 1,#bdate#)>

	<tr>
			<td>&nbsp;</td>
		<!--- if begin week is less then or equal to end date, display --->
		<cfloop condition="bweek LTE edate">
			<td>#DateFormat(bweek,"mm/dd")#</td>
			<!--- add seven to find next Sat. --->
			<cfset bweek = DateAdd("d",7,bweek)>
		</cfloop>
	</tr>
	<!--- <cfloop from="1" to="#ArrayLen(mMeetings)#" step="1" index="x">
	<tr>
		<td>#mMeetings[x][2]#</td>
		<td>#mMeetings[x][3]# - #mMeetings[x][1]#</td>
	</tr>
	</cfloop> --->
<!--- 	<cfloop collection="#sMeetings#" item="rowid">
	<tr><td>#structFind(sMeetings, rowid)#</td></tr>
	<!--- <tr><td>#sMeetings.project#</td><td>#sMeetings.date#</td><td>#sMeetings.num_mtgs#</td></tr> --->
	</cfloop> --->
</table>
</cfoutput>
</body>
</html>
