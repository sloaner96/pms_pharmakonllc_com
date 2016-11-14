<!--- 
	*****************************************************************************************
	Name:		schedule_save.cfm
	Function:	Lists the changes that have been made and saved.
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->

<!--- If days did not exist in calendar being submitted then create variables with negative ones for values --->
<CFPARAM NAME="form.Day29" DEFAULT="-1">
<CFPARAM NAME="form.Day30" DEFAULT="-1">
<CFPARAM NAME="form.Day31" DEFAULT="-1">


<!--- Save changes for month that was edited right before comming to this page --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Save_Schedule2">
	UPDATE availability
	SET<CFLOOP INDEX="count" FROM=1 TO=30 STEP=1> x#count# =#Evaluate("form.Day#count#")#,</CFLOOP> x31 = #form.Day31#
	WHERE month = #URL.savemonth# AND year = #URL.saveyear# AND ID = '#session.ID#';
</CFQUERY>

<!--- Save changes for days/times that was edited right before coming to this page. Mark 1 if available, 0 if not --->
<CFLOOP INDEX="count" FROM=1 TO=31 STEP=1>
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Save_Time2">
	UPDATE availability_time
	SET x0050 =#Evaluate("form.Day#count#")#, x0100 =#Evaluate("form.Day#count#")#, 
	x0150 =#Evaluate("form.Day#count#")#, x0200 =#Evaluate("form.Day#count#")#, 
	x0250 =#Evaluate("form.Day#count#")#, x0300 =#Evaluate("form.Day#count#")#, 
	x0350 =#Evaluate("form.Day#count#")#, x0400 =#Evaluate("form.Day#count#")#, 
	x0450 =#Evaluate("form.Day#count#")#, x0500 =#Evaluate("form.Day#count#")#, 
	x0550 =#Evaluate("form.Day#count#")#, x0600 =#Evaluate("form.Day#count#")#, 
	x0650 =#Evaluate("form.Day#count#")#, x0700 =#Evaluate("form.Day#count#")#, 
	x0750 =#Evaluate("form.Day#count#")#, x0800 =#Evaluate("form.Day#count#")#, 
	x0850 =#Evaluate("form.Day#count#")#, x0900 =#Evaluate("form.Day#count#")#, 
	x0950 =#Evaluate("form.Day#count#")#, x1000 =#Evaluate("form.Day#count#")#, 
	x1050 =#Evaluate("form.Day#count#")#, x1100 =#Evaluate("form.Day#count#")#, 
	x1150 =#Evaluate("form.Day#count#")#, x1200 =#Evaluate("form.Day#count#")#, 
	x1250 =#Evaluate("form.Day#count#")#, x1300 =#Evaluate("form.Day#count#")#, 
	x1350 =#Evaluate("form.Day#count#")#, x1400 =#Evaluate("form.Day#count#")#, 
	x1450 =#Evaluate("form.Day#count#")#, x1500 =#Evaluate("form.Day#count#")#, 
	x1550 =#Evaluate("form.Day#count#")#, x1600 =#Evaluate("form.Day#count#")#, 
	x1650 =#Evaluate("form.Day#count#")#, x1700 =#Evaluate("form.Day#count#")#, 
	x1750 =#Evaluate("form.Day#count#")#, x1800 =#Evaluate("form.Day#count#")#, 
	x1850 =#Evaluate("form.Day#count#")#, x1900 =#Evaluate("form.Day#count#")#, 
	x1950 =#Evaluate("form.Day#count#")#, x2000 =#Evaluate("form.Day#count#")#, 
	x2050 =#Evaluate("form.Day#count#")#, x2100 =#Evaluate("form.Day#count#")#, 
	x2150 =#Evaluate("form.Day#count#")#, x2200 =#Evaluate("form.Day#count#")#, 
	x2250 =#Evaluate("form.Day#count#")#, x2300 =#Evaluate("form.Day#count#")#, 
	x2350 =#Evaluate("form.Day#count#")#, x2400 =#Evaluate("form.Day#count#")#, 
	allday =#Evaluate("form.Day#count#")#, 	updated = #Now()#, updated_userid = #session.userinfo.rowid# 
	WHERE month = #URL.savemonth# AND year = #URL.saveyear# AND day = #count# AND speakerid = '#session.ID#';
</CFQUERY>
</CFLOOP>

<!--- this method checks to see if the mod/speaker has any meetings scheduled for this month. If so, those times
are marked unavailable --->
	<cfinvoke
		component="pms.com.cfc_checkdates" 
		method="UpdateUnavailable" 
		savemonth="#url.savemonth#"
		saveyear="#url.saveyear#"
		id="#session.ID#"
		today="#createodbcdate(Now())#"
		userid="#session.userinfo.rowid#"
	>



<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="speakerid">
		SELECT lastname, firstname
		FROM Speaker
		WHERE speakerid = '#session.id#';
	</CFQUERY>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Search for Schedule" showCalendar="0">

	
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
		

	

		<cfscript>
			SpkMod = createObject("component","pms.com.cfc_get_name");
			SpkModName = SpkMod.getSpkrModName(SpkrModCode="#session.id#");
		</cfscript>
		<TABLE ALIGN="Center" WIDTH="750" BORDER="0" CELLPADDING="0" CELLSPACING="0">
		<tr>
			<td class="ProjectNameHeader">
			<cfoutput>#SpkModName#</cfoutput>
			</td>
		</tr>
		</table>
		
		<TABLE ALIGN="Center" WIDTH="700" BORDER="0" CELLPADDING="10" CELLSPACING="20">
			<TR>
				<TD COLSPAN="4">
					Please review the changes you have made for <B><CFOUTPUT QUERY="speakerid">#firstname# #lastname#</CFOUTPUT></B>
				</TD>
			</TR>
						
			<TR>		
				<!--- Gets the date for the previous month and the next month --->
				<CFSET temp_current_date = CreateDate(session.begin_year, session.begin_month, 1)>
				<CFSET temp_end_date = CreateDate(session.end_year, session.end_month, 1)>
				
				<CFSET rowcounter = 0>
							
				<CFLOOP Condition="(DateCompare(temp_current_date, temp_end_date) NEQ 1)">
					<CFIF (rowcounter MOD 3) EQ 0>
						</TR>
						<TR>
					</CFIF>
					<!--- Begin Mini Calendar --->
				
					<!--- Query to find if any days are already selected --->
					<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Month_Calendar">
						SELECT *
						FROM Availability
						WHERE month = #DateFormat(temp_current_date, 'm')# AND year = #DateFormat(temp_current_date, 'yyyy')# AND ID = '#session.ID#';
					</CFQUERY>
			
					<TD WIDTH="233"><a href="schedule_time_calendar.cfm?ID=#ID#&year=#year#&month=#month#"></a>
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
							
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
												<TD STYLE="background-color: <CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>6699FF<CFELSE>FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
										<CFELSE>	<!--- Finish current row --->
												<TD STYLE="background-color: <CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>6699FF<CFELSE>FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
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
			<tr><td>
			<form name="edit" action="schedule_search.cfm" method="post">
				<input type="submit"  value="Search Again" name="schedule_button">		
			</form>
				</td></tr>
		</TABLE>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
