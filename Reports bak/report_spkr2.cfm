
<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Speaker Report" showCalendar="0">

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
		</CFLOCK>


<!--- If days did not exist in calendar being submitted then create variables with negative ones for values --->
<CFPARAM NAME="form.Day29" DEFAULT="-1">
<CFPARAM NAME="form.Day30" DEFAULT="-1">
<CFPARAM NAME="form.Day31" DEFAULT="-1">
<!--- Save changes for month that was edited right before comming to this page --->

<!--- <CFQUERY DATASOURCE="#application.speakerDSN#" NAME="speaker_id">
		SELECT lastname, firstname
		FROM spkr_table
		WHERE speaker_id = '#session.id#';
	</CFQUERY> --->
	
    
			
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
			
				<FORM NAME="form" ACTION="" METHOD="post">
				<TABLE ALIGN="left" WIDTH="650" BORDER="1" CELLPADDING="5" CELLSPACING="5">
					<TR>
						<TD COLSPAN="5">
						<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetName">
							SELECT DISTINCT firstname, lastname
							FROM spkr_table
							WHERE speaker_id='#session.id#'; 
						</CFQUERY>
						Reports for: <B>< CFOUTPUT QUERY="getname">#firstname# #lastname#</CFOUTPUT></B>
						</TD> 
					</TR>
					<CFPARAM NAME="form.dateandtime" DEFAULT="0">
					<CFPARAM NAME="form.availability" DEFAULT="0"><CFOUTPUT>#form.dateandtime#,#form.availability#</CFOUTPUT>
					<CFOUTPUT><CFSET report_dateandtime = "#form.dateandtime#"></CFOUTPUT>
					<CFIF report_dateandtime EQ 1>
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="meetingDT">
						SELECT *
						FROM schedule_meeting_time
						WHERE moderator_id = '#session.id#' OR speaker_id = '#session.id#'
						ORDER BY year,Month,Day,start_time;
					</CFQUERY>
					<TR> 
					<CFOUTPUT QUERY="meetingDT">
					
						<TD>#month#/#day#/#year#<br>#start_time# to #end_time#<br>#PROJECT_CODE#</TD>
						<cfif meetingDT.CURRENTROW MOD 5 EQ 0></TR><TR></CFIF>
					</CFOUTPUT></TR>
					<!--- <CFOUTPUT>#session.id#</CFOUTPUT> --->
					</CFIF>
												
							
					<CFOUTPUT><CFSET report_availability = "#form.availability#"></CFOUTPUT>
					<CFIF report_availability EQ 1>	
					<TR>
						
						<!--- Gets the date for the previous month and the next month --->
						<CFSET temp_current_date = CreateDate(session.begin_year, session.begin_month, 1)>
						<CFSET temp_end_date = CreateDate(session.end_year, session.end_month, 1)>
						
						<CFSET rowcounter = 0>
									
						<CFLOOP Condition="(DateCompare(temp_current_date, temp_end_date, 'm/dd/yyyy') NEQ 1)">
							
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
							
							<TD WIDTH="233" <CFIF month_calendar.recordcount NEQ 0> onClick="form.action='report_calendar.cfm?rowid=<CFOUTPUT>#month_calendar.rowid#</CFOUTPUT>'; form.submit();" STYLE="cursor : hand"</CFIF>>
								<TABLE  BORDER="0" CELLPADDING="0" CELLSPACING="0">
									
									<TR ALIGN="Center" HEIGHT="15">
										<TD WIDTH="70%" COLSPAN="7"><B><CFOUTPUT>#MonthAsString(DateFormat(temp_current_date, 'm'))#, #DateFormat(temp_current_date, 'yyyy')#</CFOUTPUT></B></TD>
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
											<TD STYLE="background-color: <CFIF (#Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1) AND (StartDay EQ Counter)>6699FF<CFELSE>FFFFFF</CFIF>">
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
														<TD STYLE="background-color: <CFIF (#Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1) AND (StartDay EQ Counter)>6699FF<CFELSE>FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
												<CFELSE>	<!--- Finish current row --->
														<TD STYLE="@media screen {background-color: <CFIF (#Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1) AND (StartDay EQ Counter)>6699FF<CFELSE>FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
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
				<CFOUTPUT><FORM NAME="form" ACTION="report_spkr2.cfm?action=report" METHOD="post" onSubmit="return validate()"></CFOUTPUT>
				
				<TABLE BGCOLOR="#000080" ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="720">
					<TR> 
						<TD CLASS="tdheader">
							<!--- <CFOUTPUT>
								Meeting Month Selection for #session.project_code#
							</CFOUTPUT> --->
						</TD>
					</TR>
					
					<TR> 
						<TD>	<!--- Table containing input fields --->
							<TABLE ALIGN="Center" WIDTH="99%" CELLSPACING="0" CELLPADDING="10" BORDER="0">
								
								<TR>
									<TD>
									<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="person">
							SELECT *
							FROM spkr_table
						</CFQUERY>	
						<SELECT NAME="person_id">
						<CFOUTPUT query="person"><OPTION VALUE=#speaker_id#>#lastname#, #Firstname##speaker_id#</CFOUTPUT>
						</SELECT>	</TD>
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
									<TD><INPUT TYPE="CHECKBOX" NAME="availability" VALUE="1">AVAIL</TD>
									<TD>||||</TD>
									<TD><INPUT TYPE="CHECKBOX" NAME="dateandtime" VALUE="1">MEETING DATES</TD>
								</TR>

								<TR>
						    		<TD ALIGN="center">
										<INPUT TYPE="submit" NAME="submit"  VALUE="report it">
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
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
