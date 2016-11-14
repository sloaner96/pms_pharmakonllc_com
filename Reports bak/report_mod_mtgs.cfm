<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->
<cfparam name="URL.Action" default=""> 

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Meetings Per Moderator Report" showCalendar="1">

<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
			
<!--- Saves all data inputted from the above form --->
<CFCASE VALUE="report">

<STYLE>

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

</HEAD>


<cfset B_Month = #Month(form.begin_date)#>
<cfset B_Day = #Day(form.begin_date)#>
<cfset B_Year = #Year(form.begin_date)#>
<cfset E_Month = #Month(form.end_date)#>
<cfset E_Day = #Day(form.end_date)#>
<cfset E_Year = #Year(form.end_date)#>

<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>

<!--- get moderator --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetName">
	SELECT firstname, lastname, speaker_id
	FROM spkr_table
	WHERE type='MOD' AND active = 'ACT'
	ORDER BY lastname, firstname
</CFQUERY>
			
<TABLE ALIGN="center" WIDTH="100%" CELLPADDING="5" CELLSPACING="1">
<TR>
	<TD colspan="2">
		<strong>Meetings Per Moderator<BR>
		<cfif form.proj_code EQ 0>
		All Projects<br>
		<cfelse>
		<cfoutput>#form.proj_code#</cfoutput><br>
		</cfif>
		<cfoutput>#form.begin_date# &mdash; #form.end_date#</cfoutput></strong>
	</TD> 
</TR>
<TR  bgcolor="#444444">
	<TD><strong style="color:#ffffff;">Moderator</strong></TD>
	<TD><strong style="color:#ffffff;"># of meetings</strong></TD>
</tr>	
	<cfoutput query="getName">
		<CFQUERY DATASOURCE="#Application.projdsn#" NAME="getMeetingCount">
			SELECT COUNT(DISTINCT(meeting_code)) as meetCount
			FROM schedule_meeting_time
			WHERE meeting_date BETWEEN #BeginingDate# AND #EndingDate#
			AND status = 0 
			<!--- AND moderator_id = #GetName.speaker_id# --->
			AND staff_id = #GetName.speaker_id# AND staff_type = 1 
			<cfif #form.proj_code# NEQ 0>AND project_code = '#form.proj_code#'</cfif>
		</CFQUERY>
		<TR <cfif getName.currentrow MOD(2) EQ 0>bgcolor="##eeeeee"</cfif>>
			<TD>#trim(getName.firstname)# #trim(getName.lastname)#</TD>
			<TD>#getMeetingCount.meetCount#</TD>
		</TR>
	</CFOUTPUT>
</table>
<p>&nbsp;</p>
<center>
<cfchart chartHeight="400" chartWidth="600" show3d="yes" scalefrom="0">
<cfchartseries type="bar" seriesColor="##006699"> 
<cfoutput query="getName">
	<CFQUERY DATASOURCE="#Application.projdsn#" NAME='getMeetingCount' USERNAME='#session.dbu#' PASSWORD='#session.dbp#'>
		SELECT COUNT(project_code) as meetCount
		FROM schedule_meeting_time
		WHERE meeting_date BETWEEN #BeginingDate# AND #EndingDate#
		AND status = 0 
		AND staff_id = #GetName.speaker_id# AND staff_type = 1
		<!--- AND moderator_id = #GetName.speaker_id# ---> 
		<cfif #form.proj_code# NEQ 0>AND project_code = '#form.proj_code#'</cfif>
	</CFQUERY>

	<cfchartdata item="#trim(getName.firstname)# #trim(getName.lastname)#" value="#getMeetingCount.meetCount#">
	</CFOUTPUT>
</cfchartseries>
</cfchart>
</center>
<br><br>
<center><input type="button"  value=" Print " onclick="window.print()"></center>
<p>&nbsp;</p>
</BODY>
</HTML>
		
</CFCASE>

	
	
<!--- If no case is specified user is sent to data entry part of page --->
<!--- Allows user to select months in which meetings will occur --->
<CFDEFAULTCASE>

<SCRIPT>
function CheckDates(oForm)
{
	var Bdate = oForm.begin_date.value;
	var Edate = oForm.end_date.value
	var B_ASCIICode = Bdate.charCodeAt();
	var E_ASCIICode = Edate.charCodeAt();
	
	if(Bdate == "" || B_ASCIICode == 32)
	{
		alert("Please enter a begining date.");
		return false;
	}
	else if(Edate == "" || E_ASCIICode == 32)
	{
		alert("Please enter an ending date.");
		return false;
	}
	else
	{
		return true;
	}
}
</SCRIPT>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
	SELECT project_code
	FROM piw
	ORDER BY project_code
</CFQUERY>

<FORM NAME="form" ACTION="report_mod_mtgs.cfm?action=report" METHOD="post" onSubmit="return CheckDates(this)">
<cfset curYear = Year(Now())>
<cfset beginingdate = #CreateDate(curYear, 1, 1)#>
<cfset endingdate = Now()>				
		<TABLE ALIGN="Center" BORDER="0" CELLSPACING="1" CELLPADDING="10">
			<TR>
				<TD ALIGN="Center">
						<font color="##990000"><strong>Project Code</strong></font>&nbsp;&nbsp;&nbsp;
						<SELECT NAME="proj_code" SIZE="1">
							<OPTION value="0">All Projects</OPTION>
							<CFOUTPUT QUERY="get_projectcode">
								<OPTION <CFIF (isDefined("session.project_code")) AND (session.project_code EQ trim(project_code))>SELECTED</CFIF>>#trim(project_code)#</OPTION>
							</CFOUTPUT>
						</SELECT>
				</TD>
			</TR>
			<TR>
				<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;">
					<B>Begin Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
						<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						          inputname="begin_date"
								  htmlID="begindate"
								  FormValue="#DateFormat(beginingdate, 'mm/dd/yyyy')#"
								  imgid="begindatebtn">
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<B>End Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
						<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						          inputname="end_date"
								  htmlID="enddate"
								  FormValue="#DateFormat(endingdate, 'mm/dd/yyyy')#"
								  imgid="enddatebtn"></td>
			</TR>
			<TR>
				<TD ALIGN="center">
					<INPUT TYPE="submit" NAME="submit"  VALUE="  Start Report  ">
				</TD>
			</TR>
		</TABLE>

</FORM>

</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
