<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Moderator Availability Report (Printable Version)</title>
		<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
		<STYLE>
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
						<FONT SIZE="+2" STYLE="font-size : large;">Report for: <B><CFOUTPUT>#getname.firstname# #getname.lastname#</CFOUTPUT><BR><HR><BR></B></FONT>
						</TD> 
					</TR>
					
					
					<TR>
						<TD COLSPAN="5" STYLE="text-align: left; font-size : small;"><CFOUTPUT><U>#getname.firstname# #getname.lastname#</CFOUTPUT> Day Availability Report</U></TD>
					</TR>
					<TR>
						<TD COLSPAN="5" STYLE="text-align: left; font-size : small;">
						<TABLE WIDTH="100%" BORDER="0">
								<!--- <TR>
									<TD style="background:6699FF; border: 1px solid black">&nbsp;</TD>
									<TD VALIGN="middle">:Denotes Available </TD>
								</TR>
								<TR>
									<TD style="background:FFFFFF; border: 1px solid black">&nbsp;</TD>
									<TD VALIGN="middle">:Denotes NOT Available</TD>
								</TR> --->
								
								<TR>
									<TD COLSPAN="2" STYLE="text-align: left;">Days that are <U>UNDERLINED</U> denote availability.</TD></TD>
								</TR>
								<TR>
									<TD COLSPAN="2" STYLE="text-align: left;">Days that are <B><U>UNDERLINED AND BOLD</U></B> denote availability and meetings scheduled.</TD>
								</TR>
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
											<TD STYLE="text-align: CENTER;">
												<CFIF StartDay EQ Counter>
													<CFOUTPUT>
														<CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>
																<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
																	SELECT *
																	FROM schedule_meeting_time
																	WHERE month = '#DateFormat(temp_current_date, 'm')#' AND year = '#DateFormat(temp_current_date, 'yyyy')#' AND moderator_ID = '#session.ID#' AND day = '#DayNumbers#'
																</CFQUERY>
																
																<CFIF meetings.recordcount EQ 0>
																	<U>#DayNumbers#</U>
																<CFELSE>
																	<B><U>#DayNumbers#</U></B>
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
														<TD STYLE="text-align: CENTER;">
														<CFOUTPUT>
															<CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>
																<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
																	SELECT *
																	FROM schedule_meeting_time
																	WHERE month = '#DateFormat(temp_current_date, 'm')#' AND year = '#DateFormat(temp_current_date, 'yyyy')#' AND moderator_ID = '#session.ID#' AND day = '#DayNumbers#'
																</CFQUERY>
																
																<CFIF meetings.recordcount EQ 0>
																	<U>#DayNumbers#</U>
																<CFELSE>
																	<B><U>#DayNumbers#</U></B>
																</CFIF>
															<CFELSE>
																#DayNumbers#
															</CFIF>
														</CFOUTPUT>
														</TD>
												<CFELSE>	<!--- Finish current row --->
														<TD STYLE="text-align: CENTER;">
														<CFOUTPUT>
															<CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>
																<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
																	SELECT *
																	FROM schedule_meeting_time
																	WHERE month = '#DateFormat(temp_current_date, 'm')#' AND year = '#DateFormat(temp_current_date, 'yyyy')#' AND moderator_ID = '#session.ID#' AND day = '#DayNumbers#'
																</CFQUERY>
																
																<CFIF meetings.recordcount EQ 0>
																	<U>#DayNumbers#</U>
																<CFELSE>
																	<B><U>#DayNumbers#</U></B>
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
					</TR>
					</TR>
					<TR>
					<TD COLSPAN="3"><br><input type="button"  value="Print this Report" onClick="window.print()"></TD><TD COLSPAN="2"><br><input type="button"  value="Close Window" onClick="window.close()"></TD></TR>
			
				</TABLE>
			</FORM></BODY>
	</HTML>
			