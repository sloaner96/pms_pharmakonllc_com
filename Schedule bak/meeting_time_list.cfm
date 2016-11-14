<!--- 
	*****************************************************************************************
	Name:		meeting_time_list.cfm
	Function:	Displays all months and days in which meetings will occur.
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Meeting Schedule" showCalendar="0">

		
		<STYLE>
	
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
		</STYLE>		
		<cfscript>
			ProjectName = createObject("component","pms.com.cfc_get_name");
			projName = ProjectName.getProjName(ProjCode="#session.Project_code#");
		</cfscript>
		<TABLE ALIGN="Center" WIDTH="750" BORDER="0" CELLPADDING="0" CELLSPACING="0">
		<tr>
			<td class="ProjectNameHeader">
			<cfoutput>#projName#</cfoutput>
			</td>
		</tr>
		</table>
		<TABLE ALIGN="Center" WIDTH="700" BORDER="0" CELLPADDING="10" CELLSPACING="20">
			<TR>
				<TD COLSPAN="4">
					Meeting Schedule for Project Code <B><CFOUTPUT>#session.project_code#</CFOUTPUT></B>.  Please click on a month to schedule meetings for that month.
				</TD>
			</TR>
						
			<TR>		
								
				<CFSET rowcounter = 0>
				
				<!--- Query to find scheduled months for specific project code --->
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="Get_Months">
					SELECT *
					FROM schedule_meeting_date
					WHERE Project_code = '#session.project_code#'
					ORDER BY year, month;
				</CFQUERY>
				<!--- <cfdump var="#Get_Months#"> --->
				<FORM NAME="form" ACTION="" METHOD="post">
					<CFOUTPUT QUERY="Get_Months">
					
						<!--- Gets the date for the previous month and the next month --->
						<CFSET temp_current_date = CreateDate(year, month, 1)>
					
						<CFIF (rowcounter MOD 3) EQ 0>
							</TR>
							<TR>
						</CFIF>
						<!--- Begin Mini Calendar --->
				
						<TD onClick="form.action='meeting_time_calendar.cfm?year=#year#&month=#month#'; form.submit();" WIDTH="233">
							<TABLE STYLE="cursor : hand" BORDER="0" CELLPADDING="0" CELLSPACING="0">
								
								<TR ALIGN="Center" HEIGHT="15">
									<TD WIDTH="70%" COLSPAN="7"><B>#MonthAsString(DateFormat(temp_current_date, 'm'))#, #DateFormat(temp_current_date, 'yyyy')#</B></TD>
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
								<CFSET StartDay = DayOfWeek(temp_current_date)>
								
								<!--- Days in Month --->
								<CFSET DaysMonth = DaysInMonth(temp_current_date)>
								
								<CFSET DayNumbers = 1>
								<CFSET Counter = 1>
								
								<TR HEIGHT="10">
									<CFLOOP CONDITION = "DayNumbers EQ 1">
										<TD STYLE="background-color: <CFIF (#Evaluate('Get_Months.x#DayNumbers#')# EQ 1) AND (StartDay EQ Counter)>FFCDB9<CFELSE>FFFFFF</CFIF>">
											<CFIF StartDay EQ Counter>
												#DayNumbers#
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
													<TD STYLE="background-color: <CFIF #Evaluate('Get_Months.x#DayNumbers#')# EQ 1>FFCDB9<CFELSE>FFFFFF</CFIF>">#DayNumbers#</TD>
											<CFELSE>	<!--- Finish current row --->
													<TD STYLE="background-color: <CFIF #Evaluate('Get_Months.x#DayNumbers#')# EQ 1>FFCDB9<CFELSE>FFFFFF</CFIF>">#DayNumbers#</TD>
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
							<!--- End Mini Calendar --->
					
							<CFSET temp_current_date = #DateAdd('m', 1, temp_current_date)#>
							
							<CFSET rowcounter = rowcounter + 1>
						</TD>
					</CFOUTPUT>
				</FORM>
			</TR>
		</TABLE>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">