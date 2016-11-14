<!--- 
	*****************************************************************************************
	Name:		meeting_time_calendar.cfm
	Function:	Displays selected month, each day can be one of three colors
				white for no meetings, grey for no meeting can be held on this day at all,
				and peach for meetings on that day; NOTE number of meetings per one day 
				outputted into PEACH TDs.
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->

<!--- The current month and date which were passed via URL from last form --->
<CFSET month = URL.month>
<CFSET year = URL.year>

<!--- Script that changes a calendar day to available/unavailable and changes the --->
<!--- value of the hidden field for that day --->


<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Meeting Time Schedule Calendar" showCalendar="0">

<SCRIPT LANGUAGE="JavaScript" src="../popup_help.js"></script>
<SCRIPT LANGUAGE="JavaScript">
	function change_status_day(tempvar, Day)
	{	
		<CFOUTPUT>
		window.open('meeting_time_add.cfm?no_menu=1&day=' + Day.value + '&month=#month#&year=#year#','','width=680,height=300,left=140,top=190,scrollbars=yes');
		</CFOUTPUT>
	}
</SCRIPT>
<STYLE>

	
.DAYS 
{
	font-family : Verdana, Geneva, Arial;
	font-size : xx-small;
	font-weight: bold;
	text-align: center;
}
.WEEKS 
{
	font-family : ArialBold;
	font-size : xx-small;
	text-align: center;
}
</STYLE>
</HEAD>

	<cfscript>
		ProjectName = createObject("component","pms.com.cfc_get_name");
		projName = ProjectName.getProjName(ProjCode="#session.Project_code#");
	</cfscript>
	<TABLE ALIGN="Center" WIDTH="750" BORDER="0" CELLPADDING="0" CELLSPACING="0" style="margin-top: 8px">
		<tr>
			<td class="ProjectNameHeader">
				<cfoutput>#projName#</cfoutput>
			</td>
		</tr>
	</table>
	<TABLE ALIGN="Center" WIDTH="750" BORDER="0" CELLPADDING="0" CELLSPACING="0">
		<TR>
		<!--- Month name for the current month (large calendar) --->
			<TD ALIGN="Center">
				<TABLE ALIGN="Center" WIDTH="100%" BORDER="0" CELLSPACING="6" CELLPADDING="0">
					<TR>
						<TD WIDTH="100%">
							<CFOUTPUT>
								&nbsp;&nbsp;&nbsp;&nbsp;<FONT SIZE="+1"><B>#MonthAsString(month)#, #year#</B></FONT>&nbsp;&nbsp;&nbsp;&nbsp;
							</CFOUTPUT>
						</TD>
					</TR>
					<TR ALIGN="Center">
						<TD ALIGN="Center" WIDTH="100%">
							<!--- Query to find if any days are already selected --->
							<CFQUERY DATASOURCE="#application.projdsn#" NAME="Main_Calendar">
								SELECT *
								FROM schedule_meeting_date
								WHERE Project_code = '#session.project_code#' AND year = #year# AND month = #month#;
							</CFQUERY>
						<CFOUTPUT>
							<FORM NAME="form" ACTION="../meeting_time_calendar.cfm?year=#year#&month=#month#" METHOD="post">
						</CFOUTPUT>
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
										<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
											SELECT DISTINCT meeting_code
												FROM schedule_meeting_time
												WHERE Project_code = '#session.project_code#' AND year = #year# AND month = #month# AND day = #DayNumbers# AND status = 0
										</CFQUERY>
										
				<!--- ****** Set the color and funtionality of the square for the day. If
				square is part of last month, make it uneditable and gray  --->
				<CFIF StartDay EQ Counter>		

										<CFIF (#Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1) AND (Meetings.recordcount GT 0)>
											<TD onClick="return change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: 6699FF">
										<CFELSEIF #Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1>
											<TD onClick="return change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: FFCDB9">
										<CFELSE>
											<TD STYLE="background-color: CCCCCC; color : 999999">
										</CFIF>
				<cfelse>
						<TD STYLE="background-color: CCCCCC; color : 999999">
				</cfif>								
						
										<CFIF StartDay EQ Counter>
											<CFOUTPUT>
												<INPUT TYPE="Hidden" NAME="Day#DayNumbers#" VALUE="#DayNumbers#">
												<U>#DayNumbers#</U>
											</CFOUTPUT>
											
											<CFIF (#Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1) AND (Meetings.recordcount GT 0)>
												<br><br>
												<cfoutput><B>#Meetings.recordcount#</B></CFOUTPUT>
											</CFIF>
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
											
											<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
												SELECT DISTINCT meeting_code
												FROM schedule_meeting_time
												WHERE Project_code = '#session.project_code#' AND year = #year# AND month = #month# AND day = #DayNumbers# AND status = 0
												<!--- GROUP BY meeting_code, project_code, year, month, day, rowid --->
											</CFQUERY>
											
											<CFIF DayNumbers LTE DaysMonth>	<!--- Create rows of boxes with the date numbers in them --->
												<CFIF (Counter MOD 7) EQ 1>	<!--- Start a new row --->
													</TR>
													<TR HEIGHT="50">
														
														<CFIF (#Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1) AND (Meetings.recordcount GT 0)>
															<TD onClick="change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: 6699FF">
														<CFELSEIF #Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1>
															<TD onClick="change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: FFCDB9">
														<CFELSE>
															<TD STYLE="background-color: CCCCCC; color : 999999">
														</CFIF>
															<CFOUTPUT>
																<INPUT TYPE="Hidden" NAME="Day#DayNumbers#" VALUE="#DayNumbers#">
																#DayNumbers#
															</CFOUTPUT>
														</TD>
												<CFELSE>	<!--- Finish current row --->
														
													<CFIF (#Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1) AND (Meetings.recordcount GT 0)>
														<TD onClick="change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: 6699FF">
													<CFELSEIF #Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1>
														<TD onClick="change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: FFCDB9">
													<CFELSE>
														<TD STYLE="background-color: CCCCCC; color : 999999">
													</CFIF>
															
														<CFOUTPUT>
															<INPUT TYPE="Hidden" NAME="Day#DayNumbers#" VALUE="#DayNumbers#">
															<U>#DayNumbers#</U>
														</CFOUTPUT>
																	
													<CFIF (#Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1) AND (Meetings.recordcount GT 0)><BR><BR><CFOUTPUT><B>#Meetings.recordcount#</B></CFOUTPUT></CFIF>
														</TD>
													</CFIF>
												<CFELSEIF (DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1)>	<!--- Complete current row of boxes before quitting --->
													<TD STYLE="background-color: CCCCCC; color : 999999;">&nbsp;</TD>
												</CFIF>	<!--- Quit on a complete row of boxes --->
											
											<!--- Increment the counter and the day numberer variables --->
											<CFSET DayNumbers = DayNumbers + 1>
											<CFSET Counter = Counter + 1>
										
										</CFLOOP>
							</TABLE>	
						</FORM>
							<BR>
							<!--- Exit Calendar scheduling program --->
							<!--- Exit Calendar scheduling program --->
					<CENTER>
						<TABLE WIDTH="400px" border="0" align="center">
							<TR>
								<TD style="background:6699FF; border: 1px solid black" width="100px" valign="middle">Meetings<BR>(# of meetings under DATE)</TD>
								<TD width="50px">&nbsp;&nbsp;&nbsp;</TD>
								<TD style="background:FFCDB9; border: 1px solid black" width="100px" valign="middle">Meetings<BR>w/o times</TD>
								<TD width="50px">&nbsp;&nbsp;&nbsp;</TD>
								<TD style="background:CCCCCC; border: 1px solid black" width="100px" valign="middle">No Meetings</TD>
							</TR>
						</TABLE>
						<TABLE WIDTH="100%">
							<TR>
								<TD COLSPAN="8">&nbsp;&nbsp;&nbsp;</TD>
							</TR>
							<TR>
								<TD COLSPAN="8">
									<CFOUTPUT><INPUT TYPE="Button"  VALUE="Save and Return to Month Index" onClick=window.location.href='meeting_time_list.cfm'></CFOUTPUT>			
								</TD>
							</TR>
						</TABLE>
					</CENTER>
<!--- End Large Calendar --->
					</TD>
				</TABLE>
			</TD>
		</TR>
	</TABLE>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
