<!--- 
	*****************************************************************************************
	Name:		report_cancelled_mtgs.cfm		
	Function:	displays a list of meetings that have been cancelled. list is selected based
				on date range selected by user	
	History:
	
	*****************************************************************************************
--->
<cfparam name="URL.Action" default="">

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Cancelled Report" showCalendar="0">

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
			<CFSET session.project_code= "#form.project_code#">
		</CFLOCK>


<!--- If days did not exist in calendar being submitted then create variables with negative ones for values --->
<CFPARAM NAME="form.Day29" DEFAULT="-1">
<CFPARAM NAME="form.Day30" DEFAULT="-1">
<CFPARAM NAME="form.Day31" DEFAULT="-1">
<!--- Save changes for month that was edited right before comming to this page --->


	

<STYLE>
TD 

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

<TABLE ALIGN="left" WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="5">
	<TR>
		<TD COLSPAN="5" STYLE="font-size : medium;">
		<B>Cancelled Meetings</B><br>
		<cfoutput>
		<cfif session.project_code EQ 0>
		All Projects<br>
		<cfelse>
		#session.project_code#<br>
		</cfif>
		#session.begin_month#/#session.begin_year# through #session.end_month#/#session.end_year#</cfoutput>
		
		<BR><HR color="#3399FF"><BR>
		</TD> 
	</TR>
	<!--- <CFPARAM NAME="form.dateandtime" DEFAULT="0">
	<CFPARAM NAME="form.availability" DEFAULT="0">
	<CFOUTPUT><CFSET report_dateandtime = "#form.dateandtime#"></CFOUTPUT>
	<CFOUTPUT><CFSET report_availability = "#form.availability#"></CFOUTPUT>
	<CFIF report_dateandtime EQ 1> --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="meetingDT">
		SELECT *
		FROM schedule_meeting_time
		WHERE <cfif session.project_code GT 0>project_code = '#session.project_code#' AND</cfif> status = 1
		ORDER BY project_code, year, Month, Day, start_time;
	</CFQUERY>
	
	<!--- this method converts military time to civilian time --->
	<cfinvoke
		component="pms.com.cfc_time_conversion" 
		method="toCivilian" 
		BeginMilitary="#meetingDT.start_time#"
		EndMilitary="#meetingDT.end_time#"
		returnvariable="CivilianTimeArray"
	>			
	
	<TR>
		<TD COLSPAN="5">
			<TABLE width="600" BORDER="0" CELLPADDING="5" CELLSPACING="5">
				<TR>
					<TD><strong>Project Code</strong></TD>
					<TD><strong>Date</strong></TD>
					<TD><strong>Time</strong></TD>
					<TD></TD>
					<TD><strong>Moderator</strong></TD>
					<TD><strong>Speaker</strong></TD>
				</TR>
		
				<CFSET StrLastCol="">
				<cfscript>
					oSpkrMod = createObject("component","pms.com.cfc_get_piwinfo");
				</cfscript>
				
				<CFOUTPUT QUERY="meetingDT">
					<cfscript>
						GetMod = oSpkrMod.getModSpker(cfcID="#meetingDT.moderator_id#");
						GetSpkr = oSpkrMod.getModSpker(cfcID="#meetingDT.speaker_id#");
						GetAddSpkr = oSpkrMod.getAdditionalSpeakers(cfcRow_ID="#meetingDT.rowid#");
					</cfscript>
				<TR>							
					<TD>#meetingDT.project_code#</TD>
				
					<cfinvoke 
						component="pms.com.cfc_time_conversion" 
						method="toCivilian" 
						returnVariable="CivilianTime" 
						BeginMilitary="#meetingDT.start_time#"
						EndMilitary="#meetingDT.end_time#"
					>
					<cfscript>
						oCivTime = createObject("component","pms.com.cfc_time_conversion");
						TheTime = oCivTime.ConCatTime(#CivilianTime#);
					</cfscript>
					
					<TD>#meetingDT.month#/#meetingDT.day#/#meetingDT.year#</TD>
					<TD>#TheTime# EST</TD><TD></TD>
					<TD>#GetMod#</TD>
					<TD>#GetSpkr##GetAddSpkr#</TD>
				</TR>
				</CFOUTPUT>
				<tr>
					<td colspan="5">&nbsp;</td>
				</tr>		
			</TABLE>
		</TD>
	</TR>
</TABLE>
		
	</CFCASE>
		
	
<!--- If no case is specified user is sent to data entry part of page --->
<!--- Allows user to select months in which meetings will occur --->
<CFDEFAULTCASE>
				<SCRIPT SRC="/includes/libraries/confirm.js"></SCRIPT>
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
						//else
						//{
							///if(document.forms[0].availability.checked || document.forms[0].dateandtime.checked)
							//{
							//	return true;
							//}
							//else
							//{
							//alert("Please select Availability Reporting AND/OR Date And Time Reporting!");
							//return false;
							//}
						//}
					}
				</SCRIPT>

				<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
					SELECT project_code
					FROM piw
					ORDER BY project_code
				</CFQUERY>

				<CFOUTPUT><FORM NAME="form" ACTION="report_cancelled_mtgs.cfm?action=report" METHOD="post" onSubmit="return validate()"></CFOUTPUT>
				
				<TABLE ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="100%">

					
					<TR> 
						<TD>	<!--- Table containing input fields --->
							<TABLE ALIGN="Center" BORDER="0" WIDTH="99%" CELLSPACING="1" CELLPADDING="10">
								
								<TR>
									<TD ALIGN="Center">
											<B>Project Code</B>&nbsp;&nbsp;&nbsp;&nbsp;<SELECT NAME="project_code" SIZE="1">
													<OPTION value="0">All Projects</OPTION>
												<CFOUTPUT QUERY="get_projectcode">
													<OPTION <CFIF (isDefined("session.project_code")) AND (session.project_code EQ trim(project_code))>SELECTED</CFIF>>#trim(project_code)#</OPTION>
												</CFOUTPUT>
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
								
								<!--- <TR>
									<TD ALIGN="center">
										<TABLE BORDER="0">
										<TR>
											<TD ALIGN="right" WIDTH="75%"><B>Show Project Code Day Availability</B></TD>
											<TD ALIGN="left" WIDTH="25%"><INPUT TYPE="CHECKBOX" NAME="availability" VALUE="1"></TD>
										</TR>
										<TR>
											<TD ALIGN="right"><B>Show Project Code Current Scheduled Dates and Times</B></TD>
											<TD ALIGN="left""><INPUT TYPE="CHECKBOX" NAME="dateandtime" VALUE="1"></TD>
										</TR>
										</TABLE>
									</TD>
								</TR> --->
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

	</CFDEFAULTCASE>

</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">