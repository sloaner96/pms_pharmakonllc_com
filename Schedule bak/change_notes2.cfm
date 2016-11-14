

<CFQUERY DATASOURCE="#Application.WeeklyRptDSN#" NAME="qGetMeetingInfo">
SELECT upper(m.firstname + ' ' + m.lastname) as ModName,
upper(sp.firstname + ' ' + sp.lastname) as SpName,
s.remarks,s.project_code, s.sequence,
s.year, s.month, s.day, s.start_time, s.end_time, s.rowid, sp.speaker_id as spkrid, m.speaker_id as mod_id
FROM PMSProd.dbo.schedule_meeting_time s
LEFT OUTER JOIN speaker.dbo.spkr_table m
ON s.staff_id = m.speaker_id
LEFT OUTER JOIN speaker.dbo.spkr_table sp
ON s.speaker_id = sp.speaker_id
where s.project_code = '#session.project_code#'
and s.spkr_client_rowid is null
and s.year >= 2005
and s.month >= DATEPART ( mm , GETDATE() ) --returns month number (1->12)
<!---and s.day >= DATEPART ( dd , GETDATE() ) --return day number--->
order by s.project_code,s.sequence, s.year,s.month,s.day,s.start_time
</CFQUERY>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Change Speaker Notes" showCalendar="0">

<!--- <link href="simple.css" rel="stylesheet" type="text/css">

<link rel="alternate stylesheet" type="text/css" href="xsmallfont.css" title="xsmall" />
<link rel="stylesheet" type="text/css" href="xxsmallfont.css" title="xxsmall" />
<script src="styleswitcher.js" type="text/javascript"></script> --->

<form action="change_notes3.cfm" method="post">

<cfset i=0>
<cfif qGetMeetingInfo.recordcount GT 0>
<table border="0" cellpadding="2" cellspacing="1" width="100%" bgcolor="000000" style="font-family:verdana; font-size:10px;">
	<tr bgcolor="#eeeeee">
		<td style="border:0px;">&nbsp;</td>
		<td><strong>Date</strong></td>
		<td><strong>Time</strong></td>
		<td><strong>Sequence</strong></td>
		<td><strong>Moderator/Speaker</strong></td>
		
		<td><strong>Remarks</strong></td>
	</tr>

<cfloop query="qGetMeetingInfo">
<cfset i=i+1>
<cfoutput>


<cfif i EQ 1>

<!--- <span style="float: left;">Project Code: #project_code#</span>
<span style="float: right;margin-right:1cm;">
Change font size: <a href="##" onclick="setActiveStyleSheet('xxsmall'); return false;" style="font-size: 9px;">[A]</a> <a href="##" onclick="setActiveStyleSheet('xsmall'); return false;" style="font-size: 11px;">[A]</a>
</span> --->
</cfif>

    <cfset startHour = left(qGetMeetingInfo.start_time, 2)>
	
	<cfset startMinutes = right(qGetMeetingInfo.start_time, 2)>
	<cfif StartMinutes EQ 50>
	  <cfset StartMinutes = 30>
	</cfif>
	<cfif StartHour LTE 23>
		<cfset StartTimeString = "#startHour#:#startMinutes#">
		<cfset StartTime = CreateODBCTime(StartTimeString)>
		<cfset StartTime = TimeFormat(StartTime, 'hh:mm tt')>
	<cfelse>
	   <cfset StartTimeString = "00:#startMinutes#">
	   <cfset StartTime = CreateODBCTime(StartTimeString)>
	   <cfset StartTime = TimeFormat(StartTime, 'hh:mm tt')>
	</cfif>
	
	<cfset EndHour = left(qGetMeetingInfo.End_time, 2)>
	<cfset EndMinutes = right(qGetMeetingInfo.End_time, 2)>
	<cfif EndMinutes EQ 50>
	  <cfset EndMinutes = 30>
	</cfif>
	<cfif EndHour LTE 23>
	 <cfset EndTimeString = "#EndHour#:#EndMinutes#">
	 <cfset EndTime = CreateODBCTime(EndTimeString)>
	 <cfset EndTime = TimeFormat(EndTime, 'hh:mm tt')>
	<cfelse>
	  <cfset EndTimeString = "00:#EndMinutes#">
	 <cfset EndTime = CreateODBCTime(EndTimeString)>
	 <cfset EndTime = TimeFormat(EndTime, 'hh:mm tt')> 
	</cfif>
		<!--- pull speakers by client and availability --->
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
			SELECT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code, sc.rowid as spkrrow, sc.fee
			FROM availability a, spkr_table st, speaker_clients sc
			WHERE active = 'ACT' AND a.id = sc.owner_id
			AND sc.client_code = '#Left(session.project_code, 5)#'
			AND a.id = st.speaker_id
			AND a.year=#qGetMeetingInfo.year#
			AND a.month=#qGetMeetingInfo.month#
			AND a.x#qGetMeetingInfo.day#=1
			AND st.type='SPKR'
			ORDER BY st.lastname, st.firstname;
		</CFQUERY>


	<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerators">
		SELECT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code, sc.rowid as moderrow, sc.fee
		FROM availability a, spkr_table st, speaker_clients sc
		WHERE active = 'ACT' AND a.id = sc.owner_id
		AND sc.client_code = '#Left(session.project_code, 5)#'
		AND a.id = st.speaker_id
		AND a.year=#qGetMeetingInfo.year#
		AND a.month=#qGetMeetingInfo.month#
		AND a.x#qGetMeetingInfo.day#=1
		AND st.type='MOD'
		ORDER BY st.lastname, st.firstname;
	</CFQUERY>
    <cfset ThisModID = qGetMeetingInfo.Mod_ID>
	<cfset ThisSpkrID = qGetMeetingInfo.spkrid>
	
	<tr bgcolor="ffffff">
		<td class="leftcol">Edit: <input type="checkbox" name="c#i#"></td>
		<td class="leftcol">#qGetMeetingInfo.month#/#qGetMeetingInfo.day#/#qGetMeetingInfo.year#</td>
		<td class="leftcol">#starttime# - #endtime#</td>
		<td class="data">#qGetMeetingInfo.sequence#</td>
		<td class="data">
		  <table border="0" cellpaddding="0" cellspacing="0" width="100%">
            <tr bgcolor="eeeee">
			  <td><strong style="font-family:verdana;font-size:10px;">Moderator</strong></td>
			</tr>
			 <tr>
               <td class="data" align="left"><SELECT NAME="GetModerators_#i#" style="font-family:verdana;font-size:10px">
				<option value="">(Select Moderator)
				<CFloop QUERY="GetModerators">
					<option value="#GetModerators.speaker_id#" <cfif GetModerators.speaker_id EQ trim(thisModID)>selected</cfif>>#GetModerators.lastname#, #GetModerators.firstname# - #DollarFormat(GetModerators.fee)#
				</CFloop>
			</SELECT></td>
			
			  
			</tr>
			<tr bgcolor="eeeee">
			  <td><strong style="font-family:verdana;font-size:10px">Speaker:</strong></td>
			</tr>
			<tr>
			<td class="data"  align="left">
			<SELECT NAME="GetSpeakers_#i#" style="font-family:verdana;font-size:10px">
				<option value="">(Select Speaker)
				<CFloop QUERY="GetSpeakers">
					<option value="#GetSpeakers.speaker_ID#" <cfif GetSpeakers.speaker_ID EQ ThisSpkrID>selected</cfif>>#GetSpeakers.lastname#, #GetSpeakers.firstname# - #DollarFormat(GetSpeakers.fee)#
				</CFloop>
			</SELECT>
			   </td>   
             </tr>
          </table>           
		</td>
		<td class="data"><input type="hidden" value="#i#,#rowid#" name="iRowid#i#"><textarea name="inputArea#i#" rows="2" cols="40">#rtrim(remarks)#</textarea>&nbsp;</td>
	</tr>
	<!---(#rowid#) --->
</cfoutput>
</cfloop>
</table>
<input type="hidden" value="1" name="startCounter">
<input type="hidden" value="<cfoutput>#i#</cfoutput>" name="endCounter">
<br/>
<div style="margin-right:1cm;text-align:right"><input type="submit"></div>
<br/>
</form>
<cfelse>
 <div align="center"><strong style="color:f7f7f7;">There are no Speakers or Moderators for this meeting. <a href="##" onclick="javascript:history.back(-1);">Click here</a> to go back</strong></div>
</cfif>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
