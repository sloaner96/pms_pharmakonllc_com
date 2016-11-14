<!----Moderator Master Schedule

report_master_schedule3.cfm

This is the Excel Version of the File. Does the same thing as report_master_schedule2.cfm


--------------------------------------->

<cfset OutputArray = ArrayNew(1)>
<cfset r = 1>


	<cfset strUnavail = "">

	<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
	<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>

	<!--- store today's date --->
	<cfset today = #BeginingDate#>
	<!--- store what day of the week it is...Sunday=1, Monday=2, tuesday=3, etc --->
	<cfset todayint = #DayofWeek(today)#>
	<!--- Set this week equal to sunday of this week (1st day of the week equal to today minus the day of the week today is).--->
	<cfset thisweek = DateAdd("d",-#todayint# + 1,#today#)>
	<!--- Set first day of last week (Sunday) --->
	<cfset startday = DatePart("d",#thisweek#)>
	<cfset startmonth = DatePart("m",#thisweek#)>
	<cfset startyear = Year(#thisweek#)>
	<!--- create start date --->
	<cfset startdate = CreateDate(#startyear#,#startmonth#,#startday#)>
	<!--- Set last day (Sat) of two weeks from this week --->
	<cfset endweek = #EndingDate#>
	<cfset endmonth = DatePart("m",#EndingDate#)>
	<cfset endyear = Year(#endweek#)>
	<cfset endday = DatePart("d",#endweek#)>
	<cfset enddate = CreateDate(#endyear#,#endmonth#,#endday#)>

	<CFSET aMeetings=ArrayNew(2)>

	<cfset i = 1>
	<!--- set variable with the first day of the schedule --->
	<cfset xstart = DateFormat("#thisweek#", "m/d/yy")>


	<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getModerators'>
		SELECT speakerid, firstname, lastname
		FROM Speaker
		WHERE active = 'yes'
		and type = 'MOD'
		ORDER BY speakerid
	</CFQUERY>


	<cfset aModeratorArray = ArrayNew(1)>
	<cfset aModeratorNameArray = ArrayNew(1)>

		<cfset aUnavail = ArrayNew(2)>
		<cfset b = 1>

	<cfoutput query="getModerators">
		<cfset aModeratorArray[currentrow] = #getModerators.speakerid#>
		<cfset aModeratorNameArray[currentrow] = #trim(getModerators.firstname)# & " " & #trim(getModerators.lastname)#>

			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetUnavailable">
			SELECT allday, year, month, day, speakerid
			FROM availability_time
			WHERE speakerid = #getModerators.speakerid#
			AND allday = 0
			AND (year BETWEEN #datepart('yyyy',startdate)# AND #datepart('yyyy',enddate)#)
			<cfif month(startdate) EQ 12>
			AND (month = 12 OR month = 1)
			<cfelse>
			AND (month BETWEEN #datepart('m',startdate)# AND #datepart('m',enddate)#)
			</cfif>
			ORDER BY speakerid
		</CFQUERY>

		<cfloop query="GetUnavailable">
			<cfset unavaildate = CreateDate(#GetUnavailable.year#, #GetUnavailable.month#, #GetUnavailable.day#)>
			<cfif DayOfWeek(unavaildate) NEQ 1 AND DayOfWeek(unavaildate) NEQ 7 AND DayOfWeek(unavaildate) NEQ 6>
				<cfset aUnavail[#b#][1] = #speakerid#>
				<cfset aUnavail[#b#][2] = DateFormat(unavaildate,'full')>
				<cfset b = b + 1>
			</cfif>
		</cfloop>



	</cfoutput>

	<!--- <cfdump var="#aUnavail#"> --->
	<cfset strModeratorList = #ArrayToList(aModeratorArray, ",")#>


	<cfset OutputArray[r] = "<html><head></head><body><table border='1' cellpadding='0' cellspacing='0'><tr><td style='background-color: ##CCCCCC'>Date</td>">
	<cfset r = #r# + 1>

	<cfoutput query="getModerators">
		<cfset ModeratorName = #trim(getModerators.firstname)# & " " & #trim(getModerators.lastname)#>
		<cfset OutputArray[r] = "<td style='background-color: ##CCCCCC; font-size: 7pt'><cfoutput><strong>#ModeratorName#</strong></cfoutput></td>">
		<cfset r = #r# + 1>
	</cfoutput>

	<cfset OutputArray[r] = "</tr>">
	<cfset r = #r# + 1>

	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetMeetings">
		SELECT m.project_code, m.meeting_code, m.start_time, m.staff_id, m.meeting_date, m.speakerid,
				s.codeDesc as staff_description
		FROM ScheduleSpeaker m, lookup s
		WHERE m.staff_id IN (#strModeratorList#) 
		AND (m.meeting_date BETWEEN #startdate# AND #enddate#)
		AND m.status = 0 
		AND m.staff_type = s.codeValue
		AND S.Codegroup = 'STAFFCODES'
		GROUP BY m.meeting_code, m.project_code, m.start_time, m.staff_id, m.meeting_date, m.speakerid,
		 s.CodeDesc
		ORDER BY m.meeting_date, m.start_time, m.meeting_code,  m.staff_id
	</CFQUERY>

	<cfscript>
		 meeting = ArrayNew(2);
	</cfscript>
	<cfoutput query="GetMeetings">
		<cfset meeting[currentrow][1] = #GetMeetings.project_code#>

		<!--- Set the starting time minutes --->
		<cfif Mid(GetMeetings.start_time, 3, 2) EQ 50>
			<cfset start_min = 30>
		<cfelse>
			<cfset start_min = Mid(GetMeetings.start_time, 3, 2)>
		</cfif>

		<!--- Convert meeting start time to Civilian Time --->
		<cfset TimeCreated = CreateTime(Left(GetMeetings.start_time, 2),start_min,00)>
		<cfset CivilianTime = TimeFormat(TimeCreated,'h:mmtt')>

		<cfset meeting[currentrow][2] = #CivilianTime#>
		<cfset meeting[currentrow][3] = #GetMeetings.staff_id#>
		<cfset meeting[currentrow][4] = #DateFormat(GetMeetings.meeting_date, "full")#>
		<!--- <cfset meeting[currentrow][5] = #GetMeetings.speakerid#> --->
		<cfset meeting[currentrow][5] = #GetMeetings.meeting_code#>
	<cfif trim(GetMeetings.staff_description) NEQ 'Moderator'>
		<cfset meeting[currentrow][6] = #GetMeetings.staff_description#>
	<cfelse>
		<cfset meeting[currentrow][6] = ' '>
	</cfif>
		<cfset meeting[currentrow][7] = #trim(GetMeetings.project_code)#>
	</cfoutput>

	<!--- <cfdump var="#meeting#"><cfabort> --->
	<!--- outer loop through each day of the moderator's schedule --->
		<cfloop condition="xstart LTE endweek">

			<!--- set the 1st cell with the date, set the other 4 with 0 just to hold place for now --->
			<cfset aMeetings[#i#][1] = DateFormat("#xstart#", "full")>
			<cfset aMeetings[#i#][2] = 0>
			<cfset aMeetings[#i#][3] = 0>
			<cfset aMeetings[#i#][4] = 0>
			<cfset aMeetings[#i#][5] = 0>
			<cfset aMeetings[#i#][6] = DayofWeek(#xstart#)>
			<cfset aMeetings[#i#][7] = Week(#xstart#)>

			<cfset i = i + 1>
			<cfset xstart = DateAdd("d",1,#xstart#)>
		</cfloop>

		<!--- loop through the date range selected --->
		<cfloop from="1" to="#ArrayLen(aMeetings)#" index="x" step="1">
			<cfif #aMeetings[x][6]# EQ 1>
				<cfset OutputArray[r] = "<cfoutput><tr><td style='background-color: ##CCCCCC; font-size: 7pt'>Week #aMeetings[x][7]#</td><td style='background-color: ##CCCCCC; font-size: 7pt' colspan='#ArrayLen(aModeratorNameArray)#'>&nbsp;</td></tr></cfoutput>">
				<cfset r = #r# + 1>
			</cfif>
			<cfset OutputArray[r] = "<tr><td style='font-size: 7pt'><cfoutput>#aMeetings[x][1]#</cfoutput></td>">
			<cfset r = #r# + 1>
				<!--- loop the meetings for each moderator --->
				<cfloop from="1" to="#ArrayLen(aModeratorNameArray)#" index="l" step="1">

					<cfset OutputArray[r] = "<td style='font-size: 7pt'>">
					<cfset r = #r# + 1>
					<cfloop from="1" to="#GetMeetings.recordcount#" index="y" step="1">
						<cfif #meeting[y][4]# EQ #aMeetings[x][1]# AND #aModeratorArray[l]# EQ #meeting[y][3]#>

						<cfset strMeeting =  #meeting[y][6]# & " " & #meeting[y][1]# & " " &  #meeting[y][2]#>
						<!--- If this meeting has a speaker, pull his/her name --->
						<cfif ListFind(session.nospeaker, right(meeting[y][7],2)) EQ 0>
						<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetSpeaker">
						SELECT m.staff_id, s.lastname
						FROM speaker.dbo.Speaker s, projman.dbo.ScheduleSpeaker m
						WHERE m.meeting_code = '#meeting[y][5]#' AND (staff_type = 2  OR staff_type = 5 ) AND s.speakerid = m.staff_id
						</CFQUERY>
							<cfif #GetSpeaker.recordcount#>
								<cfset strMeeting = #strMeeting# & " - " & #trim(GetSpeaker.lastname)#>
							</cfif>
						</cfif>
							<cfset OutputArray[r] = "<cfoutput>#strMeeting#</cfoutput><br>">
							<cfset r = #r# + 1>
						<cfelse>
							<cfset OutputArray[r] = "">
							<cfset r = #r# + 1>
						</cfif>
					</cfloop>
							<cfset strUnavail = "">
							<cfloop from="1" to="#ArrayLen(aUnavail)#" index="h" step="1">
								<cfif #aUnavail[h][1]# EQ #aModeratorArray[l]# AND #aUnavail[h][2]# EQ #ameetings[x][1]#>
									<cfset strUnavail = "Unavailable">
								</cfif>
							</cfloop>
							<cfset OutputArray[r] = "">
							<cfset r = #r# + 1>
					<cfset OutputArray[r] = "#strUnavail#</td>">
					<cfset r = #r# + 1>
				</cfloop>
			<cfset OutputArray[r] = "</tr>">
			<cfset r = #r# + 1>
		</cfloop>
<cfset OutputArray[r] = "</table></body></html>">

<cfset temp = #ArrayToList(OutputArray, " ")#>
	<!--- <cfdump var="#meeting#"><cfabort> --->
<!--- <cfset report_path = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.htm"> --->
<cffile action="write" file="#application.ReportPath#/rpt_temp.htm" nameconflict="overwrite" output="#temp#">
<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#application.ReportPath#/rpt_temp.htm">

