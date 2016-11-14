<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->

<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
	
	<CFCASE VALUE="delete">	
	<CFOUTPUT><CFQUERY DATASOURCE="#application.projdsn#" NAME="meetingDT">
		DELETE FROM schedule_meeting_time
		WHERE rowid = #url.rowid#;
	</CFQUERY></CFOUTPUT>
	
	<META HTTP-EQUIV="refresh" CONTENT="0; Url=meeting_list_delete.cfm?action=report">
	</CFCASE>
			
	<!--- Saves all data inputted from the above form --->
	<CFCASE VALUE="report">
	
		<!--- Defines variables needed within the page both from the previous form and URL --->
		<CFLOCK SCOPE="SESSION" TIMEOUT="30" TYPE="EXCLUSIVE">
			<CFIF NOT IsDefined("session.project_code")>
				<CFSET session.project_code= "#form.project_code#">
			</CFIF>
		</CFLOCK>
<CFIF IsDefined("session.id")>
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="speaker_id">
		SELECT lastname, firstname
		FROM spkr_table
		WHERE speaker_id = '#session.id#';
	</CFQUERY>
	 </CFIF>
		<HTML>
			<HEAD>
				<TITLE>Calendar Review Page</TITLE>
				
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
				<SCRIPT>
				function validate() 
				{				
					var msg = confirm("Are you sure you want to delete this date. \nOnce the date is deleted, you will need \nto go back into the scheduler module to assign this date and time.")
					if (msg == true)
						return true;
					else
						return false;
				}
				</script>
				</SCRIPT>
			</HEAD>
			
			<BODY BGCOLOR="FFFFFF" MARGINHEIGHT="0" MARGINWIDTH="0">
				
				<TABLE ALIGN="left" WIDTH="650" BORDER="0" CELLPADDING="2" CELLSPACING="2">
					<TR>
						<TD COLSPAN="5" STYLE="font-size : large;">
						Schedule Edit: <B><CFOUTPUT>#session.project_code#</CFOUTPUT></B><BR><HR><BR>
						</TD> 
					</TR>
					
					<CFQUERY DATASOURCE="#application.projdsn#" NAME="meetingDT">
						SELECT *
						FROM schedule_meeting_time
						WHERE project_code = '#session.project_code#'
						ORDER BY year,Month,Day,start_time;
					</CFQUERY>
					<TR>
						<TD COLSPAN="5" ALIGN="left" STYLE="text-align: left; font-size : small;"> Current Scheduled Meeting Dates and Times for <CFOUTPUT><U><B>#session.project_code#</B></CFOUTPUT></U><br></TD>	
					</TR>
					<TR><TD COLSPAN="5"><TABLE BORDER="0" CELLPADDING="2" CELLSPACING="2">
					<TR>
						<TD><U>Date</U></TD>
						<TD><U>Time</U></TD>
						<TD><U>Moderator</U></TD>
						<TD><U>Speaker</U></TD>
						<TD></TD>
						<TD></TD>
					</TR>
					<TR><TD>&nbsp;</TD></TR>
					<CFLOOP QUERY="meetingDT"><TR>
						<CFOUTPUT>
						<TD>#month#/#day#/#year#</TD>
						<TD>#start_time# to #end_time#</TD>
						<TD>
							<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="mod_id">
								SELECT lastname, firstname
								FROM spkr_table
								WHERE speaker_id = '#moderator_id#';
							</CFQUERY>
							#mod_id.lastname#, #mod_id.firstname#
						</TD>
						<TD>
							<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="sp_id">
								SELECT lastname, firstname
								FROM spkr_table
								WHERE speaker_id = '#speaker_id#';
							</CFQUERY>
							#sp_id.lastname#, #sp_id.firstname#
						</TD>
						<TD></TD>
						<TD>
						<FORM NAME="form" ACTION="meeting_list_delete.cfm?action=delete&rowid=#rowid#" METHOD="post" onSubmit="return validate()">
							<INPUT TYPE="submit" NAME="submit"  VALUE="   Delete   ">
						</FORM></TD></TR>
						</CFOUTPUT></CFLOOP>
				</TABLE>
			</BODY>
		</HTML>
		
	</CFCASE>
		
	
<!--- If no case is specified user is sent to data entry part of page --->
<!--- Allows user to select months in which meetings will occur --->
<CFDEFAULTCASE>
		
		<HTML>
			<HEAD>
				<TITLE>Project Initiation Form - General Information</TITLE>
				<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
			</HEAD>
		
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
					SELECT project_code
					FROM piw
					WHERE project_status = 0	
					ORDER BY project_code
				</CFQUERY>
			<BODY>
				<CFOUTPUT><FORM NAME="form" ACTION="meeting_list_delete.cfm?action=report" METHOD="post"></CFOUTPUT>
				
				<TABLE BGCOLOR="#000080" ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="720">
					<TR> 
						<TD CLASS="tdheader">
							Project Code Meeting Reporting
						</TD>
					</TR>
					
					<TR> 
						<TD>	<!--- Table containing input fields --->
							<TABLE ALIGN="Center" BORDER="0" WIDTH="99%" CELLSPACING="1" CELLPADDING="10">
								
								<TR>
									<TD ALIGN="Center">
											<B>Project Code</B>&nbsp;&nbsp;&nbsp;&nbsp;<SELECT NAME="project_code" SIZE="1">
												<CFOUTPUT QUERY="get_projectcode">
													<OPTION <CFIF (isDefined("session.project_code")) AND (session.project_code EQ trim(Project_code))>SELECTED</CFIF>>#trim(Project_code)#</OPTION>
												</CFOUTPUT>
											</SELECT>
									</TD>
								</TR>
								
								

								<TR>
						    		<TD ALIGN="center">
										<INPUT TYPE="submit" NAME="submit"  VALUE="   LIST ALL   ">
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
