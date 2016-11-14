<!--- 
	*****************************************************************************************
	Name:		
	Function:	
	History:	Finalized code 8/28/01 TJS
	
	*****************************************************************************************
--->

<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
			
	<!--- Saves all data inputted from the above form --->
	<CFCASE VALUE="report">
	
		<!--- Defines variables needed within the page both from the previous form and URL --->
		<cfset B_Month = #Month(form.begin_date)#>
		<cfset B_Day = #Day(form.begin_date)#>
		<cfset B_Year = #Year(form.begin_date)#>
		<cfset E_Month = #Month(form.end_date)#>
		<cfset E_Day = #Day(form.end_date)#>
		<cfset E_Year = #Year(form.end_date)#>
		<CFSET session.project_code= "#form.project_code#">
		
		<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
		<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>



	
<CFQUERY DATASOURCE="#application.projdsn#" NAME="meetingDT">
	SELECT *
	FROM schedule_meeting_time
	WHERE (meeting_date BETWEEN #BeginingDate# AND #EndingDate#)
	AND status = 0 
	<cfif session.project_code GT 0>AND project_code = '#session.project_code#'</cfif>
	ORDER BY meeting_date, start_time, project_code
</CFQUERY>

<cfset OutputArray = ArrayNew(1)>
<cfset x = 1>

<cfset OutputArray[x] = "<HTML><HEAD></HEAD><BODY>">
<cfset x = #x# + 1>

<cfset OutputArray[x] = "<TABLE border='1' cellpadding='4px'><TR><TD colspan='15' bgcolor='##CCCCCC' style='font-size: 14pt;'><strong>Scheduled Meetings -- #DateFormat(BeginingDate, 'm/d/yy')# - #DateFormat(EndingDate, 'm/d/yy')#<br>">
<cfset x = #x# + 1>

<cfif session.project_code GT 0>
	<cfset OutputArray[x] = "for Project Code: <cfoutput>#session.project_code#</cfoutput></strong>">
	<cfset x = #x# + 1>
<cfelse>
	<cfset OutputArray[x] = "All Projects</strong>">
	<cfset x = #x# + 1>
</cfif>

<cfset OutputArray[x] = "</TD></TR>">
<cfset x = #x# + 1>

<!--- this method converts military time to civilian time --->
<cfinvoke
component="pms.com.cfc_time_conversion" 
method="toCivilian" 
BeginMilitary="#meetingDT.start_time#"
EndMilitary="#meetingDT.end_time#"
returnvariable="CivilianTimeArray"
>		

<cfset OutputArray[x] = "<TR><TD><strong>Project Code</strong></TD><TD><strong>Date</strong></TD><TD><strong>Time</strong></TD>">
<cfset x = #x# + 1>

<cfset OutputArray[x] = "<TD><strong>Moderator</strong></TD><TD><strong>Moderator Honoraria</strong></TD><TD><strong>Speaker</strong></TD><TD><strong>Speaker Honoraria</strong></TD><TD><strong>Additional Speaker</strong></TD><TD><strong>Additional Speaker Hono</strong></TD>">
<cfset x = #x# + 1>

<cfset OutputArray[x] = "<TD><strong>Speaker Listen Ins</strong></TD><TD><strong>Speaker Listen In Honoraria</strong></TD><TD><strong>Moderator Listen Ins</strong></TD><TD><strong>Moderator Listen In Honoraria</strong></TD>">
<cfset x = #x# + 1>

<cfset OutputArray[x] = "<TD><strong>Trainees</strong></TD><TD><strong>Trainees Honoraria</strong></TD></TR>">
<cfset x = #x# + 1>	
	
<cfscript>
	oSpkrMod = createObject("component","pms.com.cfc_get_piwinfo");
</cfscript>

<CFOUTPUT QUERY="meetingDT">

	<cfscript>
		GetMod = oSpkrMod.getModSpker(cfcID="#meetingDT.moderator_id#");
		GetModHono = oSpkrMod.getHonoraria(cfcRowID="#meetingDT.mod_client_rowid#");
		GetSpkr = oSpkrMod.getModSpker(cfcID="#meetingDT.speaker_id#");
		SpeakerHono = oSpkrMod.getHonoraria(cfcRowID="#meetingDT.spkr_client_rowid#");
		GetAddSpkr = oSpkrMod.getAdditionalSpeakers(cfcRow_ID="#meetingDT.rowid#");
		AddSpkrHono = oSpkrMod.getAdditionalSpeakerHono(cfcMeetingRowID="#meetingDT.rowid#");
		ClientLis = oSpkrMod.getSpkrListens(cfcRowID="#meetingDT.rowid#");
		ClientLisHono = oSpkrMod.getAdditionalListenHono(cfcMeetingRowID="#meetingDT.rowid#");
		ModLis = oSpkrMod.getModListens(cfcRowID="#meetingDT.rowid#");
		AddModHono = oSpkrMod.getAdditionalListenHono(cfcMeetingRowID="#meetingDT.rowid#");
		Trainees = oSpkrMod.getTrainees(cfcRowID="#meetingDT.rowid#");
		TraineesHono = oSpkrMod.getTraineesHono(cfcMeetingRowID="#meetingDT.rowid#");
	</cfscript>
	
<cfset OutputArray[x] = "<TR><TD>#meetingDT.project_code#</TD>">
<cfset x = #x# + 1>
			
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
	
<cfset OutputArray[x] = "<TD>#meetingDT.month#/#meetingDT.day#/#meetingDT.year#</TD><TD>#TheTime# EST</TD><TD>#GetMod#</TD><TD>#DollarFormat(GetModHono)#</TD>">
<cfset x = #x# + 1>

<cfset OutputArray[x] = "<TD>#GetSpkr#</TD><TD>#DollarFormat(SpeakerHono)#</TD>">
<cfset x = #x# + 1>

<cfif #GetAddSpkr# NEQ "">
	<cfset OutputArray[x] = "<TD>#GetAddSpkr#</TD><TD>#DollarFormat(AddSpkrHono)#</TD>">
	<cfset x = #x# + 1>
<cfelse>
	<cfset OutputArray[x] = "<TD>&nbsp;</TD><TD>&nbsp;</TD>">
	<cfset x = #x# + 1>
</cfif>

<cfif #ClientLis# NEQ "">
	<cfset OutputArray[x] = "<TD>#ClientLis#</TD><TD>#DollarFormat(ClientLisHono)#</TD>">
	<cfset x = #x# + 1>
<cfelse>
	<cfset OutputArray[x] = "<TD>&nbsp;</TD><TD>&nbsp;</TD>">
	<cfset x = #x# + 1>
</cfif>

<cfif #ModLis# NEQ "">
	<cfset OutputArray[x] = "<TD>#ModLis#</TD><TD>#DollarFormat(AddModHono)#</TD>">
	<cfset x = #x# + 1>
<cfelse>
	<cfset OutputArray[x] = "<TD>&nbsp;</TD><TD>&nbsp;</TD>">
	<cfset x = #x# + 1>
</cfif>

<cfif #Trainees# NEQ "">
	<cfset OutputArray[x] = "<TD>#Trainees#</TD><TD>#DollarFormat(TraineesHono)#</TD></TR>">
	<cfset x = #x# + 1>
<cfelse>
	<cfset OutputArray[x] = "<TD>&nbsp;</TD><TD>&nbsp;</TD></TR>">
	<cfset x = #x# + 1>
</cfif>


</CFOUTPUT>

<cfset OutputArray[x] = "</TABLE></BODY></HTML>">

<cfset temp = #ArrayToList(OutputArray, " ")#>
<cfset report_path = "E:\INETPUB\WWWROOT\projects\cgi-bin\temp\rpt_temp.doc">
<cffile action="write" file="#report_path#" nameconflict="overwrite" output="#temp#">
<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#report_path#">

</CFCASE>


<!--- If no case is specified user is sent to data entry part of page --->
<!--- Allows user to select months in which meetings will occur --->
<CFDEFAULTCASE>

<HTML>
<HEAD>
<TITLE>Project Management System || Project Report</TITLE>
<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
<script language="JavaScript">
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
</script>
<SCRIPT SRC="/includes/libraries/CallCal.js"></SCRIPT>
</HEAD>
<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
	SELECT project_code
	FROM piw
	ORDER BY project_code
</CFQUERY>
<BODY>
<cfset beginingdate = #DateAdd("d", -7, Now())#>
<cfset endingdate = Now()>
<CFOUTPUT><FORM NAME="form" ACTION="report_pc.cfm?action=report" METHOD="post" onSubmit="return CheckDates(this)"></CFOUTPUT>

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
						<font color="##990000"><strong>Project Code</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<SELECT NAME="project_code" SIZE="1">
								<Option value="0">All Projects</Option>
							<CFOUTPUT QUERY="get_projectcode">
								<OPTION <CFIF (isDefined("session.project_code")) AND (session.project_code EQ trim(project_code))>SELECTED</CFIF>>#trim(project_code)#</OPTION>
							</CFOUTPUT>
						</SELECT>
				</TD>
			</TR>
			
			<TR>
				<TD ALIGN="Center">
					<font color="##990000"><strong>Begining Date</strong></font>&nbsp;&nbsp;
					<input type="text" name="begin_date" size="12" maxlength="12" onClick="CallCal(this)" value="<cfoutput>#DateFormat(beginingdate, "mm/dd/yyyy")#</cfoutput>">
					&nbsp; &nbsp;
					<font color="##990000"><strong>Ending Date</strong></font>&nbsp;&nbsp;
					<input type="text" name="end_date" size="12" maxlength="12" onClick="CallCal(this)" value="<cfoutput>#DateFormat(endingdate, "mm/dd/yyyy")#</cfoutput>">	
				</TD>
			</TR>						
			<TR>
				<TD ALIGN="center">
					<INPUT TYPE="submit" NAME="submit"  VALUE="  Generate Excel Report  ">
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
