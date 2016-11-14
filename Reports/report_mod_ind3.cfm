<!--- 
	*****************************************************************************************
	Name:		report_mod_ind.cfm		
	Function:	pulls individual speaker schedule - this week, one week prior and two weeks after	
	
	*****************************************************************************************
--->


<HTML>
<HEAD>
<TITLE>Moderator Schedule</TITLE>
<STYLE>
TD 
{
	font-family : Verdana, Geneva, Arial;
	font-size : xx-small;
	text-align: left;
	background-color: #FFFFFF;
}

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

<!--- ***** This is for testing purposes. Needs to equal user id 
User name must go to speaker table and pull out speaker id. speaker id does not 
match user id*****--->
<cfset session.id = 5159>
 <!--- *************************************************** --->
</HEAD>

<BODY BGCOLOR="FFFFFF" MARGINHEIGHT="0" MARGINWIDTH="0">

<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getModName'>
	SELECT firstname, lastname, speakerid
	FROM Speaker
	WHERE speakerid = #session.id#
</CFQUERY>

<cfoutput>
	<center>
		<div style="font-size: 16px; font-family: arial; font-weight: bold; padding-bottom: 7px; color: ##000000; border-bottom: solid 1px ##000000;" width="100%">
			#getModName.firstname# #getModName.lastname# - Meeting Schedule<br>
			#form.begin_date# &mdash; #form.end_date#
		</div>
	</center>
</cfoutput>

<cfset B_Month = #Month(form.begin_date)#>
<cfset B_Day = #Day(form.begin_date)#>
<cfset B_Year = #Year(form.begin_date)#>
<cfset E_Month = #Month(form.end_date)#>
<cfset E_Day = #Day(form.end_date)#>
<cfset E_Year = #Year(form.end_date)#>

<cfset BeginingDate = CreateDate(Year(form.begin_date), Month(form.begin_date), Day(form.begin_date))>
<cfset EndingDate = CreateDate(Year(form.end_date), Month(form.end_date), Day(form.end_date))>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetMeetings">
	SELECT *
	FROM ScheduleSpeaker
	WHERE speakerid = #session.id#
	AND meeting_date BETWEEN #BeginingDate# AND #EndingDate#
	ORDER BY meeting_date
</CFQUERY>

<table border="0" cellpadding="0" cellspacing="0" width="600px" align="center" style="margin-top: 10px; font-size: 14px;">
	<tr>
		<td style="border-bottom: solid 1px #000000;"><strong>Date</strong></td>
		<td style="border-bottom: solid 1px #000000;"><strong>Project Code</strong></td>
		<td style="border-bottom: solid 1px #000000;"><strong>Meeting Times</strong></td>
		<td style="border-bottom: solid 1px #000000;"><strong>Speaker</strong></td>
	</tr>
	<cfscript>
		oCivTime = createObject('component','pms.com.cfc_time_conversion');
	</cfscript>
	<cfoutput query="GetMeetings">
	<cfscript>
		CivilianTime = oCivTime.toCivilian(BeginMilitary='#getMeetings.start_time#',EndMilitary='#getMeetings.end_time#');
		TheTime = oCivTime.ConCatTime(cfcTime='#CivilianTime#');
	</cfscript>
	
	<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getSpeaker'>
		SELECT firstname, lastname
		FROM Speaker
		WHERE speakerid = #GetMeetings.speakerid#
	</CFQUERY>
	<tr>
		<td style="padding-top: 5px">#DateFormat(GetMeetings.meeting_date, "mm/dd/yyyy")#</td>
		<td style="padding-top: 5px">#GetMeetings.project_code#</td>
		<td style="padding-top: 5px">#TheTime# EST</td>
		<td style="padding-top: 5px">
		<cfif getSpeaker.recordcount>
			#getSpeaker.firstname# #getSpeaker.lastname#
		<cfelse>
			-
		</cfif>
		</td>
	</tr>
</cfoutput>
</table>
<p>&nbsp;</p>
<center>
	<input type="submit" value=" Print " onclick="javascript:window.print()">
</center>
</body>
</html>
