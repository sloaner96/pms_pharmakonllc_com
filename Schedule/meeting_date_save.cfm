<!--- 
	*****************************************************************************************
	Name:		meeting_date_save.cfm
	Function:	Shows user what they have just save into the database for meeting dates.
	History:	Finalized code 8/28/01 TJS
				bj013002 - added buttons at bottom of page.
	
	*****************************************************************************************
--->

<!--- If days did not exist in calendar being submitted then create variables with negative ones for values --->
<CFPARAM NAME="form.Day29" DEFAULT="-1">
<CFPARAM NAME="form.Day30" DEFAULT="-1">
<CFPARAM NAME="form.Day31" DEFAULT="-1">

<!--- Save changes for month that was edited right before comming to this page --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="Save_Schedule2">
	UPDATE schedule_meeting_date
	SET<CFLOOP INDEX="count" FROM=1 TO=30 STEP=1> x#count# = #Evaluate("form.Day#count#")#,</CFLOOP> x31 = #form.Day31#
	WHERE month = #URL.savemonth# AND year = #URL.saveyear# AND Project_code = '#session.Project_code#';
</CFQUERY>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Calendar Review" showCalendar="0">

<!--- <STYLE>
TD {
	font-family : Verdana, Geneva, Arial;
	font-size : x-small;
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
</STYLE>	 --->	
<cfscript>
	ProjectName = createObject("component","pms.com.cfc_get_name");
	projName = ProjectName.getProjName(ProjCode="#session.Project_code#");
</cfscript>
<TABLE ALIGN="Center" BORDER="0" CELLPADDING="0" CELLSPACING="0" align="center">
<tr>
	<td class="ProjectNameHeader">
	<cfoutput>#projName#</cfoutput>
	</td>
</tr>
</table><br>
<TABLE ALIGN="Center" BORDER="0" CELLPADDING="8" CELLSPACING="0" align="center">
<TR bgcolor="#eeeeee">
	<TD COLSPAN="4">
		Please review the scheduling selections <br>you have made for Project code: <B><CFOUTPUT>#session.project_code#</CFOUTPUT></B>
	</TD>
</TR>
<tr>
  <td COLSPAN="4">&nbsp;</td>
</tr>
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
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="Month_Calendar">
			SELECT *
			FROM schedule_meeting_date
			WHERE month = #DateFormat(temp_current_date, 'm')# AND year = #DateFormat(temp_current_date, 'yyyy')# AND Project_code = '#session.project_code#';
		</CFQUERY>
			
		<TD WIDTH="233" align="center">
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
			<TD bgcolor="<CFIF (#Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1) AND (StartDay EQ Counter)>#BECCFF<CFELSE>#FFFFFF</CFIF>">
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
							<TD bgcolor="<CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>#BECCFF<CFELSE>#FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
					<CFELSE>	<!--- Finish current row --->
							<TD bgcolor="<CFIF #Evaluate('Month_Calendar.x#DayNumbers#')# EQ 1>#BECCFF<CFELSE>#FFFFFF</CFIF>"><CFOUTPUT>#DayNumbers#</CFOUTPUT></TD>
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
<tr height=10><td colspan=4>&nbsp;</td></tr>
		<FORM NAME="form" ACTION="meeting_date_select_code.cfm" METHOD="post">
   	<TD ALIGN="right">
		<INPUT TYPE="submit" NAME="submit"  VALUE=" Add Another ">
	</TD>
		</form>
		<FORM NAME="form" ACTION="/index.cfm" METHOD="post">
   	<TD ALIGN="left">
		<INPUT TYPE="submit" NAME="cancel"  VALUE=" Finished ">
	</TD>
		</FORM>
	<td colspan=2>&nbsp;</td>
</TR>
</TABLE>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">