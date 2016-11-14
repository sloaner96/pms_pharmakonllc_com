 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Download Schedule Spreadsheet" showCalendar="1">

		
<!--- <CFDEFAULTCASE> --->
	<SCRIPT SRC="/includes/libraries/CallCal.js"></SCRIPT>
	<SCRIPT SRC="/includes/libraries/confirm.js"></SCRIPT>
	<SCRIPT>
	function validate(f) 
	{			
		var sbdate = f.begin_date.value;
		var sedate = f.end_date.value;
		
		if (f.begin_date.value == "" || f.begin_date.value == " " || sbdate.length < 6)
		{
			alert("Please select a beginning date!"); 
			return false;
		}

		if (f.end_date.value == "" || f.end_date.value == " " || sedate.length < 6)
		{
			alert("Please select an ending date!"); 
			return false;
		}
		
		sbdate = sbdate.split("/"); //Break starting date into array
		sedate = sedate.split("/");  //Bread ending date inot array
		
		
		for(i=0; i<sbdate.length; i++)
		{
			sbdate[i] = parseInt(sbdate[i]) //turn all string into integers
		}
		
		for(j=0; j<sedate.length; j++)
		{
			sedate[j] = parseInt(sedate[j]) //turn all string into integers
		}
		
		
		if(sbdate[2] < sedate[2]) //begining year is less than ending year
		{
			return true;
		}
		else if(sbdate[2] == sedate[2]) //years are equal
		{
				if(sbdate[0] < sedate[0]) //begining month is less than ending month
				{
					if(sbdate[1] < sedate[1]) //begining day is less than ending day
					{
						return true;
					}
				}
				else if(sbdate[0] == sedate[0]) //begining month is equal to ending month
				{
					if(sbdate[1] <= sedate[1]) //begining day is less than or equal to ending day
					{
						return true;
					}
					else
					{
						alert("The Beginging Date is Later then the Ending Date!")
						return false;
					}
				}
				else //begining month is more than ending month in the same year
				{
					alert("The Beginging Date is Later then the Ending Date!")
					return false;
				}

		}
		else 
		{
			alert("The Beginging Date is Later then the Ending Date!");
			return false;
		}
		
	}
	</SCRIPT>
	</HEAD>
	<BODY>
	
	<div id="maintemplate" class="maintemplate">
	<div id="maintitle" class="maintitle"><strong style="font-size:14px;">Global Calendar</strong></div>
	<cfoutput>
	<div id="viewnav" class="viewNav">View:&nbsp;<a href="dsp_globalscheduleDay.cfm?month=#month#&Year=#year#"><u>Day</u></a>&nbsp;|&nbsp;<a href="dsp_globalScheduleWeek.cfm?month=#month#&Year=#year#"><u>Week</u></a>&nbsp;|&nbsp;<a href="dsp_globalschedule.cfm?month=#month#&Year=#year#"><u>Month</u></a>&nbsp;|&nbsp;<a href="dsp_globalScheduleYear.cfm?month=#url.month#&year=#url.year#"><u>Year</u></a>&nbsp;|&nbsp;<a href="javascript:openpopup3('new_meeting.cfm?month=#url.month#&year=#url.year#')"><u>Add a New Meeting</u></a><br><br></cfoutput>
<!--- 	<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetSchedule">
		Select month, year FROM schedule_meeting_date
		WHERE project_code = '#session.project_code#' 
		ORDER BY year, month
	</CFQUERY> --->
	<!--- <cfscript>
		ProjectName = createObject("component","pms.com.cfc_get_name");
		projName = ProjectName.getProjName(ProjCode="#session.Project_code#");
	</cfscript> --->
<!--- 	<TABLE ALIGN="Center" WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" style="margin-top: 10px">
	<tr>
		<td align="center">
		<cfoutput>#projName#</cfoutput>
		</td>
	</tr>
	</table><br> --->
<!--- 	<cfif GetSchedule.recordcount>
		<TABLE ALIGN="Center" WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" style="margin-top: 10px">
		<tr>
			<td align="center"><strong><font color="#cc0000#">A schedule has already been created for the following months:</font></strong></td>
		</tr>
		<tr>
			<td align="center">
				<cfoutput query="GetSchedule">
					<strong>#GetSchedule.month#/#GetSchedule.year# &nbsp;</strong>
				</cfoutput>
			</td>
		</tr>
		</table>
	</cfif> --->
	
	<FORM NAME="form" action="scheduleasExcel.cfm" METHOD="post" onSubmit="return validate(this);">
		<TABLE ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="400">
			<TR> 
				<TD CLASS="tdheader"><CFOUTPUT><font face="Verdana" color="000000">Select Start and End Dates</font></CFOUTPUT></TD>
			</TR>
			<TR> 
				<TD>	<!--- Table containing input fields --->
					<TABLE ALIGN="Center" WIDTH=300 CELLSPACING="0" CELLPADDING="5" BORDER="0">
					  <TR>
						 <TD colspan=2>&nbsp;</TD>
					  </TR>
					  <TR valign="middle">
						 <TD ALIGN=right><b>Beginning Date</b></td>
						 <td align=left><cfmodule template="#Application.TagPath#/ctags/CalInput.cfm" inputname="begin_date" htmlid="begindate" formvalue="" imgid="begindatebtn"></TD>
					  </TR>
					  <TR>
						 <TD ALIGN=right><b>Ending Date</b></td>
						 <td align=left><cfmodule template="#Application.TagPath#/ctags/CalInput.cfm" inputname="end_date" htmlid="enddate" formvalue="" imgid="enddatebtn"></td>
					  </TR>
					  <TR>
						 <TD colspan=2>&nbsp;</TD>
					  </TR>
					  <TR>
				    	 <TD ALIGN="center"><INPUT TYPE="submit" NAME="submit" VALUE="Submit"></TD>
						 <TD ALIGN="center"><INPUT TYPE="reset" NAME="cancel" VALUE=" Cancel " onclick="javascript:history.back(-1);"></TD>
					  </TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	 </form>
<!--- 	</CFDEFAULTCASE>
</CFSWITCH> --->
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
