<!--- 
	*****************************************************************************************
	Name:		meeting_time_add_popup.cfm
	Function:	Popup to select Begin Time, End Time moderator and Speaker For a certain 
				meeting. Send variable back to parent window which update the database.
	History:	Finalized code 8/28/01 TJS
				10/28/02LB - put in code to check for meeting types that do not have a speaker. If meeting type does not need a speaker, do not display speaker select box. meeting types are stored in session.nospeaker
	
	*****************************************************************************************
--->

<HTML>
<HEAD>
<LINK REL=STYLESHEET HREF="piw1style.css" TYPE="TEXT/CSS">
<TITLE>Meeting Time</TITLE>
<style>
TD.HeadingCell
{
	padding-top: 4px;
}

TD.TextAreaCell
{
	padding-bottom: 4px;
}
</style>
<SCRIPT LANGUAGE="JavaScript">
function doIT()
{
	
	if(checkTimes() && checkModSpkr())
	{
		var bt;
		var et; 
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
		sequence=document.meeting_popup.GetSequence.value;
		mod_row_id=document.meeting_popup.GetModerators.value;
		spkr_row_id=document.meeting_popup.GetSpeakers.value;
		rowid=document.meeting_popup.rowid.value;
		project_code=document.meeting_popup.project_code.value;
		for(i=0;i<document.meeting_popup.meeting_use.length;i++)
	{
		if(document.meeting_popup.meeting_use[i].checked)
		meeting_use=document.meeting_popup.meeting_use[i].value;
	}
		TextRemarks=document.meeting_popup.remarks.value;
		var url1;
		<CFOUTPUT>url1="meeting_time_add.cfm?no_menu=1&refresh=1&day=#Day#&month=#month#&year=#year#&begin_hour=" + begin_hour + "&begin_minute=" + begin_minute + "&begin_meridiem=" + begin_meridiem + "&end_hour=" + end_hour + "&end_minute=" + end_minute + "&end_meridiem=" + end_meridiem + "&mod_row_id=" + mod_row_id + "&sequence=" + sequence + "&spkr_row_id=" + spkr_row_id + "&meeting_use=" + meeting_use + "&rowid=" + rowid + "&project_code=" + project_code + "&remark=" + TextRemarks;</CFOUTPUT>
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
	
	//Because values are stored as 08, sometimes parseInt returns zero. 
	//Need to correct problem.
	if(begin_hour == 0)
	{
		var temp = document.meeting_popup.begin_hour.value;
		temp = temp.slice(1,2)
		begin_hour = parseInt(temp);
	}
	if(end_hour == 0)
	{
		var temp = document.meeting_popup.end_hour.value;
		temp = temp.slice(1,2)
		end_hour = parseInt(temp);
	}
	

	//If users selects Noon as a start time, need to set to zero so 1:00 is GT than Noon.
	if(begin_hour == 12 && end_meridiem == 'PM')
	{
		begin_hour = 0;
	}
	///User selects Midnight as an end time
	else if(end_hour == 12 && end_meridiem == 'PM')
	{
		end_hour = 0;
	}

	
	//Set Meridiems to integer so we can compare
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
				alert("The Begining Time is Later then the Ending Time!")
				return false;
			}
		}
		else //begining hour is more than ending hour
		{
			alert("The Begining Time is Later then the Ending Time!")
			return false;
		}
	}
	else //PM before AM, only acceptable if meeting occurs at night.
	{
		if(begin_hour >= 9)
		{
			return true;	
		}
		else
		{
			alert("The Begining Time is Later then the Ending Time.  Check AM and PM!");
			return false;
		}
	}
}

function checkModSpkr()
{
	if(document.meeting_popup.GetModerators.value != "NULL")
	{
		if(document.meeting_popup.GetSpeakers.value != "NULL")
		{
			return true;
		}
		else
		{
			alert("Please Select a Speaker");
			return false;
		}
		
	}
	else
	{
		alert("Please Select a Moderator");
		return false;
	}
}

function ChangeEndHour()
{
	var b_hour = parseInt(document.meeting_popup.begin_hour.value)
	
	if(b_hour == 0)
	{
		var temp = document.meeting_popup.begin_hour.value;
		temp = temp.slice(1,2)
		b_hour = parseInt(temp);
	}
		
	if(b_hour == 12)
	{
		b_hour = 0;
	}
	
	/*because JS is 0 based, no need to add 1 to b_hour because the array index is one 
	more than the value already.*/
	document.meeting_popup.end_hour.options[b_hour].selected = true;
}

</script>
</HEAD>

<CFSET year = URL.year>
<CFSET month = URL.month>
<CFSET day = URL.day>

								
<!--- pull speakers by client and availability --->	
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
	SELECT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code, sc.rowid as spkrrow, sc.fee 
	FROM availability a, spkr_table st, speaker_clients sc
	WHERE st.active = 'ACT' AND a.id = sc.owner_id 
	AND sc.client_code = '#Left(session.project_code, 5)#' 
	<!--- AND speaker_clients.client_id != 1 ---> 
	AND a.id = st.speaker_id
	AND a.year=#URL.year# 
	AND a.month=#URL.month# 
	AND a.x#URL.day#=1 
	AND st.type='SPKR'
	ORDER BY st.lastname, st.firstname;
</CFQUERY>
		
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerators">
	SELECT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code, sc.rowid as moderrow, sc.fee 
	FROM availability a, spkr_table st, speaker_clients sc
	WHERE st.active = 'ACT' AND a.id = sc.owner_id 
	AND sc.client_code = '#Left(session.project_code, 5)#' 
	<!--- AND speaker_clients.client_id != 1 ---> 
	AND a.id = st.speaker_id
	AND a.year=#URL.year# 
	AND a.month=#URL.month# 
	AND a.x#URL.day#=1 
	AND st.type='MOD'
	ORDER BY st.lastname, st.firstname;
</CFQUERY>


<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetRowid">			
	SELECT DISTINCT rowid, project_code
	FROM schedule_meeting_date
	WHERE year=#URL.year# 
	AND month=#URL.month#
	AND x#URL.day#=1
	AND project_code = '#session.project_code#';
</CFQUERY>

<BODY BGCOLOR="#FFFFFF" ALIGN="center">
<!---*********************************************************************
	Removed this check for spkrs and mods to allow meetings to be set up with TBDs
***************************************************************************--->
<!--- if speaker count is 0 and this meeting needs a speaker or the moderator count is 0... --->
<!--- <cfif (#GetSpeakers.recordcount# LT 1 AND #ListFindNoCase("#session.nospeaker#", "#right(session.project_code,2)#")# EQ 0) OR #GetModerators.recordcount# LT 1>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<TR>
		<TD WIDTH="100">&nbsp;</TD>
	</TR>
	<TR>
		<cfif #GetSpeakers.recordcount# LT 1 AND #ListFindNoCase("#session.nospeaker#", "#right(session.project_code,2)#")# EQ 0>
			<TD><B>There isn't a speaker available to speak on this day for this product.</B></TD>
		<cfelseif #GetModerators.recordcount# LT 1>
			<TD><B>There isn't a moderater available to moderate for this day and product.</B></TD>
		<cfelseif #GetSpeakers.recordcount# LT 1 AND #GetModerators.recordcount# LT 1 AND #ListFindNoCase("#session.nospeaker#", "#right(session.project_code,2)#")# EQ 0>
			<TD><B>There is neither a speaker or moderater available to for this day and product.</B></TD>
		</cfif>
	</TR>
</table>




<cfelse> ---><!---There is a Speaker and Moderator Available for this meeting---->
	<FORM NAME="meeting_popup" METHOD=POST>
	<CENTER>
	<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" style="font-family:verdana; font-size:11px;">
		<TR>
			<TD WIDTH="100">&nbsp;</TD>
		</TR>
		<TR>
			<TD><B>Begin Time</B></TD>
		</TR>
		<TR>
			<TD>
				<TABLE style="font-family:verdana; font-size:11px;">
					<TR>
						<TD><B>Hour:</B></TD>
						<TD><B>Minute:</B></TD>
						<TD><B>&nbsp;</B></TD>
					</TR>
					<TR>
						<TD>
							<SELECT NAME="begin_hour" onchange="ChangeEndHour()">
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
			<TD class="HeadingCell"><B>End Time</B></TD>
		</TR>
		<TR>
			<TD>
				<TABLE style="font-family:verdana; font-size:11px;">
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
		<TR>
			<TD class="HeadingCell"><B>Sequence</B></TD>
		</TR>
		<TR>
			<TD>			
				<TABLE>
					<TR>
						<TD>
						<SELECT NAME="GetSequence">
							<option value="A">A
							<option value="B">B
							<option value="C">C
							<option value="D">D
							<option value="E">E
							<option value="F">F
						</SELECT>
						</TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		<TR>
			<TD class="HeadingCell"><B>Moderator</B></TD>
		</TR>
		<TR>
			<TD>			
				<TABLE style="font-family:verdana; font-size:11px;">
					<TR>
						<TD>
						<SELECT NAME="GetModerators">
							<option value="NULL">(Select Moderator)
							<option value="0">TBD
							<CFOUTPUT QUERY="GetModerators">
								<option value="#GetModerators.moderrow#">#lastname#, #firstname# - #DollarFormat(GetModerators.fee)#
							</CFOUTPUT>
						</SELECT>
						</TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		<TR>
			<TD class="HeadingCell"><B>Speaker</B></TD>
		</TR>
		<TR>
			<TD>
				
				<TABLE style="font-family:verdana; font-size:11px;">
					<TR>
						<TD>
						<!--- if this project does not need a speaker, display n/a and hidden
						field that sets speaker id to 1 --->
						<cfif ListFindNoCase("#session.nospeaker#", "#right(session.project_code,2)#") GT 0>
							N/A
							<input type="hidden" name="GetSpeakers" value="1">
						<cfelse>
							<SELECT NAME="GetSpeakers">
								<option value="NULL">(Select Speaker)
								<option value="0">TBD
								<CFOUTPUT QUERY="GetSpeakers">
									<option value="#GetSpeakers.spkrrow#">#lastname#, #firstname# - #DollarFormat(GetSpeakers.fee)#
								</CFOUTPUT>
							</SELECT>
						</cfif>
						
						</TD>
					</TR>
				</TABLE>
			</TD>						
		</TR>
		<TR>
			<TD class="HeadingCell"><B>Is this meeting for training purposes only?</B></TD>
		</TR>
		<TR>
			<TD>
				
				<TABLE style="font-family:verdana; font-size:11px;">
					<TR>
						<TD>
						<input class="invis" type="radio" value="0" name="meeting_use" checked>No
						<input class="invis" type="radio" value="1" name="meeting_use">Yes						
						</TD>
					</TR>
				</TABLE>
			</TD>						
		</TR>
		<TR>
			<TD class="HeadingCell"><strong>Remarks/Notes</strong></TD>
		</TR>
		<TR>
			<TD>
				<TABLE style="font-family:verdana; font-size:11px;">
					<TR>
						<TD class="TextAreaCell">
							<textarea rows="3" cols="20" Name="remarks" title="Add Meeting Remarks or Comments Here"></textarea>
						</TD>
					</TR>
				</TABLE>	
			</TD>
		</TR>
	</TABLE>
	<CFOUTPUT QUERY="GetRowid"><INPUT TYPE="hidden" VALUE="#GetRowid.project_code#" NAME="project_code"></CFOUTPUT>
	<CFOUTPUT QUERY="GetRowid"><INPUT TYPE="hidden" VALUE="#GetRowid.rowid#" NAME="rowid"></CFOUTPUT>
	<INPUT TYPe="button" VALUE="Update Meeting Times" NAME="send_text" onclick="doIT();"><BR>
	<INPUT TYPe="button" VALUE="   CANCEL   " NAME="" onclick="window.close()">
	</CENTER>
	</FORM>
<!--- </cfif> --->
</BODY>
</HTML>