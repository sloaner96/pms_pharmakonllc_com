<!--- 
	*****************************************************************************************
	Name:		meeting_time_add_popup.cfm
	Function:	Popup to select Begin Time, End Time moderator and Speaker For a certain 
				meeting. Send variable back to parent window which update the database.
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->

<HTML>
	<HEAD>
		<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=ISO-8859-1">
		<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">
		<TITLE>Speaker/Moderator Time</TITLE>
		<SCRIPT LANGUAGE="JavaScript">
			function doIT()
				{
					
					if(checkTimes())
					{
					
						var mod_id; 
						var spkr_id;
						var rowid;
						var project_code;
						
						begin_hour=document.meeting_popup.begin_hour.value;
						begin_minute=document.meeting_popup.begin_minute.value;
						begin_meridiem=document.meeting_popup.begin_meridiem.value;
						end_hour=document.meeting_popup.end_hour.value;
						end_minute=document.meeting_popup.end_minute.value;
						end_meridiem=document.meeting_popup.end_meridiem.value;
						
						//mod_id=document.meeting_popup.GetModerators.value;
						//spkr_id=document.meeting_popup.GetSpeakers.value;
						rowid=document.meeting_popup.rowid.value;
						//project_code=document.meeting_popup.project_code.value;
						var url1;
							
						<CFOUTPUT>url1="schedule_time_add.cfm?no_menu=1&refresh=1&day=#Day#&month=#month#&year=#year#&begin_hour=" + begin_hour + "&begin_minute=" + begin_minute + "&begin_meridiem=" + begin_meridiem + "&end_hour=" + end_hour + "&end_minute=" + end_minute + "&end_meridiem=" + end_meridiem + "&mod_id=" + mod_id + "&spkr_id=" + spkr_id + "&rowid=" + rowid + "&ID=#url.ID#";</CFOUTPUT>
						window.opener.location.href = url1;
						if (window.opener.progressWindow) 
							window.opener.progressWindow.close();
						window.close();
					}
					else
					{
						return false;
					}
				}
				
				function checkTimes()
				{
					begin_hour=parseInt(document.meeting_popup.begin_hour.value);
					begin_minute=parseInt(document.meeting_popup.begin_minute.value);
					begin_meridiem=document.meeting_popup.begin_meridiem.value;
					end_hour=parseInt(document.meeting_popup.end_hour.value);
					end_minute=parseInt(document.meeting_popup.end_minute.value);
					end_meridiem=document.meeting_popup.end_meridiem.value;
					
					if(begin_meridiem == 'AM')
					{
						begin_meridiem = 0;
					}
					else
					{
						begin_meridiem = 1;
					}
					
					if(end_meridiem == 'AM')
					{
						end_meridiem = 0;
					}
					else
					{
						end_meridiem = 1;
					}

					if(end_meridiem > begin_meridiem) //end time is greater than begining time.
					{
						return true;
					}
					else if(end_meridiem == begin_meridiem) //meridiems are equal
					{
						if(begin_hour < end_hour) //begining hour is less than ending hour
						{
							return true;
						}
						else if(begin_hour == end_hour) //hours are equal
						{
							if(begin_minute <= end_minute) //begining minute is less than or equal to ending minute
							{
								//the equal part is odd, but technically okay.
								return true;
							}
							else
							{
								alert("The Beginging Time is Later then the Ending Time!")
								return false;
							}
						}
						else //begining hour is more than ending hour
						{
							alert("The Beginging Time is Later then the Ending Time!")
							return false;
						}
					}
					else //PM before AM, not acceptable
					{
						alert("The Beginging Time is Later then the Ending Time.  Check AM and PM!");
						return false;
					}
				}
		</script>
	</HEAD>

	<CFSET year = URL.year>
	<CFSET month = URL.month>
	<CFSET day = URL.day>

								<!--- <B><CFOUTPUT>#mod_list#</CFOUTPUT></B>
								<!--- <I><CFSET length=ListLen(mod_list)></I> --->
								
								<CFOUTPUT>the list contacins #length# #GetModID.recordcount#</CFOUTPUT>!
								
								<CFSET mod_list = "">
								<CFLOOP QUERY="GetModID">#moderator_id#,</CFLOOP> --->
								
								
<!--- pull speakers by client and availability --->	
<!--- <CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
		SELECT DISTINCT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code 
		FROM availability a, spkr_table st, speaker_clients sc
		WHERE a.id = sc.owner_id 
		AND sc.client_code = '#Left(session.project_code, 5)#' 
		<!--- AND speaker_clients.client_id != 1 ---> 
		AND a.id = st.speaker_id
		AND a.year='#URL.year#' 
		AND a.month='#URL.month#' 
		AND a.x#URL.day#=1 
		AND st.type='SPKR'
		ORDER BY st.lastname, st.firstname;
	</CFQUERY> 
		
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerators">
		SELECT DISTINCT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code 
		FROM availability a, spkr_table st, speaker_clients sc
		WHERE a.id = sc.owner_id 
		AND sc.client_code = '#Left(session.project_code, 5)#' 
		<!--- AND speaker_clients.client_id != 1 ---> 
		AND a.id = st.speaker_id
		AND a.year='#URL.year#' 
		AND a.month='#URL.month#' 
		AND a.x#URL.day#=1 
		AND st.type='MOD'
		ORDER BY st.lastname, st.firstname;
	</CFQUERY>--->

	
	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetRowid">			
		SELECT DISTINCT rowid, ID
		FROM availability
		WHERE year='#URL.year#' 
		AND month='#URL.month#'
		AND x#URL.day#=1
		AND ID = #url.ID#;
	</CFQUERY>

	<BODY BGCOLOR="#FFFFFF" ALIGN="center">
		<FORM NAME="meeting_popup" METHOD=POST>
		<CENTER>
		
		
		
			<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
				<TR>
					<TD WIDTH="100">&nbsp;</TD>
				</TR>
				<TR>
					<TD><B>Begin Time</B></TD>
				</TR>
				<TR>
					<TD>
						<TABLE>
							<TR>
								<TD><B>Hour:</B></TD>
								<TD><B>Minute:</B></TD>
								<TD><B>&nbsp;</B></TD>
							</TR>
							<TR>
								<TD>
									<SELECT NAME="begin_hour">
										<OPTION VALUE="01">01</OPTION>	
										<OPTION VALUE="02">02</OPTION>
										<OPTION VALUE="03">03</OPTION>	
										<OPTION VALUE="04">04</OPTION>	
										<OPTION VALUE="05">05</OPTION>	
										<OPTION VALUE="06">06</OPTION>	
										<OPTION VALUE="07">07</OPTION>	
										<OPTION VALUE="08">08</OPTION>	
										<OPTION VALUE="09">09</OPTION>	
										<OPTION VALUE="10">10</OPTION>	
										<OPTION VALUE="11">11</OPTION>	
										<OPTION VALUE="12">12</OPTION>										 
									</SELECT>
								</TD>
								<TD>
									<SELECT NAME="begin_minute">
										<OPTION VALUE="00">00</OPTION>	
										<OPTION VALUE="30">30</OPTION>				 
									</SELECT>
								</TD>
								<TD>
									<SELECT NAME="begin_meridiem">
										<OPTION VALUE="AM">AM</OPTION>	
										<OPTION VALUE="PM" SELECTED>PM</OPTION>										 
									</SELECT>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD><B>End Time</B></TD>
				</TR>
				<TR>
					<TD>
						<TABLE>
							<TR>
								<TD><B>Hour:</B></TD>
								<TD><B>Minute:</B></TD>
								<TD><B>&nbsp;</B></TD>
							</TR>
							<TR>
								<TD>
									<SELECT NAME="end_hour">
										<OPTION VALUE="01">01</OPTION>	
										<OPTION VALUE="02">02</OPTION>
										<OPTION VALUE="03">03</OPTION>	
										<OPTION VALUE="04">04</OPTION>	
										<OPTION VALUE="05">05</OPTION>	
										<OPTION VALUE="06">06</OPTION>	
										<OPTION VALUE="07">07</OPTION>	
										<OPTION VALUE="08">08</OPTION>	
										<OPTION VALUE="09">09</OPTION>	
										<OPTION VALUE="10">10</OPTION>	
										<OPTION VALUE="11">11</OPTION>	
										<OPTION VALUE="12">12</OPTION>										 
									</SELECT>
			
			
								</TD>
								<TD>
									<SELECT NAME="end_minute">
										<OPTION VALUE="00">00</OPTION>	
										<OPTION VALUE="30">30</OPTION>												 
									</SELECT>
								</TD>
								<TD>
									<SELECT NAME="end_meridiem">
										<OPTION VALUE="AM">AM</OPTION>	
										<OPTION VALUE="PM" SELECTED>PM</OPTION>										 
									</SELECT><BR>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<!--- <TR>
					<TD><B>Moderator</B></TD>
				</TR>
				<TR>
					<TD>			
						<TABLE>
							<TR>
								<TD>
								<!--- <CFQUERY DATASOURCE="#application.projdsn#" NAME="GetModID">			
									SELECT moderator_id
									FROM piw_moderators
									WHERE project_code = '#session.project_code#';
								</CFQUERY> --->
								<!--- <CFOUTPUT><CFSET mod_list = ValueList(GetModID.moderator_id)></CFOUTPUT> --->
								<SELECT NAME="GetModerators">
									<option value="">(Select Moderator)
									<CFOUTPUT QUERY="GetModerators">
									<option value="#id#">#lastname#, #firstname#
										<!--- <CFIF #ListContains(mod_list, #speaker_id#)# NEQ 0>
											<OPTION value="#speaker_id#">#trim(firstname)# #trim(lastname)#</OPTION>
										</CFIF>  --->
									</CFOUTPUT>
								</SELECT>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD><B>Speaker</B></TD>
				</TR>
				<TR>
					<TD>
						
						<TABLE>
							<TR>
								<TD>
								<!--- <CFQUERY DATASOURCE="#application.projdsn#" NAME="GetspeakerID">			
									SELECT speaker_id
									FROM piw_speakers
									WHERE project_code = '#session.project_code#';
								</CFQUERY> --->
								<!--- <CFOUTPUT><CFSET speaker_list = ValueList(GetspeakerID.speaker_id)></CFOUTPUT> --->
								<SELECT NAME="GetSpeakers">
									<option value="">(Select Speaker)
									<CFOUTPUT QUERY="GetSpeakers">
									<option value="#id#">#lastname#, #firstname#
									
										<!--- <CFIF #ListContains(speaker_list, #speaker_id#)# NEQ 0>
											<OPTION value="#speaker_id#">#trim(firstname)# #trim(lastname)#</OPTION>
										</CFIF> --->
									</CFOUTPUT>
								</SELECT>
								</TD>
							</TR>
						</TABLE> --->
					</TD>						
				</TR>
				<TR>
					<TD><BR></TD>
				</TR>
			</TABLE>
		<CFOUTPUT QUERY="GetRowid"><INPUT TYPE="hidden" VALUE="#url.id#" NAME="ID"></CFOUTPUT>
		<CFOUTPUT QUERY="GetRowid"><INPUT TYPE="hidden" VALUE="#rowid#" NAME="rowid"></CFOUTPUT>
		<INPUT TYPe="button"  VALUE="Add Availability Time" NAME="send_text" onclick="doIT();"><BR>
		<INPUT TYPe="button"  VALUE="   CANCEL   " NAME="" onclick="window.close()">
		</CENTER>
		</FORM>
	</BODY>
</HTML>