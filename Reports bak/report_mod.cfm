<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->

<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
			
	<!--- Saves all data inputted from the above form --->
	<CFCASE VALUE="report">
	
		<!--- Defines variables needed within the page both from the previous form and URL --->
		<CFLOCK SCOPE="SESSION" TIMEOUT="30" TYPE="EXCLUSIVE">
			<CFSET session.begin_month = "#form.begin_month#">
			<CFSET session.begin_year = "#form.begin_year#">
			<CFSET session.end_month = "#form.end_month#">
			<CFSET session.end_year = "#form.end_year#">
			<CFSET session.id= "#form.person_id#">
			<CFSET session.sort_selection="#form.sort_selection#">
		</CFLOCK>


<!--- If days did not exist in calendar being submitted then create variables with negative ones for values --->
<CFPARAM NAME="form.Day29" DEFAULT="-1">
<CFPARAM NAME="form.Day30" DEFAULT="-1">
<CFPARAM NAME="form.Day31" DEFAULT="-1">
<!--- Save changes for month that was edited right before comming to this page --->

		<HTML>
			<HEAD>
				<TITLE>Calendar Review Page</TITLE>
				
				<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
				<SCRIPT>
				function openNewWin()
				{
					window.open('report_mod_popup.cfm?no_menu=1','title','scrollbars=yes,resizable=yes,width=750,height=600,left=1,top=1');
				}
				function openNewWin2()
				{
					window.open('report_mod_popup2.cfm?no_menu=1','title','scrollbars=yes,resizable=yes,width=750,height=600,left=1,top=1');
				}
				</SCRIPT>
				<STYLE>
					TD {
							font-family : Verdana, Geneva, Arial;
							font-size : xx-small;
							text-align: left;
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
				</STYLE>		
				
			</HEAD>
			
			<BODY BGCOLOR="FFFFFF" MARGINHEIGHT="0" MARGINWIDTH="0">
				<FORM NAME="form" ACTION="" METHOD="post">
				<TABLE ALIGN="left" WIDTH="650" BORDER="0" CELLPADDING="5" CELLSPACING="5">
					<TR>
						<TD COLSPAN="5">
						<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetName">
							SELECT DISTINCT firstname, lastname
							FROM spkr_table
							WHERE speaker_id='#session.id#' AND type='MOD'; 
						</CFQUERY>
						<FONT SIZE="+2" STYLE="font-size : large;">Report for: <B><CFOUTPUT>#getname.firstname# #getname.lastname#</CFOUTPUT><BR><HR color="#3399FF"><BR></B></FONT>
						</TD> 
					</TR>
					<CFPARAM NAME="form.dateandtime" DEFAULT="0">
					<CFPARAM NAME="form.availability" DEFAULT="0">
					<CFOUTPUT><CFSET report_dateandtime = "#form.dateandtime#"></CFOUTPUT>
					<CFIF report_dateandtime EQ 1>
							
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="meetingDT">
						SELECT *
						FROM schedule_meeting_time
						WHERE status = 0 AND moderator_id = '#session.id#' AND month BETWEEN <CFOUTPUT>#begin_month#</CFOUTPUT> AND <CFOUTPUT>#end_month#</CFOUTPUT> AND year BETWEEN <CFOUTPUT>#begin_year#</CFOUTPUT> AND <CFOUTPUT>#end_year#</CFOUTPUT>
						<CFIF session.sort_selection EQ "Time">
							ORDER BY start_time,year,Month,Day,project_code;
						<CFELSEIF session.sort_selection EQ "Date">
							ORDER BY year,Month,Day,start_time,project_code;
						<CFELSE>
							ORDER BY project_code,year,Month,Day,start_time;
						</CFIF>
					</CFQUERY>
					<TR>
						<TD COLSPAN="5" STYLE="text-align: left; font-size : small;"><U>Scheduled Meeting Dates and Times Report</U></TD>	
					</TR>
					
					<TR>
						<TD COLSPAN="5">
								<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
								<TR><CFSET StrLastCol="">
								<CFIF session.sort_selection EQ "Time">
										<TR>
											<TD STYLE="text-align: CENTER; font-weight: bold;"><U><B>TIME</B></U></TD>
											<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
											<TD STYLE="text-align: CENTER;"><U><B>DATE</B></U></TD>
											<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
											<TD STYLE="text-align: CENTER;"><U><B>Project Code</B></U></TD>
										</TR>
									<CFOUTPUT QUERY="meetingDT">
									<cfinvoke 
										component="pms.com.cfc_time_conversion" 
										method="toCivilian" 
										returnVariable="CivilianTime" 
										BeginMilitary="#start_time#"
										EndMilitary="#end_time#"
									>
									<cfscript>
										oCivTime = createObject("component","pms.com.cfc_time_conversion");
										TheTime = oCivTime.ConCatTime(#CivilianTime#);
									</cfscript>	
										<TR>
											<TD STYLE="text-align: right; font-weight: bold;">#TheTime# EST</TD>
											<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
											<TD>#month#/#day#/#year#</TD>
											<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
											<TD>
											<cfif StrLastCol NEQ #project_code#>
											#project_code#
											<CFSET StrLastCol = "#project_code#">
											</CFIF></TD>
										</TR>
									</CFOUTPUT>
								<CFELSEIF session.sort_selection EQ "Date">
										<TR>
											<TD STYLE="text-align: right; font-weight: bold;"><U><B>DATE</B></U></TD>
											<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
											<TD STYLE="text-align: CENTER;"><U><B>TIME</B></U></TD>
											<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
											<TD STYLE="text-align: CENTER;"><U><B>Project Code</B></U></TD>
										</TR>
									<CFOUTPUT QUERY="meetingDT">
									
									<cfinvoke 
										component="pms.com.cfc_time_conversion" 
										method="toCivilian" 
										returnVariable="CivilianTime" 
										BeginMilitary="#start_time#"
										EndMilitary="#end_time#"
									>
									<cfscript>
										oCivTime = createObject("component","pms.com.cfc_time_conversion");
										TheTime = oCivTime.ConCatTime(#CivilianTime#);
									</cfscript>
									
										
										<TR>
											<TD STYLE="text-align: right; font-weight: bold;">#month#/#day#/#year#</TD>
											<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
											<TD>#TheTime# EST</TD>
											<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
											<TD>
											<cfif StrLastCol NEQ #project_code#>
											#project_code#
											<CFSET StrLastCol = "#project_code#">
											</CFIF></TD>
										</TR>
									</CFOUTPUT>
								<CFELSE>
									<TR>
										<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<U>Project Code</U>&nbsp;&nbsp;</TD>
										<TD STYLE="text-align: center;"><U>Date</U>&nbsp;&nbsp;</TD>
										<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
										<TD STYLE="text-align: center;"><U>Time</U></TD>
									</TR>
									<CFSET output_project_code = 1>
									<CFOUTPUT QUERY="meetingDT">
									<CFIF IsDefined("temp_project_code") AND temp_project_code NEQ "#project_code#">
									<CFSET output_project_code = 1>
									</CFIF>
									<CFIF output_project_code EQ 1>
									</TR><TR><TD COLSPAN="4"></TD></TR>
									<TD COLSPAN="4" STYLE="text-align: left; font-size : small; font-weight: bold;;"></TD></TR>
									</CFIF>
									<CFSET output_project_code = 0>			
									
									<cfinvoke 
										component="pms.com.cfc_time_conversion" 
										method="toCivilian" 
										returnVariable="CivilianTime" 
										BeginMilitary="#start_time#"
										EndMilitary="#end_time#"
									>
									<cfscript>
										oCivTime = createObject("component","pms.com.cfc_time_conversion");
										TheTime = oCivTime.ConCatTime(#CivilianTime#);
									</cfscript>
									
									<TR>
										<TD>
											<cfif StrLastCol NEQ #project_code#>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#project_code#&nbsp;&nbsp;
											<CFSET StrLastCol = "#project_code#">
											</CFIF></TD>
										<TD>&nbsp;&nbsp;</TD>
										<TD STYLE="text-align: right;">#month#/#day#/#year#</TD>
										<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
										<TD>#TheTime# EST</TD>
									</TR>
									<CFSET temp_project_code = #project_code#>
									</CFOUTPUT>
								</CFIF>
								
								</TR>
							<TR><TD COLSPAN="5" STYLE="text-align: center;"><br><input TYPE="Button"  NAME="curr_schedule_btn" VALUE="Current Schedule - Printable Version" onCLick="openNewWin()"></TD></TR>
							</TABLE>
						</TD>
					</CFIF>
												
							
					<CFOUTPUT><CFSET report_availability = "#form.availability#"></CFOUTPUT>
					<CFIF report_availability EQ 1>
					<TR>
						<TD COLSPAN="5"><BR><HR><BR></TD>
					</TR>
					<TR>
						<TD COLSPAN="5" STYLE="text-align: left; font-size : small;"><CFOUTPUT><U>#getname.firstname# #getname.lastname#</CFOUTPUT> Day Availability Report</U></TD>
					</TR>
					<TR>
						<TD COLSPAN="5" STYLE="text-align: left; font-size : small;">
						<TABLE WIDTH="100%" BORDER="0">
								<TR>
									<TD style="background:6699FF; border: 1px solid black">&nbsp;</TD>
									<TD VALIGN="middle">:Denotes Available </TD>
								</TR>
								<TR>
									<TD style="background:FFFFFF; border: 1px solid black">&nbsp;</TD>
									<TD VALIGN="middle">:Denotes NOT Available</TD>
								</TR>
								<!--- <TR>
									<TD COLSPAN="2">Days that are <U>UNDERLINED</U> also denote availability</TD></TD>
								</TR>
								<TR>
									<TD COLSPAN="2">Days that are <B><U>UNDERLINED AND BOLD</U></B> denote availability and currently have meetings scheduled on that particular date</TD>
								</TR> --->
							</TABLE>
						</TD>	
					</TR>
					<TR>
						
						<!--- Gets the date for the previous month and the next month --->
						<CFSET temp_current_date = CreateDate(session.begin_year, session.begin_month, 1)>
						<CFSET temp_end_date = CreateDate(session.end_year, session.end_month, 1)>
						
						<CFSET rowcounter = 0>
									
						<CFLOOP Condition="(DateCompare(temp_current_date, temp_end_date) NEQ 1)">
							
							<CFIF (rowcounter MOD 5) EQ 0>
								</TR>
								<TR>
							</CFIF>
							<!--- Begin Mini Calendar --->
						
							<!--- Query to find if any days are already selected --->
							<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Month_Calendar">
								SELECT *
								FROM Availability
								WHERE month = '#DateFormat(temp_current_date, 'm')#' AND year = '#DateFormat(temp_current_date, 'yyyy')#' AND ID = '#session.ID#';
							</CFQUERY>
							<!--- <CFIF month_calendar.recordcount NEQ 0> onClick="form.action='report_calendar.cfm?rowid=<CFOUTPUT>#month_calendar.rowid#</CFOUTPUT>'; form.submit();" </CFIF>--->
							<TD WIDTH="233"  STYLE="cursor : default">
								<TABLE  BORDER="0" CELLPADDING="0" CELLSPACING="0">
									
									<TR ALIGN="Center" HEIGHT="15">
										<TD STYLE="text-align: CENTER;" WIDTH="70%" COLSPAN="7"><B><CFOUTPUT>#MonthAsString(DateFormat(temp_current_date, 'm'))#, #DateFormat(temp_current_date, 'yyyy')#</CFOUTPUT></B></TD>
									</TR>
									
									<TR CLASS="Days" ALIGN="Center" HEIGHT="10">
										<TD STYLE="text-align: CENTER;" WIDTH="10%">S</TD>
										<TD STYLE="text-align: CENTER;" WIDTH="10%">M</TD>
										<TD STYLE="text-align: CENTER;" WIDTH="10%">T</TD>
										<TD STYLE="text-align: CENTER;" WIDTH="10%">W</TD>
										<TD STYLE="text-align: CENTER;" WIDTH="10%">Th</TD>
										<TD STYLE="text-align: CENTER;" WIDTH="10%">F</TD>
										<TD STYLE="text-align: CENTER;" WIDTH="10%">Sa</TD>
									</TR>
									
									<!--- Starting Day of Month ---->
									<CFSET StartDay = DayOfWeek(temp_current_date)>
									
									<!--- Days in Month --->
									<CFSET DaysMonth = DaysInMonth(temp_current_date)>
									
									<CFSET DayNumbers = 1>
									<CFSET Counter = 1>
									
									<TR HEIGHT="10">
										<CFLOOP CONDITION = "DayNumbers EQ 1">
											<TD STYLE="text-align: CENTER;background-color: <CFIF (#Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1) AND (StartDay EQ Counter)>6699FF<CFELSE>FFFFFF</CFIF>">
												<CFIF StartDay EQ Counter>
													<CFOUTPUT>
														<CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>
																<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
																	SELECT *
																	FROM schedule_meeting_time
																	WHERE month = '#DateFormat(temp_current_date, 'm')#' AND year = '#DateFormat(temp_current_date, 'yyyy')#' AND moderator_ID = '#session.ID#' AND day = '#DayNumbers#'
																</CFQUERY>
																
																<CFIF meetings.recordcount EQ 0>
																	#DayNumbers#
																<CFELSE>
																	#DayNumbers#
																</CFIF>
															<CFELSE>
																#DayNumbers#
															</CFIF>
													</CFOUTPUT>
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
														<TD STYLE="text-align: CENTER;background-color: <CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>6699FF<CFELSE>FFFFFF</CFIF>">
														<CFOUTPUT>
															<CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>
																<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
																	SELECT *
																	FROM schedule_meeting_time
																	WHERE month = '#DateFormat(temp_current_date, 'm')#' AND year = '#DateFormat(temp_current_date, 'yyyy')#' AND moderator_ID = '#session.ID#' AND day = '#DayNumbers#'
																</CFQUERY>
																
																<CFIF meetings.recordcount EQ 0>
																	#DayNumbers#
																<CFELSE>
																	#DayNumbers#
																</CFIF>
															<CFELSE>
																#DayNumbers#
															</CFIF>
														</CFOUTPUT>
														</TD>
												<CFELSE>	<!--- Finish current row --->
														<TD STYLE="text-align: CENTER;background-color: <CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>6699FF<CFELSE>FFFFFF</CFIF>">
														<CFOUTPUT>
															<CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>
																<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
																	SELECT *
																	FROM schedule_meeting_time
																	WHERE month = '#DateFormat(temp_current_date, 'm')#' AND year = '#DateFormat(temp_current_date, 'yyyy')#' AND moderator_ID = '#session.ID#' AND day = '#DayNumbers#'
																</CFQUERY>
																
																<CFIF meetings.recordcount EQ 0>
																	#DayNumbers#
																<CFELSE>
																	#DayNumbers#
																</CFIF>
															<CFELSE>
																#DayNumbers#
															</CFIF>
														</CFOUTPUT>
														</TD>
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
						</CFLOOP>
					</TR></TR>
					<TR><TD COLSPAN="5"  STYLE="text-align: CENTER;"><input TYPE="Button"  NAME="day_avail_btn" VALUE="Day Availability - Printable Version" onCLick="openNewWin2()"></TD></TR>
					<TR><TD COLSPAN="5">NOTE: Printing this page will not reproduce what is visible, colors will NOT print out. Click the Printer Version button for a printed readable copy of this report.</TD></TR>
					</CFIF>
				</TABLE>
			</FORM></BODY>
		</HTML>
		
	</CFCASE>
		
	
<!--- If no case is specified user is sent to data entry part of page --->
<!--- Allows user to select months in which meetings will occur --->
<CFDEFAULTCASE>
		
		<HTML>
			<HEAD>
				<TITLE>Project Initiation Form - General Information</TITLE>
				<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
				<SCRIPT SRC="confirm.js"></SCRIPT>
				<SCRIPT>
				function validate() 
					{	//form.begin_month 
						//form.begin_year	
						//form.end_month	
						//form.end_year
						
								
						test = document.forms[0].begin_month.value;
						test2 = document.forms[0].begin_year.value;
						test3 = document.forms[0].end_month.value;
						test4 = document.forms[0].end_year.value;
						if ((test == 1) || (test2 == 1) || (test3 == 1) || (test4 == 1))
						{
							alert("Please complete all elements of the form!"); 
							return false;
						}
						else
						{
							if(document.forms[0].availability.checked || document.forms[0].dateandtime.checked)
							{
								return true;
							}
							else
							{
							alert("Please select Availability Reporting AND/OR Date And Time Reporting!");
							return false;
							}
						}
					}
				</SCRIPT>
			</HEAD>
		
			<BODY>
				<CFOUTPUT><FORM NAME="form" ACTION="report_mod.cfm?action=report" METHOD="post" onSubmit="return validate()"></CFOUTPUT>
				
				<TABLE BGCOLOR="#000080" ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="720">
					<TR> 
						<TD CLASS="tdheader">
							Moderator Reporting
						</TD>
					</TR>
					
					<TR> 
						<TD>	<!--- Table containing input fields --->
							<TABLE ALIGN="Center" BORDER="0" WIDTH="99%" CELLSPACING="1" CELLPADDING="10">
								
								<TR>
									<TD ALIGN="Center">
										<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="person">
											SELECT *
											FROM spkr_table
											WHERE type='MOD'
											ORDER BY lastname, firstname
										</CFQUERY>	
										<B>Moderator:</B>&nbsp;&nbsp;&nbsp;&nbsp;
										<SELECT NAME="person_id">
											<CFOUTPUT query="person"><OPTION VALUE=#speaker_id#>#lastname#, #Firstname#</CFOUTPUT>
										</SELECT>	
									</TD>
								</TR>
								
								<TR>
									<TD ALIGN="Center">
										<B>Begin Schedule:</B>&nbsp;&nbsp;&nbsp;&nbsp;
										<SELECT NAME="begin_month">
				                            <OPTION SELECTED VALUE=1>Select Month</OPTION> 
											<OPTION>01</OPTION>	
											<OPTION>02</OPTION>
											<OPTION>03</OPTION>	
											<OPTION>04</OPTION>	
											<OPTION>05</OPTION>	
											<OPTION>06</OPTION>	
											<OPTION>07</OPTION>	
											<OPTION>08</OPTION>	
											<OPTION>09</OPTION>	
											<OPTION>10</OPTION>	
											<OPTION>11</OPTION>	
											<OPTION>12</OPTION>										 
				                         </SELECT>
										&nbsp;&nbsp;
										<SELECT NAME="begin_year">
				                            <OPTION SELECTED VALUE=1>Select Year</OPTION> 
											<OPTION>2001</OPTION>	
											<OPTION>2002</OPTION>
											<OPTION>2003</OPTION>	
											<OPTION>2004</OPTION>
											<OPTION>2004</OPTION>
											<OPTION>2005</OPTION>
											<OPTION>2006</OPTION>	
											<OPTION>2007</OPTION>											 
				                         </SELECT>
									</TD>
								</TR>
										
								<TR>
									<TD ALIGN="Center">
										<B>End Schedule:</B>&nbsp;&nbsp;&nbsp;&nbsp;
										<SELECT NAME="end_month">
				                            <OPTION SELECTED VALUE=1>Select Month</OPTION> 
											<OPTION>01</OPTION>	
											<OPTION>02</OPTION>
											<OPTION>03</OPTION>	
											<OPTION>04</OPTION>	
											<OPTION>05</OPTION>	
											<OPTION>06</OPTION>	
											<OPTION>07</OPTION>	
											<OPTION>08</OPTION>	
											<OPTION>09</OPTION>	
											<OPTION>10</OPTION>	
											<OPTION>11</OPTION>	
											<OPTION>12</OPTION>										 
				                         </SELECT>
										&nbsp;&nbsp;	
										<SELECT NAME="end_year">
				                            <OPTION SELECTED VALUE=1>Select Year</OPTION> 
											<OPTION>2001</OPTION>	
											<OPTION>2002</OPTION>
											<OPTION>2003</OPTION>	
											<OPTION>2004</OPTION>
											<OPTION>2004</OPTION>
											<OPTION>2005</OPTION>
											<OPTION>2006</OPTION>	
											<OPTION>2007</OPTION>											 
				                         </SELECT>
									</TD>
								</TR>
								<TR>
									<TD ALIGN="Center">
										<B>SORT BY:</B>&nbsp;&nbsp;&nbsp;&nbsp;
										<SELECT NAME="sort_selection">
				                            <OPTION SELECTED VALUE=1>----Sort By</OPTION> 
											<OPTION>Project Code</OPTION>	
											<OPTION>Date</OPTION>		
											<OPTION>Time</OPTION>								 
				                         </SELECT>
									</TD>
								</TR>
								<TR>
									<TD ALIGN="center">
										<TABLE BORDER="0">
										<TR>
											<TD ALIGN="right" WIDTH="75%"><B>Show Moderator Day Availability</B></TD>
											<TD ALIGN="left" WIDTH="25%"><INPUT TYPE="CHECKBOX" NAME="availability" VALUE="1"></TD>
										</TR>
										<TR>
											<TD ALIGN="right"><B>Show Moderator Current Scheduled Dates and Times</B></TD>
											<TD ALIGN="left"><INPUT TYPE="CHECKBOX" NAME="dateandtime" VALUE="1"></TD>
										</TR>
										</TABLE>
									</TD>
								</TR>

								<TR>
						    		<TD ALIGN="center">
										<INPUT TYPE="submit" NAME="submit"  VALUE="  Start Report  ">
									</TD>
								</TR>
								
							</TABLE>
							</FORM>
						</TD>
					</TR>
				</TABLE>
			</BODY>
		</HTML>
	</CFDEFAULTCASE>

</CFSWITCH>
