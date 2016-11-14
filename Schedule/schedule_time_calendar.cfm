<!--- 
	*****************************************************************************************
	Name:		schedule_time_calendar.cfm
	Function:	Displays selected month, each day can be one of three colors
				white for not available, grey for no meeting can be held on this day at all,
				and peach for available on that day; NOTE number of meetings per one day 
				outputted into PEACH TDs.
	
	
	*****************************************************************************************
--->

<!--- The current month and date which were passed via URL from last form --->
<CFSET month = URL.month>
<CFSET year = URL.year>
<link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
<!--- Script that changes a calendar day to available/unavailable and changes the --->
<!--- value of the hidden field for that day --->

<CFOUTPUT>
<FORM NAME="form" action="schedule_time_calendar.cfm?year=#year#&month=#month#" METHOD="post">
</CFOUTPUT>
<HTML>
	<HEAD>
		<TITLE>Moderator/Speaker Time Schedule Calendar</TITLE>
		
		<link rel="stylesheet" type="text/css" media="all" href="../includes/styles/schedule.css" title="tas" />
		<SCRIPT LANGUAGE="JavaScript">
			function change_status_day(tempvar, Day)
			{	
				<CFOUTPUT>
					window.open('schedule_time_add.cfm?id=#id#&no_menu=1&day=' + Day.value + '&month=#month#&year=#year#','','width=600,height=500,left=295,top=298');
				</CFOUTPUT>
				//open('meeting_time_popup.cfm?no_menu=1&day=#Day#&month=#month#&year=#year#', 'meeting_time', 'width=215,height=275')">
			}
		</SCRIPT>
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
	<SCRIPT LANGUAGE="JavaScript" src="popup_help.js"></script>
	<cfscript>
	SpkMod = createObject("component","pms.com.cfc_get_name");
	SpkModName = SpkMod.getSpkrModName(SpkrModCode="#url.id#");
	</cfscript>
	<a href="javascript:history.go(-1)"><u>Back</u></a>
	<TABLE ALIGN="Center" BORDER="0" CELLPADDING="0" CELLSPACING="0">
	<tr>
		<td class="ProjectNameHeader">
		<cfoutput>#SpkModName#</cfoutput>
		</td>
	</tr>
	</table>
		<TABLE ALIGN="Center" BORDER="0" CELLPADDING="0" CELLSPACING="0">
			<TR>
				<!--- Month name for the current month (large calendar) --->
				<TD ALIGN="Center">
					<TABLE ALIGN="Center" WIDTH="100%" BORDER="0" CELLSPACING="6" CELLPADDING="0">
						<TR>
							<TD WIDTH="100%">
								<CFOUTPUT>
									&nbsp;&nbsp;&nbsp;&nbsp;<FONT SIZE="+1"><B>#MonthAsString(month)#</B></FONT>&nbsp;&nbsp;&nbsp;&nbsp;
								</CFOUTPUT>
							</TD>
						</TR>
						
						<TR ALIGN="Center">
							<TD ALIGN="Center" WIDTH="100%">
								
				<!--- Query to find if any days are already selected --->
				<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Main_Calendar">
						SELECT *
						FROM availability
						WHERE ID = #url.ID# AND year = '#year#' AND month = '#month#';
				</CFQUERY>
	<!--- start display of calendar --->							
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
										
				<!--- find what is the first day of the month. example, if Jan 1 is a wed.,
						this function returns the number 4 ---->
				<CFSET StartDay = DayOfWeek(CreateDate(year, month, 1))>
					<!--- Find Number of Days in Month --->
					<CFSET DaysMonth = DaysInMonth(CreateDate(year, month, 1))>
						<CFSET DayNumbers = 1>
						<CFSET Counter = 1>
						
									
			<TR HEIGHT="50">
			<!---**** This loop is to set ONLY the first day of the month ****--->
				<CFLOOP CONDITION = "DayNumbers EQ 1">
				<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Meetings">
					SELECT *
					FROM availability_time
					WHERE owner_id = #url.id# AND year = #year# AND month = #month# AND day = #DayNumbers#<!---  AND allday = 0 --->;
				</CFQUERY>
				<!--- ****** Set the color and funtionality of the square for the day. If
				square is part of last month, make it uneditable and gray  --->
				<CFIF StartDay EQ Counter>
					<!--- set square white if available, gray if unavailable --->						 
					<CFIF #Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1>
						<TD onClick="return change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: FFFFFF">
					<CFELSE>
						<TD STYLE="background-color: CCCCCC; color : 999999">
					</CFIF>
				<!--- this td handles squares (days) that are part of last month --->
				<cfelse>
						<TD STYLE="background-color: CCCCCC; color : 999999">
				</cfif>
				<!--- ****** --->
			<!--- display day of month and if availability is partial or full --->	
			<CFIF StartDay EQ Counter>
				<CFOUTPUT>
				<INPUT TYPE="Hidden" NAME="Day#DayNumbers#" VALUE="#DayNumbers#">
				<U>#DayNumbers#</U>
				</CFOUTPUT>
				<CFIF (#Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1) AND (Meetings.allday EQ 2)><BR><BR>Partial</CFIF>

					<CFSET DayNumbers = 2>
				<CFELSE>
					&nbsp;
			</CFIF>
						</TD>
					<CFSET Counter = Counter + 1>
				</CFLOOP><!--- ****end loop for first day of month**** --->
									
			<!---********	Now create the rest of days ************--->
			<CFLOOP CONDITION = "(DayNumbers LTE DaysMonth) OR  ((DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1))">
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="Meetings">
				SELECT *
				FROM availability_time
				WHERE owner_id = #url.id# AND year = '#year#' AND month = '#month#' AND day = '#DayNumbers#' <!--- AND allday = 0 --->;
			</CFQUERY>
	<!--- create a new square for the rest of the days --->										
	<CFIF DayNumbers LTE DaysMonth>	
		<CFIF (Counter MOD 7) EQ 1>	<!--- Start a new row --->
			</TR>
			<TR HEIGHT="50">
			<!--- set color and editability of square --->											
			<CFIF #Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1>
					<TD onClick="change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: FFFFFF">
			<CFELSE>
					<TD STYLE="background-color: CCCCCC; color : 999999">
			</CFIF>
														
			<CFOUTPUT>
				<INPUT TYPE="Hidden" NAME="Day#DayNumbers#" VALUE="#DayNumbers#">
					#DayNumbers#
			</CFOUTPUT>
					</TD>
		<CFELSE>
														
			
			<CFIF #Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1>
					<TD onClick="change_status_day(this, form.Day<CFOUTPUT>#DayNumbers#</CFOUTPUT>);" onMouseOver="this.style.cursor='hand';" STYLE="background-color: FFFFFF">
			<CFELSE>
					<TD STYLE="background-color: CCCCCC; color : 999999">
			</CFIF>
														
				<CFOUTPUT>
				<INPUT TYPE="Hidden" NAME="Day#DayNumbers#" VALUE="#DayNumbers#">
				<U>#DayNumbers#</U>
																
				</CFOUTPUT>
			<!--- If mod/speaker is not available the full day, display PARTIAL --->													
				<CFIF (#Evaluate("Main_Calendar.x#DayNumbers#")# EQ 1) AND (Meetings.allday EQ 2)><BR><BR><CFOUTPUT>Partial</CFOUTPUT></CFIF>
															
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
				<TABLE border="0" WIDTH="60%" cellspacing="0" cellpadding="0">
									<TR>
										<TD>&nbsp;</TD>
										<TD>&nbsp;</TD>
										<TD colspan="5">&nbsp;</TD>
									</TR>
									<TR>
										<TD align="right" style="background:FFFFFF; border: 1px solid black">&nbsp;&nbsp;&nbsp;</TD>
										<TD align="left">Denotes Available</TD>
										<TD>&nbsp;&nbsp;&nbsp;</TD>
										<TD>
											<CFOUTPUT><INPUT TYPE="Button"  VALUE="Return to Month Index" onClick=window.location.href='schedule_time_list.cfm?ID=#URL.ID#'>
											</CFOUTPUT>
										</TD>
										<TD>&nbsp;&nbsp;&nbsp;</TD>
										<TD align="right" style="background:CCCCCC; border: 1px solid black">&nbsp;&nbsp;&nbsp;</TD>
										<TD align="left">Denotes Unavailable</TD>
										<TD>&nbsp;</TD>
									</TR>
								</TABLE>
								</CENTER>
								
							
								
												
		<!--- End Large Calendar --->
							</TD>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
		<center><a href="javascript:OpenWindow('schedule_help.htm#schedule_time_calendar')"><img src="../images/help.gif" border="0"></a></center>
	</BODY>
</HTML>
