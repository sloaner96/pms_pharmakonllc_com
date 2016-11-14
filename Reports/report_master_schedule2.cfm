<!----Moderator Master Schedule

report_master_schedule2.cfm
------->
<!--- <cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator Master Schedule" showCalendar="1">
 --->
<cfset OutputArray = ArrayNew(1)>
<cfset x = 1>
	
	
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
	<cfoutput query="getModerators">
		<cfset aModeratorArray[currentrow] = #getModerators.speakerid#>
		<cfset aModeratorNameArray[currentrow] = #trim(getModerators.firstname)# & " " & #trim(getModerators.lastname)#>
	</cfoutput>
	<cfset strModeratorList = #ArrayToList(aModeratorArray, ",")#>
		
	<table border='1' cellpadding='4px' cellspacing='0'>
		<tr>
			<td style='background-color: ##CCCCCC'>Date</td>
			<cfloop from="1" to="#ArrayLen(aModeratorNameArray)#" index="p" step="1">
				<td style='background-color: ##CCCCCC'><cfoutput>#aModeratorNameArray[p]#</cfoutput></td>
			</cfloop>
		</tr>
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetMeetings">
			SELECT DISTINCT m.meeting_code, m.project_code, m.start_time, m.speakerid, m.meeting_date, m.speakerid
			FROM ScheduleSpeaker m
			WHERE m.staff_id IN (#strModeratorList#) AND (m.meeting_date BETWEEN #startdate# AND #enddate#)
			AND m.status = 0
			GROUP BY m.meeting_code, m.project_code, m.start_time, m.speakerid, m.meeting_date, m.speakerid 
			ORDER BY m.meeting_code, m.meeting_date, m.speakerid					
		</CFQUERY>
		
		<cfscript>
			 meeting = ArrayNew(2);
		</cfscript>
		<cfoutput query="GetMeetings" group="meeting_code">
			<cfset meeting[currentrow][1] = #GetMeetings.project_code#>
			
			<cfset B_CivilianHour = #Left(GetMeetings.start_time, 2)#>
			<cfset B_CivilianMinute = #Mid(GetMeetings.start_time, 3, 2)#>
			
			<cfset B_Minute = "00">
			<cfif B_CivilianMinute EQ "50">
				<cfset B_Minute = "30">
			</cfif>
			
			<cfset B_Hour = #B_CivilianHour#>
			
			<cfset B_Meridiem = "PM">
			<cfif #B_Hour# GT 12 AND #B_Hour# NEQ 24>
				<cfset B_Hour = #B_Hour# - 12>
			<cfelseif #B_Hour# GT 12 AND #B_Hour# EQ 24>
				<cfset B_Hour = #B_Hour# - 12>
				<cfset B_Meridiem = "AM">
			<cfelseif #B_Hour# EQ 12>
				<cfset B_Meridiem = "PM">
			<cfelse>
				<cfset B_Meridiem = "AM">
			</cfif>
			
			<cfset CivilianTime1 = #ToString(B_Hour)#>
			<cfset CivilianTime2 = #ToString(B_Minute)#>
			<cfset CivilianTime = #CivilianTime1# & #CivilianTime2#>
			
			<cfset meeting[currentrow][2] = #CivilianTime#>
			<cfset meeting[currentrow][3] = #GetMeetings.speakerid#>
			<cfset meeting[currentrow][4] = #GetMeetings.meeting_date#>
			<cfset meeting[currentrow][5] = #GetMeetings.speakerid#>
		</cfoutput>
		
			<!--- outer loop through each day of the moderator's 4 week schedule --->
			<cfloop condition="xstart LTE endweek">
				
				<!--- set the 1st cell with the date, set the other 4 with 0 just to hold place for now --->
				<cfset aMeetings[#i#][1] = DateFormat("#xstart#", "m/d/yy")>
				<cfset aMeetings[#i#][2] = 0>
				<cfset aMeetings[#i#][3] = 0>
				<cfset aMeetings[#i#][4] = 0>
				<cfset aMeetings[#i#][5] = 0>
				<cfset aMeetings[#i#][6] = DayofWeek(#xstart#)>
				<cfset aMeetings[#i#][7] = Week(#xstart#)>
				
				<cfset i = i + 1>
				<cfset xstart = DateAdd("d",1,#xstart#)>
			</cfloop>
		
			<cfloop from="1" to="#ArrayLen(aMeetings)#" index="x" step="1">
				<cfif #aMeetings[x][6]# EQ 1>
					<cfoutput><tr><td style='background-color: ##CCCCCC'>Week #aMeetings[x][7]#</td><td style='background-color: ##CCCCCC' colspan="#ArrayLen(aModeratorNameArray)#">&nbsp;</td></tr></cfoutput>
				</cfif>
				<tr>
					<td><cfoutput>#aMeetings[x][1]#</cfoutput></td>
					<cfloop from="1" to="#ArrayLen(aModeratorNameArray)#" index="l" step="1">
						<td>
						<cfloop from="1" to="#GetMeetings.recordcount#" index="y" step="1">
							<cfif #meeting[y][4]# EQ #aMeetings[x][1]# AND #aModeratorArray[l]# EQ #meeting[y][3]#>
								<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakerName">
									SELECT lastname FROM Speaker WHERE speakerid = #meeting[y][5]#					
								</CFQUERY>
								<cfset strMeeting =  #meeting[y][1]# & " " &  #meeting[y][2]#>
								<cfif #GetSpeakerName.recordcount#>
									<cfset strMeeting = #strMeeting# & " - " & #trim(GetSpeakerName.lastname)#>
								</cfif>
								<cfoutput>#strMeeting#</cfoutput><br>
								<!--- <cfbreak> --->
							<cfelse>
								<cfset strMeeting = "&nbsp;">
							</cfif>
						</cfloop>
						</td>
							
					</cfloop>
				</tr>		
			</cfloop>				
	</table>
<!--- <cfmodule template="#Application.tagpath#/ctags/footer.cfm"> --->
