	<HTML><HEAD>
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
				
			</HEAD><BODY>	<TABLE BGCOLOR="#000080" ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="720">
					<TR> 
						<TD CLASS="tdheader">
							
						</TD>
					</TR>
					
					<TR> 
						<TD>	<!--- Table containing input fields --->
							<TABLE ALIGN="Center" WIDTH="99%" CELLSPACING="0" CELLPADDING="10" BORDER="0">
								<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="row">
								SELECT *
								FROM Availability
								WHERE rowid = '#url.rowid#';
								</CFQUERY>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x1#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x2#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x3#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x4#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x5#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row"><B>#row.x6#</B></TD>
									<TD>
									<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
		SELECT *
		FROM schedule_meeting_time
		WHERE Project_code = '#session.project_code#' AND year = '#year#' AND month = '#month#' AND day = '6'
		ORDER BY start_time;
	</CFQUERY>
	</CFOUTPUT>
									<CFIF meetings.recordcount GT 0>
				
										<CFOUTPUT QUERY="Meetings">
											<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerators">
												SELECT DISTINCT firstname, lastname
												FROM spkr_table
												WHERE speaker_id='#moderator_id#'; 
											</CFQUERY>
											<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
												SELECT DISTINCT firstname, lastname
												FROM spkr_table
												WHERE speaker_id='#speaker_id#'; 
											</CFQUERY>
											<TABLE><TR>
												<TD>#start_time#</TD>
												<TD>#end_time#</TD>
												<TD>#GetModerators.firstname# #GetModerators.lastname#</TD>
												<TD>#GetSpeakers.firstname# #GetSpeakers.lastname#</TD>
											</TR></TABLE>
										</CFOUTPUT>
										</CFIF>
									
									
									
									</TD>
									
									
									
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x7#</TD>
									<TD>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
		SELECT *
		FROM schedule_meeting_time
		WHERE Project_code = '#session.project_code#' AND year = '#year#' AND month = '#month#' AND day = '7'
		ORDER BY start_time;
	</CFQUERY>
	</CFOUTPUT>
									<CFIF meetings.recordcount GT 0>
				
										<CFOUTPUT QUERY="Meetings">
											
										</CFOUTPUT>
										</CFIF>
									
									
									
									</TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x8#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x9#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x10#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x11#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x12#</TD>
									<TD>
									<CFQUERY DATASOURCE="#application.projdsn#" NAME="Meetings">
		SELECT *
		FROM schedule_meeting_time
		WHERE Project_code = '#session.project_code#' AND year = '#year#' AND month = '#month#' AND day = '12'
		ORDER BY start_time;
	</CFQUERY>
	</CFOUTPUT>
									<CFIF meetings.recordcount GT 0>
				
										<CFOUTPUT QUERY="Meetings">
											<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerators">
												SELECT DISTINCT firstname, lastname
												FROM spkr_table
												WHERE speaker_id='#moderator_id#'; 
											</CFQUERY>
											<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
												SELECT DISTINCT firstname, lastname
												FROM spkr_table
												WHERE speaker_id='#speaker_id#'; 
											</CFQUERY>
											<TABLE><TR>
												<TD>#start_time#</TD>
												<TD>#end_time#</TD>
												<TD>#GetModerators.firstname# #GetModerators.lastname#</TD>
												<TD>#GetSpeakers.firstname# #GetSpeakers.lastname#</TD>
											</TR></TABLE>
										</CFOUTPUT>
										</CFIF>
									
									
									
									</TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x13#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x14#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x15#</CFOUTPUT></TD>
								</TR><BR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x16#</CFOUTPUT></TD>
								</TR><BR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x17#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x18#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x19#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x20#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x21#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x22#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x23#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x24#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x25#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x26#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x27#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x28#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x29#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x30#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD><CFOUTPUT QUERY="row">#row.x31#</CFOUTPUT></TD>
								</TR>
								<TR>
									<TD ALIGN="Center">
										
									</TD>
								</TR>
										
								<TR>
									<TD ALIGN="Center">
										
									</TD>
								</TR>
								
								<TR>
									<TD>&nbsp;</TD>
								</TR>

								<TR>
						    		<TD ALIGN="center">
										<INPUT TYPE="submit" NAME="submit"  VALUE="Go to Schedule Calendar">
									</TD>
								</TR>
								
							</TABLE>
							</FORM>
						</TD>
					</TR>
				</TABLE></BODY></HTML>