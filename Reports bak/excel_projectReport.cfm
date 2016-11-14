<!---
	*****************************************************************************************
	Name:		excel_attendance_report.cfm

	Function:	The function of this page is to translate the Attendee Report from html
				to excel.

	History:	ts20040518 - finalized code

	*****************************************************************************************
--->

<cfset excel_report_path = "#application.REPORTPATH#\rpt_temp.htm">

<cfif NOT isDefined("URL.report")>
	<cfabort>
</cfif>

<html>
<head>
<title></title>
<style>TD {font-family:Andale Mono; font-size:7pt; border:.5pt solid windowtext;}</style>
</head>

		<cfset OutputArray = ArrayNew(1)>
		<cfset count = 1>

		<cfset OutputArray[count] = "<html><head></head><body><TABLE BORDER='1' CELLSPACING='0' CELLPADDING='0'><TR><tr><tr><td><strong>Project Name</strong></td><td><strong>Project Code</strong></td><td><strong>Date</strong></td><td><strong>Time</strong></td><td><strong>Disconnect ##</strong></td><td><strong>Speaker Call-In ##</strong></td><td><strong>Speaker Name</strong></td><td><strong>Moderator Name</strong></td></tr>">

<!--- output row at a time here --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qGetMeetingCodes">
select distinct(meeting_code) as meeting_code,ltrim(cc.client_code_description) as project,
p.project_code,smt.meeting_date as date,smt.start_time as time,
p.helpline,p.speaker_listenins
from schedule_meeting_time smt, piw p,speaker.dbo.spkr_table sp,client_proj cp,client_code cc
where smt.project_code = p.project_code
and meeting_date between '#url.sSD#' and '#url.sED#'
and cp.client_proj = p.project_code
and cc.client_code = cp.client_code
</CFQUERY>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="qGetMods">
select distinct(meeting_code) as meeting_code,ltrim(cc.client_code_description) as project,
p.project_code,smt.meeting_date as date,smt.start_time as time,staff_id,smt.staff_type,sp.firstname,sp.lastname,
p.helpline,p.speaker_listenins
from schedule_meeting_time smt, piw p,speaker.dbo.spkr_table sp,client_proj cp,client_code cc
where smt.project_code = p.project_code
and meeting_date between '#url.sSD#' and '#url.sED#'
and smt.staff_id = sp.speaker_id
and cp.client_proj = p.project_code
and cc.client_code = cp.client_code
and smt.staff_type = 1
</cfquery>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="qGetSpkrs">
select distinct(meeting_code) as meeting_code,ltrim(cc.client_code_description) as project,
p.project_code,smt.meeting_date as date,smt.start_time as time,staff_id,smt.staff_type,sp.firstname,sp.lastname,
p.helpline,p.speaker_listenins
from schedule_meeting_time smt, piw p,speaker.dbo.spkr_table sp,client_proj cp,client_code cc
where smt.project_code = p.project_code
and meeting_date between '#url.sSD#' and '#url.sED#'
and smt.staff_id = sp.speaker_id
and cp.client_proj = p.project_code
and cc.client_code = cp.client_code
and smt.staff_type = 2
</cfquery>

<!--- Declare the array --->
<cfset modsArr=arraynew(2)>
<cfset spkrsArr=arraynew(2)>
<cfset meetingArr=arraynew(2)>

<!--- Populate the array row by row --->
<cfloop query="qGetMeetingCodes">
	<cfset meetingArr[CurrentRow][1]=meeting_code>
	<cfset meetingArr[CurrentRow][2]=project>
	<cfset meetingArr[CurrentRow][3]=project_code>
	<cfset meetingArr[CurrentRow][4]=date>
	<cfset meetingArr[CurrentRow][5]=time>
	<cfset meetingArr[CurrentRow][6]=helpline>
	<cfset meetingArr[CurrentRow][7]=speaker_listenins>
</cfloop>

<cfloop query="qGetMods">
  <cfset modsArr[CurrentRow][1]=meeting_code>
  <cfset modsArr[CurrentRow][2]=project>
  <cfset modsArr[CurrentRow][3]=project_code>
  <cfset modsArr[CurrentRow][4]=time>
  <cfset modsArr[CurrentRow][5]=firstname>
  <cfset modsArr[CurrentRow][6]=lastname>
  <cfset modsArr[CurrentRow][7]=helpline>
  <cfset modsArr[CurrentRow][8]=speaker_listenins>
  <cfset modsArr[CurrentRow][9]=staff_type>
</cfloop>

<cfloop query="qGetSpkrs">
  <cfset spkrsArr[CurrentRow][1]=meeting_code>
  <cfset spkrsArr[CurrentRow][2]=project>
  <cfset spkrsArr[CurrentRow][3]=project_code>
  <cfset spkrsArr[CurrentRow][4]=time>
  <cfset spkrsArr[CurrentRow][5]=firstname>
  <cfset spkrsArr[CurrentRow][6]=lastname>
  <cfset spkrsArr[CurrentRow][7]=helpline>
  <cfset spkrsArr[CurrentRow][8]=speaker_listenins>
  <cfset spkrsArr[CurrentRow][9]=staff_type>
  <cfset spkrsArr[CurrentRow][10]=staff_id>
</cfloop>
<br><br><br><br>

<cfscript>
spkrRow = 0;
modRow = 0;
mySpkrArrayLen = qGetSpkrs.recordcount;
myModArrayLen = qGetMods.recordcount;
myMeetingArrayLen = qGetMeetingCodes.recordcount;


for(Loop1=1; Loop1 LTE myMeetingArrayLen; Loop1 = Loop1 + 1)
{
	for(Loop2=1; Loop2 LTE mySpkrArrayLen; Loop2 = Loop2 + 1)
	{
		if (mid(meetingArr[loop1][1],8,2) EQ "CT")
		{

			meetingArr[Loop1][8]="";
			meetingArr[Loop1][9]="";
			break;
		}

		if (meetingArr[loop1][1] EQ spkrsArr[loop2][1])
		{
			//writeOutput("<b>" &  meetingArr[loop1][1] &":"& modsArr[loop2][1] & "</b><bR>");
			meetingArr[Loop1][8]=spkrsArr[Loop2][5];
			meetingArr[Loop1][9]=spkrsArr[Loop2][6];
			break;
		}

	}
	for(Loop2=1; Loop2 LTE myModArrayLen; Loop2 = Loop2 + 1)
	{
		//writeOutput(meetingArr[loop1][1] &":"& modsArr[loop2][1] & "<bR>");
		if (meetingArr[loop1][1] EQ modsArr[loop2][1])
		{
			//writeOutput("<b>" &  meetingArr[loop1][1] &":"& modsArr[loop2][1] & "</b><bR>");
			meetingArr[Loop1][10]=modsArr[Loop2][5];
			meetingArr[Loop1][11]=modsArr[Loop2][6];
			break;
		}
	}
}

//clean speakersArr
for(Loop1=1; Loop1 LTE myMeetingArrayLen; Loop1 = Loop1 + 1)
	{
		try
		  {
					tmp = len(meetingArr[Loop1][8]);
		  }
		  catch(Any excpt)
		  {
					meetingArr[Loop1][8]="";
					meetingArr[Loop1][9]="";
		  }
	}
for(Loop1=1; Loop1 LTE myMeetingArrayLen; Loop1 = Loop1 + 1)
	{
		try
		  {
					tmp = len(meetingArr[Loop1][10]);
		  }
		  catch(Any excpt)
		  {
					meetingArr[Loop1][10]="";
					meetingArr[Loop1][11]="";
		  }
	}
</cfscript>

<cfoutput>
<cfloop index="OuterCounter" from="1" to="#ArrayLen(meetingArr)#">
<cfset projectname = meetingArr[OuterCounter][2]>
<cfset projectcode = meetingArr[OuterCounter][3]>
<cfset date = DateFormat((meetingArr[OuterCounter][4]), 'mm/dd/yy')>
<cfset hour = left(#meetingArr[OuterCounter][5]#,2)>
<cfset minute = right(#meetingArr[OuterCounter][5]#,2)>
<cfset ampm = "AM">
<cfif hour GT 12>
<cfset hour = hour mod 12><cfset ampm = "PM">
<cfif minute EQ 00><cfset minute = 00></cfif>
<cfif minute EQ 25><cfset minute = 15></cfif>
<cfif minute EQ 50><cfset minute = 30></cfif>
<cfif minute EQ 75><cfset minute = 45></cfif>
</cfif>
<cfset time ="">
<cfscript>time = Hour & ":" & minute & " " & ampm & " ET";</cfscript>
<cfset disconnect = #meetingArr[OuterCounter][6]#>
<cfscript>
if (disconnect GT 9)
disconnect = "(" & Left(disconnect, 3) & ") " & Mid(disconnect, 4, 3) & "-" & Mid(disconnect, 6,4);
</cfscript>
<cfset speaker_callin = #meetingArr[OuterCounter][7]#>

#OuterCounter#- #meetingArr[OuterCounter][1]# <br>

<cfscript>
if (speaker_callin GT 9)
speaker_callin = "(" & Left(speaker_callin, 3) & ") " & Mid(speaker_callin, 4, 3) & "-" & Mid(speaker_callin, 6,4);
spkrName = meetingArr[OuterCounter][8] & " " & meetingArr[OuterCounter][9];
modName = meetingArr[OuterCounter][10] & " " & meetingArr[OuterCounter][11];
</cfscript>

<cfset OutputArray[OuterCounter + 1] = "<tr><td>#projectname#&nbsp;</td><td>#projectcode#&nbsp;</td><td>#date#&nbsp;</td><td>#time#&nbsp;</td><td>#disconnect#&nbsp;</td><td>#speaker_callin#&nbsp;</td><td>#spkrName#&nbsp;</td><td>#modName#&nbsp;</td></tr>">
</cfloop>
</cfoutput>


<!--- finish here ---->
		<cfset count = #OuterCounter# + 1>
		<cfset OutputArray[count] = "</table>">

		<cfset temp = #ArrayToList(OutputArray, " ")#>

		<cftry>
		<cffile action="write" file="#excel_report_path#" nameconflict="overwrite" output="#temp#">
		<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#excel_report_path#">
		</cfcontent>
		<cfcatch type="any">wrong</cfcatch>
		</cftry>


<br><br>
<center>
<input type="button"  value=" Go Back " onclick="document.location.href='rpt_project.cfm'"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="button"  value=" Print " onclick="javascript: window.print();"></center>
</body>
</html>
