<!--- 
	*****************************************************************************************
	Name:		meeting_date_calendar.cfm
	Function:	Displays selected month and previous and next month for reference. 
				Each day can be one of two colors white for no meetings, 
				light blue for meetings. Clicking will change the color and when submitted change 
				the database. USE ARROWS TO NAVIGATE THROUGH MONTHS!
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Meeting Date Calendar" showCalendar="1">

<!--- The current month and date which were passed via URL from last form --->
<CFSET month = URL.month>
<CFSET year = URL.year>

<!--- Gets the date for the previous month and the next month --->
<CFSET temp_prev_date = DateAdd("m", -1, CreateDate(URL.year, URL.month, 1))>
<CFSET temp_next_date = DateAdd("m", 1, CreateDate(URL.year, URL.month, 1))>

<!--- Saves the month and year for the previous month --->
<CFSET month_previous = DateFormat(temp_prev_date, "m")>
<CFSET year_previous = DateFormat(temp_prev_date, "yyyy")>

<!--- Saves the month and year for the next month --->
<CFSET month_next = DateFormat(temp_next_date, "m")>
<CFSET year_next = DateFormat(temp_next_date, "yyyy")>

<!--- If a previous calendars days need to be recorded in the database --->
<!--- If we are at the first month, do not do this --->
<CFIF isDefined("URL.save")>

	<CFPARAM NAME="form.Day29" DEFAULT="-1">
	<CFPARAM NAME="form.Day30" DEFAULT="-1">
	<CFPARAM NAME="form.Day31" DEFAULT="-1">
	
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="Save_Schedule2">
		UPDATE schedule_meeting_date
		SET<CFLOOP INDEX="count" FROM=1 TO=30 STEP=1> x#count# = '#Evaluate("form.Day#count#")#',</CFLOOP> x31 = '#form.Day31#'
		WHERE month = '#URL.savemonth#' AND year = '#URL.saveyear#' AND Project_code = '#session.project_code#';
	</CFQUERY>

</CFIF>


<!--- Script that changes a calendar day to available/unavailable and changes the --->
<!--- value of the hidden field for that day --->
<SCRIPT LANGUAGE="JavaScript" src="popup_help.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function change_status_day(tempvar, DayStatus)
	{	
		if (tempvar.style.backgroundColor == '#ffffff')
			{
				tempvar.style.backgroundColor = 'BECCFF';
				DayStatus.value = "1";
			}
		else
			{
				tempvar.style.backgroundColor = 'FFFFFF';
				DayStatus.value = "0";
			}
	}
	
	function whichway(month, year, savemonth, saveyear, exit)
	{
		if( exit == '0')
		{
			form.action = "meeting_date_calendar.cfm?save=1&month=" + month + "&year=" + year + "&savemonth=" + savemonth + "&saveyear=" + saveyear;
		}
		else
		{
			form.action = "meeting_date_save.cfm?" + "&savemonth=" + savemonth + "&saveyear=" + saveyear;
		}
			
		form.submit();
	}
</SCRIPT>

<!--- Form that allows user to traverse through the valid months --->
<CFOUTPUT><FORM NAME="form" ACTION="" METHOD="post"></CFOUTPUT>

	
	<!--- <STYLE>
		TD {
				font-family : Verdana, Geneva, Arial;
				font-size : xx-small;
				text-align: center;
				background-color: #FFFFFF;
			}

		.DAYS {
				font-family : Verdana, Geneva, Arial;
				font-size : xx-small;
				font-weight: bold;
				text-align: center;
			}
		.WEEKS {
				font-family : ArialBold;
				font-size : xx-small;
				text-align: center;
			}
	</STYLE> --->
</HEAD>

<cfscript>
	ProjectName = createObject("component","pms.com.cfc_get_name");
	projName = ProjectName.getProjName(ProjCode="#session.Project_code#");
</cfscript>

<TABLE ALIGN="Center" WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
	<tr>
		<td align="center" style="font-size: 16px; font-family: arial; font-weight: bold; border-bottom: solid 1px navy; padding-bottom: 3px;">
		<cfoutput>#projName#</cfoutput>
		</td>
	</tr>
</table>
<TABLE ALIGN="Center" WIDTH="750" BORDER="0" CELLPADDING="0" CELLSPACING="0" style="margin-top: 5px;">
	<TR>

<!--- Begin First Mini Calendar --->
		
		<!--- Query to find if any days are already selected --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="Previous_Month_Calendar">
			SELECT *
			FROM Schedule_meeting_date
			WHERE month = '#month_previous#' AND year = '#year_previous#' AND Project_code = '#session.Project_code#';
		</CFQUERY>
		
		<TD ALIGN="left" WIDTH="125">
			<TABLE ALIGN="Center" BORDER="0" CELLPADDING="0" CELLSPACING="0">
				
				<TR ALIGN="Center" HEIGHT="15">
					<TD WIDTH="70%" COLSPAN="7"><B><CFOUTPUT>#MonthAsString(month_previous)#</CFOUTPUT></B></TD>
				</TR>
				
				<TR CLASS="Days" ALIGN="Center" HEIGHT="10">
					<TD WIDTH="10%">S</TD>
					<TD WIDTH="10%">M</TD>
					<TD WIDTH="10%">T</TD>
					<TD WIDTH="10%">W</TD>
					<TD WIDTH="10%">Th</TD>
					<TD WIDTH="10%">F</TD>
					<TD WIDTH="10%">Sa</TD>
				</TR>
				
				<!--- Starting Day of Month ---->
				<CFSET StartDay = DayOfWeek(CreateDate(year_previous, month_previous, 1))>
				
				<!--- Days in Month --->
				<CFSET DaysMonth = DaysInMonth(CreateDate(year_previous, month_previous, 1))>
				
				<CFSET DayNumbers = 1>
				<CFSET Counter = 1>
				
				<TR HEIGHT="10">
					<CFLOOP CONDITION = "DayNumbers EQ 1">
						<TD STYLE="background-color: <CFIF (#Evaluate('Previous_Month_Calendar.x#DayNumbers#')# EQ 1) AND (StartDay EQ Counter)>BECCFF<CFELSE>FFFFFF</CFIF>">
							<CFIF StartDay EQ Counter>
								<CFOUTPUT>#DayNumbers#</CFOUTPUT>
								<CFSET DayNumbers = 2>
							<CFELSE>
								&nbsp;
							</CFIF>
						</TD>
						<CFSET Counter = Counter + 1>
					</CFLOOP>
				
					<!--- 
						If the day number being processed is less than the amount of days in the month OR
						the number of the days is greater than the days in the month AND the remainder of the counter divided by seven is NOT one
						THEN continue with the loop; otherwise terminate the loop
					--->
					<CFLOOP CONDITION = "(DayNumbers LTE DaysMonth) OR  ((DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1))">
									
						<CFIF DayNumbers LTE DaysMonth>	<!--- Create rows of boxes with the date numbers in them --->
							<CFIF (Counter MOD 7) EQ 1>	<!--- Start a new row --->
								</TR>
								<TR HEIGHT="10">
									<TD STYLE="background-color: <CFIF #Evaluate('Previous_Month_Calendar.x#DayNumbers#')# EQ 1>BECCFF<CFELSE>FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
							<CFELSE>	<!--- Finish current row --->
									<TD STYLE="background-color: <CFIF #Evaluate('Previous_Month_Calendar.x#DayNumbers#')# EQ 1>BECCFF<CFELSE>FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
							</CFIF>
						<CFELSEIF (DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1)>	<!--- Complete current row of boxes before quitting --->
							<TD>&nbsp;</TD>
						</CFIF>	<!--- Quit on a complete row of boxes --->
						
						<!--- Increment the counter and the day numberer variables --->
						<CFSET DayNumbers = DayNumbers + 1>
						<CFSET Counter = Counter + 1>
					
					</CFLOOP>
			
				</TR>
				
			</TABLE>
		</TD>
				
<!--- End First Mini Calendar --->
		
		<!--- Month name for the current month (large calendar) --->
		<TD ALIGN="Center">
			<TABLE ALIGN="Center" WIDTH="100%" BORDER="0" CELLSPACING="6" CELLPADDING="0">
				<TR>
					<TD WIDTH="100%">
						<CFOUTPUT>
							<CFIF CreateDate(year,  month, 1) NEQ CreateDate(session.begin_year, session.begin_month, 1)>
								<INPUT TYPE="Image" NAME="Back" SRC="/images/back.jpg" onClick="whichway(#month_previous#, #year_previous#, #month#, #year#, 0)">
							</CFIF>
							&nbsp;&nbsp;&nbsp;&nbsp;<FONT SIZE="+1"><B>#MonthAsString(month)#</B></FONT>&nbsp;&nbsp;&nbsp;&nbsp;
							<CFIF CreateDate(year,  month, 1) NEQ CreateDate(session.end_year, session.end_month, 1)>
								<INPUT TYPE="Image" NAME="Forward" SRC="/images/forward.jpg" onClick="whichway(#month_next#, #year_next#, #month#, #year#, 0)">
							</CFIF>
						</CFOUTPUT>
					</TD>
				</TR>
				
				<TR ALIGN="Center">
					<TD ALIGN="Center" WIDTH="100%">
						
<!--- Begin Large Calendar --->
						<!--- Query to find if any days are already selected --->
						<CFQUERY DATASOURCE="#application.projdsn#" NAME="Main_Calendar">
							SELECT *
							FROM schedule_meeting_date
							WHERE month = '#month#' AND year = '#year#' AND Project_code = '#session.Project_code#';
						</CFQUERY>
						
						<TABLE ALIGN="Center" WIDTH="420" BORDER="1">
						
							<TR CLASS="Days" ALIGN="Center" HEIGHT="15">
								<TD WIDTH="60">Sun.</TD>
								<TD WIDTH="60">Mon.</TD>
								<TD WIDTH="60">Tues.</TD>
								<TD WIDTH="60">Wed.</TD>
								<TD WIDTH="60">Thu.</TD>
								<TD WIDTH="60">Fri.</TD>
								<TD WIDTH="60">Sat.</TD>
							</TR>
								
							<!--- Starting Day of Month ---->
							<CFSET StartDay = DayOfWeek(CreateDate(year, month, 1))>
							
							<!--- Days in Month --->
							<CFSET DaysMonth = DaysInMonth(CreateDate(year, month, 1))>
							
							<CFSET DayNumbers = 1>
							<CFSET Counter = 1>
							
							<TR HEIGHT="50">
								<CFLOOP CONDITION = "DayNumbers EQ 1">
									<TD onClick="return change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: <CFIF (#Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1) AND (StartDay EQ Counter)>BECCFF<CFELSE>FFFFFF</CFIF>">
										<CFIF StartDay EQ Counter>
											<INPUT TYPE="Hidden" NAME="Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>" VALUE="<CFOUTPUT>#Evaluate("Main_Calendar.x#DayNumbers#")#</CFOUTPUT>">
											<CFOUTPUT>#DayNumbers#</CFOUTPUT>
											<CFSET DayNumbers = 2>
										<CFELSE>
											&nbsp;
										</CFIF>
									</TD>
									<CFSET Counter = Counter + 1>
								</CFLOOP>
							
								<!--- 
									If the day number being processed is less than the amount of days in the month OR
									the number of the days is greater than the days in the month AND the remainder of the counter divided by seven is NOT one
									THEN continue with the loop; otherwise terminate the loop
								--->
								<CFLOOP CONDITION = "(DayNumbers LTE DaysMonth) OR  ((DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1))">
									
									<CFIF DayNumbers LTE DaysMonth>	<!--- Create rows of boxes with the date numbers in them --->
										<CFIF (Counter MOD 7) EQ 1>	<!--- Start a new row --->
											</TR>
											<TR HEIGHT="50">
												<TD onClick="change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: <CFIF #Evaluate('Main_Calendar.x#DayNumbers#')# EQ 1>BECCFF<CFELSE>FFFFFF</CFIF>"><INPUT TYPE="Hidden" NAME="Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>" VALUE="<CFOUTPUT>#Evaluate("Main_Calendar.x#DayNumbers#")#</CFOUTPUT>"><cfoutput>#DayNumbers#</cfoutput></TD>
										<CFELSE>	<!--- Finish current row --->
												<TD onClick="change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: <CFIF #Evaluate('Main_Calendar.x#DayNumbers#')# EQ 1>BECCFF<CFELSE>FFFFFF</CFIF>"><INPUT TYPE="Hidden" NAME="Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>" VALUE="<CFOUTPUT>#Evaluate("Main_Calendar.x#DayNumbers#")#</CFOUTPUT>"><cfoutput>#DayNumbers#</cfoutput></TD>
										</CFIF>
									<CFELSEIF (DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1)>	<!--- Complete current row of boxes before quitting --->
										<TD>&nbsp;</TD>
									</CFIF>	<!--- Quit on a complete row of boxes --->
									
									<!--- Increment the counter and the day numberer variables --->
									<CFSET DayNumbers = DayNumbers + 1>
									<CFSET Counter = Counter + 1>
								
								</CFLOOP>
						</TABLE>
						<BR>
						<!--- Exit Calendar scheduling program --->
						<CENTER>
							<TABLE WIDTH="100%">
								<TR>
									<TD COLSPAN="7">&nbsp;&nbsp;&nbsp;</TD>
								</TR>
								<TR>
									<TD style="background-color:#BECCFF; border: 1px solid black">&nbsp;&nbsp;&nbsp;</TD>
									<TD VALIGN="middle">Meetings take place</TD>
									<TD>&nbsp;&nbsp;&nbsp;</TD>
									<TD>
										<CFOUTPUT>
											<INPUT TYPE="Button"  VALUE="Save Schedule and Exit" onClick="whichway(0, 0, #month#, #year#, 1)"></CENTER>
										</CFOUTPUT>
									</TD>
									<TD>&nbsp;&nbsp;&nbsp;</TD>
									<TD style="background-color:#FFFFFF; border: 1px solid black">&nbsp;&nbsp;&nbsp;</TD>
									<TD VALIGN="middle">Meetings DO NOT take place</TD>
								</TR>
							</TABLE>
													
						</FORM>
<!--- End Large Calendar --->
					</TD>
			</TABLE>
		</TD>
		
<!--- Begin Second Mini Calendar --->
		<TD ALIGN="right" WIDTH="125">
				
			<!--- Query to find if any days are already selected --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="Next_Month_Calendar">
			SELECT *
			FROM schedule_meeting_date
			WHERE month = '#month_next#' AND year = '#year_next#' AND Project_code = '#session.Project_code#';
			</CFQUERY>
			
			<TABLE ALIGN="Center" BORDER="0" CELLPADDING="0" CELLSPACING="0">

				<TR ALIGN="Center" HEIGHT="15">
				<TD WIDTH="70%" COLSPAN="7"><B><CFOUTPUT>#MonthAsString(month_next)#</CFOUTPUT></B></TD>
					
				</TR>
				<TR CLASS="Days" ALIGN="Center" HEIGHT="10">
					<TD WIDTH="10%">S</TD>
					<TD WIDTH="10%">M</TD>
					<TD WIDTH="10%">T</TD>
					<TD WIDTH="10%">W</TD>
					<TD WIDTH="10%">Th</TD>
					<TD WIDTH="10%">F</TD>
					<TD WIDTH="10%">Sa</TD>
				</TR>
								
				<!--- Starting Day of Month ---->
				<CFSET StartDay = DayOfWeek(CreateDate(year_next, month_next, 1))>
				
				<!--- Days in Month --->
				<CFSET DaysMonth = DaysInMonth(CreateDate(year_next, month_next, 1))>
				
				<CFSET DayNumbers = 1>
				<CFSET Counter = 1>
				
				<TR HEIGHT="10">
					<CFLOOP CONDITION = "DayNumbers EQ 1">
						<TD STYLE="background-color: <CFIF (#Evaluate('Next_Month_Calendar.x#DayNumbers#')# EQ 1) AND (StartDay EQ Counter)>BECCFF<CFELSE>FFFFFF</CFIF>">
							<CFIF StartDay EQ Counter>
								<CFOUTPUT>#DayNumbers#</CFOUTPUT>
								<CFSET DayNumbers = 2>
							<CFELSE>
								&nbsp;
							</CFIF>
						</TD>
						<CFSET Counter = Counter + 1>
					</CFLOOP>
				
					<!--- 
						If the day number being processed is less than the amount of days in the month OR
						the number of the days is greater than the days in the month AND the remainder of the counter divided by seven is NOT one
						THEN continue with the loop; otherwise terminate the loop
					--->
					<CFLOOP CONDITION = "(DayNumbers LTE DaysMonth) OR  ((DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1))">
									
						<CFIF DayNumbers LTE DaysMonth>	<!--- Create rows of boxes with the date numbers in them --->
							<CFIF (Counter MOD 7) EQ 1>	<!--- Start a new row --->
								</TR>
								<TR HEIGHT="10">
									<TD STYLE="background-color: <CFIF #Evaluate('Next_Month_Calendar.x#DayNumbers#')# EQ 1>BECCFF<CFELSE>FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
							<CFELSE>	<!--- Finish current row --->
									<TD STYLE="background-color: <CFIF #Evaluate('Next_Month_Calendar.x#DayNumbers#')# EQ 1>BECCFF<CFELSE>FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
							</CFIF>
						<CFELSEIF (DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1)>	<!--- Complete current row of boxes before quitting --->
							<TD>&nbsp;</TD>
						</CFIF>	<!--- Quit on a complete row of boxes --->
						
						<!--- Increment the counter and the day numberer variables --->
						<CFSET DayNumbers = DayNumbers + 1>
						<CFSET Counter = Counter + 1>
					
					</CFLOOP>
			
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>
<!---<center><a href="javascript:OpenWindow('schedule_help.htm#meeting_date_calendar')"><img src="/images/help.gif" border="0"></a></center>
 End Second Mini Calendar --->
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
