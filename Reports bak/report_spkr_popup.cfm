<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Speaker Schedule Report (Printable Version)</title>
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
			
		<BODY BGCOLOR="White" MARGINHEIGHT="0" MARGINWIDTH="0">
				<FORM NAME="form" ACTION="" METHOD="post">
				<TABLE ALIGN="left" WIDTH="650" BORDER="0" CELLPADDING="5" CELLSPACING="5">
					<TR>
						<TD COLSPAN="5">
						<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetName">
							SELECT DISTINCT firstname, lastname
							FROM spkr_table
							WHERE speaker_id='#session.id#' AND type='SPKR'; 
						</CFQUERY>
						<FONT SIZE="+2" STYLE="font-size : large;">Report for: <B><CFOUTPUT>#getname.firstname# #getname.lastname#</CFOUTPUT><HR></B></FONT>
						</TD> 
					</TR>
												
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="meetingDT">
						SELECT *
						FROM schedule_meeting_time
						WHERE speaker_id = '#session.id#' AND month BETWEEN <CFOUTPUT>#session.begin_month#</CFOUTPUT> AND <CFOUTPUT>#session.end_month#</CFOUTPUT> AND year BETWEEN <CFOUTPUT>#session.begin_year#</CFOUTPUT> AND <CFOUTPUT>#session.end_year#</CFOUTPUT>
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
										<TR>
											<TD STYLE="text-align: right; font-weight: bold;">#start_time# to #end_time#</TD>
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
										<TR>
											<TD STYLE="text-align: right; font-weight: bold;">#month#/#day#/#year#</TD>
											<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
											<TD>#start_time# to #end_time#</TD>
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
									
									<TR>
										<TD>
											<cfif StrLastCol NEQ #project_code#>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											#project_code#&nbsp;&nbsp;
											<CFSET StrLastCol = "#project_code#">
											</CFIF></TD>
										<TD STYLE="text-align: right;">#month#/#day#/#year#&nbsp;&nbsp;</TD>
										<TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
										<TD>#start_time# to #end_time#</TD>
									</TR>
									<CFSET temp_project_code = #project_code#>
									</CFOUTPUT>
								</CFIF>
								
								</TR>
							<TR><TD COLSPAN="3"><br><input type="button"  value="Print this Report" onClick="window.print()"></TD><TD COLSPAN="3"><br><input type="button"  value="Close Window" onClick="window.close()"></TD></TR>
						</TABLE>
						</TD>
						</TR>
					
				</TABLE>
			</FORM>
		</BODY>
	</HTML>
	